<%@ Page Title="Agregar Producto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Comics.aspx.cs" Inherits="Comics.Pages.Comics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* Fondo de degradado */
        body {
            background: linear-gradient(135deg, #ff7eb9, #ff758c, #fcae1e);
            font-family: Arial, sans-serif;
            color: #333;
        }

        /* Contenedor principal para centrar el contenido */
        #MainContent {
            background-color: #fff;
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
        }

        /* Estilo para el título */
        h2 {
            color: #2a2a8e;
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
        }

        /* Mensaje de validación */
        #lblMessage {
            display: block;
            font-size: 14px;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Contenedor en grid para el formulario */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 15px;
            align-items: center;
            margin-bottom: 20px;
        }

        /* Estilo de los campos de entrada y etiquetas */
        .form-grid label {
            font-weight: bold;
            color: #2a2a8e;
            text-align: right;
        }

        .form-grid input[type="text"],
        .form-grid textarea,
        #btnAgregar {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        /* Botón para agregar productos */
        #btnAgregar {
            background-color: #2a2a8e;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s;
            margin-top: 20px;
            grid-column: 1 / span 2;
            text-align: center;
        }

        #btnAgregar:hover {
            background-color: #1a1a6e;
        }

        /* Grid de productos */
        #gvProductos {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #f3f3f3;
            border-radius: 10px;
            overflow: hidden;
            text-align: left;
        }

        #gvProductos th, #gvProductos td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        #gvProductos th {
            background-color: #2a2a8e;
            color: white;
            font-weight: bold;
        }

        #gvProductos tr:hover {
            background-color: #e0e0e0;
        }

        /* Estilo para los botones en la tabla */
        .acciones-button {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 3px;
            transition: background-color 0.3s;
        }

        .acciones-button:hover {
            background-color: #d32f2f;
        }

        /* Imagen de producto en el grid */
        .product-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>

    <h2>Agregar Producto</h2>
    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    
    <!-- Formulario con alineación mejorada -->
    <div class="form-grid">
        <asp:Label ID="lblNombre" runat="server" Text="Nombre del Producto: " />
        <asp:TextBox ID="txtNombre" runat="server" MaxLength="100" />

        <asp:Label ID="lblDescripcion" runat="server" Text="Descripción: " />
        <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="4" MaxLength="255" />

        <asp:Label ID="lblPrecio" runat="server" Text="Precio: " />
        <asp:TextBox ID="txtPrecio" runat="server" />

        <asp:Label ID="lblCantidad" runat="server" Text="Cantidad en Stock: " />
        <asp:TextBox ID="txtCantidad" runat="server" />

        <asp:Label ID="lblProveedor" runat="server" Text="ID del Proveedor: " />
        <asp:TextBox ID="txtProveedor" runat="server" />

        <asp:Label ID="lblImagen" runat="server" Text="Imagen: " />
        <asp:FileUpload ID="fuImagen" runat="server" />

        <asp:Button ID="btnAgregar" runat="server" Text="Agregar Producto" OnClick="btnAgregar_Click" />
    </div>

   <!-- Tabla de productos con alineación centrada -->
   <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="idProducto" HeaderText="ID" />
            <asp:BoundField DataField="nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
            <asp:BoundField DataField="precio" HeaderText="Precio" DataFormatString="{0:C}" />
            <asp:BoundField DataField="cantidadEnStock" HeaderText="Cantidad en Stock" />
            <asp:BoundField DataField="idProveedor" HeaderText="ID Proveedor" />

           <asp:TemplateField HeaderText="Imagen">
    <ItemTemplate>
        <asp:Image ID="imgProducto" runat="server" CssClass="product-image"
                   ImageUrl='<%# Eval("imagePath", "~/Images/{0}") %>' />
    </ItemTemplate>
</asp:TemplateField>


            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" 
                                CommandName="Eliminar" 
                                CommandArgument='<%# Eval("idProducto") %>' 
                                OnClick="btnEliminar_Click" CssClass="acciones-button" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
   </asp:GridView>

</asp:Content>
