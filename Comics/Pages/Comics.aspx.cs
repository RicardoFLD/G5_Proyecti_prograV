

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Comics.Data;
using System.IO;
using System.Diagnostics;

namespace Comics.Pages
{
    public partial class Comics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProductos();
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            string nombre = txtNombre.Text.Trim();
            string descripcion = txtDescripcion.Text.Trim();
            decimal precio;
            int cantidadEnStock;
            int idProveedor;

            // Verificar si todos los campos obligatorios están llenos y tienen formato correcto
            if (string.IsNullOrEmpty(nombre) || string.IsNullOrEmpty(descripcion) ||
                !decimal.TryParse(txtPrecio.Text, out precio) ||
                !int.TryParse(txtCantidad.Text, out cantidadEnStock) ||
                !int.TryParse(txtProveedor.Text, out idProveedor))
            {
                lblMessage.Text = "Por favor, completa todos los campos correctamente.";
                return;
            }

            // Guardar solo la ruta de la imagen en lugar del contenido binario
            string imagePath = null;
            if (fuImagen.HasFile)
            {
                if (Path.GetExtension(fuImagen.FileName).ToLower() == ".jpg" ||
                    Path.GetExtension(fuImagen.FileName).ToLower() == ".png")
                {
                    // Generar un nombre único para la imagen usando un GUID
                    string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuImagen.FileName);
                    imagePath = Path.Combine("Images", fileName);  // Guarda solo la ruta relativa

                    // Guardar la imagen en la carpeta 'Images' en el servidor
                    fuImagen.SaveAs(Server.MapPath("~/" + imagePath));
                }
                else
                {
                    lblMessage.Text = "Solo se permiten imágenes JPG y PNG.";
                    return;
                }
            }

            // Guardar en la base de datos usando Entity Framework
            using (var context = new ComicsEntities())
            {
                try
                {
                    // Ejecutar el procedimiento almacenado para agregar el producto
                    context.Database.ExecuteSqlCommand(
                        "EXEC AgregarProducto @nombre, @descripcion, @precio, @cantidadEnStock, @idProveedor, @imagePath",
                        new SqlParameter("@nombre", nombre),
                        new SqlParameter("@descripcion", descripcion),
                        new SqlParameter("@precio", precio),
                        new SqlParameter("@cantidadEnStock", cantidadEnStock),
                        new SqlParameter("@idProveedor", idProveedor),
                        new SqlParameter("@imagePath", imagePath ?? (object)DBNull.Value)  // Guardamos solo la ruta
                    );

                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Producto agregado exitosamente.";
                    CargarProductos();
                }
                catch (Exception ex)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Error al agregar producto: " + ex.Message;
                }
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            Button btnEliminar = (Button)sender;
            int idProducto = Convert.ToInt32(btnEliminar.CommandArgument);

            using (var context = new ComicsEntities())
            {
                try
                {
                    context.Database.ExecuteSqlCommand(
                        "EXEC EliminarProducto @idProducto",
                        new SqlParameter("@idProducto", idProducto)
                    );

                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Producto eliminado exitosamente.";
                    CargarProductos();
                }
                catch (Exception ex)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Error al eliminar producto: " + ex.Message;
                }
            }
        }

        private void CargarProductos()
        {
            using (var context = new ComicsEntities())
            {
                try
                {
                    var productos = context.Database.SqlQuery<Producto>("EXEC MostrarProductos").ToList();

                    // Verifica que las rutas de las imágenes sean correctas (esto se puede quitar después de depurar)
                    foreach (var producto in productos)
                    {
                        Debug.WriteLine("Producto: " + producto.nombre + ", Imagen: " + producto.imagePath);
                    }

                    gvProductos.DataSource = productos;
                    gvProductos.DataBind();
                }
                catch (Exception ex)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Error al cargar productos: " + ex.Message;
                }
            }
        }

        // Modelo de datos del Producto
        public class Producto
        {
            public int idProducto { get; set; }
            public string nombre { get; set; }
            public string descripcion { get; set; }
            public decimal precio { get; set; }
            public int cantidadEnStock { get; set; }
            public int idProveedor { get; set; }
            public string imagePath { get; set; }  // Usar string para la ruta de la imagen
        }
    }
}
