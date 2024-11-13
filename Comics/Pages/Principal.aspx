<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Principal.aspx.cs" Inherits="Comics.Pages.Principal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* Contenedor general de productos con una cuadrícula de 3 columnas */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 3 columnas */
            gap: 20px;
            margin-top: 20px;
        }

        /* Estilo para cada carta de producto */
        .product-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            text-align: center;
            padding: 20px;
            transition: transform 0.3s ease-in-out;
        }

        /* Efecto hover en las cartas */
        .product-card:hover {
            transform: translateY(-10px);
        }

        /* Estilo para la imagen del producto */
        .product-image {
            width: 100%;
            height: auto;
            border-radius: 4px;
        }

        /* Título del producto */
        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin: 15px 0 10px;
        }

        /* Descripción del producto */
        .product-description {
            font-size: 14px;
            color: #555;
            margin-bottom: 15px;
        }

        /* Precio del producto */
        .product-price {
            font-size: 16px;
            color: #27ae60;
            font-weight: bold;
        }

    </style>

    <h2>Lista de Productos</h2>

    <!-- Repeater para mostrar los productos en un diseño de cuadrícula personalizada -->
    <asp:Repeater ID="rptProductos" runat="server">
        <HeaderTemplate>
            <div class="product-grid">
        </HeaderTemplate>
        
        <ItemTemplate>
            <!-- Cada producto se presenta como una carta en el grid -->
            <div class="product-card">
                <img src='<%# Eval("imagenRuta") %>' alt="Imagen del producto" class="product-image" />
                <h3 class="product-title"><%# Eval("nombre") %></h3>
                <p class="product-description"><%# Eval("descripcion") %></p>
                <span class="product-price">$<%# Eval("precio") %></span>
            </div>
        </ItemTemplate>
        
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
