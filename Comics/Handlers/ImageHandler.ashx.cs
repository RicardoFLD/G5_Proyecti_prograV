using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Comics.Handlers
{
    public class ImageHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            // Configurar el tipo de respuesta como imagen
            context.Response.ContentType = "image/jpeg"; // Cambia a "image/png" si tus imágenes son PNG

            // Obtener el parámetro idProducto desde la URL
            if (int.TryParse(context.Request.QueryString["idProducto"], out int idProducto))
            {
                // Obtener la cadena de conexión desde Web.config
                string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionStringName"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Consulta SQL para recuperar la imagen usando el ID del producto
                    string query = "SELECT imagen FROM Producto WHERE idProducto = @idProducto";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@idProducto", idProducto);
                        var imagenData = command.ExecuteScalar() as byte[];

                        if (imagenData != null)
                        {
                            // Escribir los datos de la imagen en la respuesta
                            context.Response.BinaryWrite(imagenData);
                        }
                        else
                        {
                            // Redirigir a una imagen predeterminada si no hay imagen para este producto
                            context.Response.Redirect("~/images/no-image.jpg");
                        }
                    }
                }
            }
            else
            {
                // Redirigir a una imagen predeterminada si no se proporciona un idProducto válido
                context.Response.Redirect("~/images/no-image.jpg");
            }
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}