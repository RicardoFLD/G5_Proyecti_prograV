USE [master]
GO
/****** Object:  Database [Comics]    Script Date: 12/11/2024 22:45:49 ******/
CREATE DATABASE [Comics]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Comics', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Comics.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Comics_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Comics_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Comics] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Comics].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Comics] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Comics] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Comics] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Comics] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Comics] SET ARITHABORT OFF 
GO
ALTER DATABASE [Comics] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Comics] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Comics] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Comics] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Comics] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Comics] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Comics] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Comics] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Comics] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Comics] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Comics] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Comics] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Comics] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Comics] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Comics] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Comics] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Comics] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Comics] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Comics] SET  MULTI_USER 
GO
ALTER DATABASE [Comics] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Comics] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Comics] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Comics] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Comics] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Comics] SET QUERY_STORE = OFF
GO
USE [Comics]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[idProducto] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[precio] [decimal](10, 2) NOT NULL,
	[cantidadEnStock] [int] NOT NULL,
	[idProveedor] [int] NULL,
	[imagenRuta] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedor](
	[idProveedor] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NOT NULL,
	[telefono] [nvarchar](15) NULL,
	[direccion] [nvarchar](255) NULL,
	[correo] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[contrasena] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Venta]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Venta](
	[idVenta] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [date] NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idProducto] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[total] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Venta] ADD  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Proveedor] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedor] ([idProveedor])
GO
ALTER TABLE [dbo].[Producto] CHECK CONSTRAINT [FK_Producto_Proveedor]
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Producto] FOREIGN KEY([idProducto])
REFERENCES [dbo].[Producto] ([idProducto])
GO
ALTER TABLE [dbo].[Venta] CHECK CONSTRAINT [FK_Venta_Producto]
GO
ALTER TABLE [dbo].[Venta]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Usuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Venta] CHECK CONSTRAINT [FK_Venta_Usuario]
GO
/****** Object:  StoredProcedure [dbo].[AgregarProducto]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AgregarProducto]
    @nombre NVARCHAR(100),
    @descripcion NVARCHAR(255),
    @precio DECIMAL(10, 2),
    @cantidadEnStock INT,
    @idProveedor INT,
    @imagenRuta NVARCHAR(255)  -- Nuevo parámetro para la ruta de la imagen
AS
BEGIN
    INSERT INTO Producto (nombre, descripcion, precio, cantidadEnStock, idProveedor, imagenRuta)
    VALUES (@nombre, @descripcion, @precio, @cantidadEnStock, @idProveedor, @imagenRuta);
END;
GO
/****** Object:  StoredProcedure [dbo].[EditarProducto]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EditarProducto]
    @idProducto INT,  -- El ID del producto a actualizar
    @nombre NVARCHAR(100),  -- Nuevo nombre del producto
    @descripcion NVARCHAR(255),  -- Nueva descripción del producto
    @precio DECIMAL(10, 2),  -- Nuevo precio del producto
    @cantidadEnStock INT,  -- Nueva cantidad en stock
    @idProveedor INT,  -- Nuevo proveedor del producto
    @imagenRuta NVARCHAR(255)  -- Nueva ruta de la imagen
AS
BEGIN
    -- Actualizar el producto con los nuevos valores
    UPDATE Producto
    SET nombre = @nombre,
        descripcion = @descripcion,
        precio = @precio,
        cantidadEnStock = @cantidadEnStock,
        idProveedor = @idProveedor,
        imagenRuta = @imagenRuta  -- Actualizar la ruta de la imagen
    WHERE idProducto = @idProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[EliminarProducto]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EliminarProducto]
    @idProducto INT
AS
BEGIN
    DELETE FROM Producto
    WHERE idProducto = @idProducto;
END;
GO
/****** Object:  StoredProcedure [dbo].[ListaProductos]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ListaProductos]
AS
BEGIN
    SELECT idProducto, nombre, descripcion, precio, cantidadEnStock, idProveedor, imagenRuta
    FROM Producto;
END;
GO
/****** Object:  StoredProcedure [dbo].[MostrarProductos]    Script Date: 12/11/2024 22:45:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MostrarProductos]
AS
BEGIN
    SELECT idProducto, nombre, descripcion, precio, cantidadEnStock, idProveedor, imagenRuta
    FROM Producto;
END;
GO
USE [master]
GO
ALTER DATABASE [Comics] SET  READ_WRITE 
GO
