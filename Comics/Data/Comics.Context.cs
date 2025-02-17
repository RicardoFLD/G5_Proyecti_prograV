﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Comics.Data
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class ComicsEntities : DbContext
    {
        public ComicsEntities()
            : base("name=ComicsEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual int AgregarProducto(string nombre, string descripcion, Nullable<decimal> precio, Nullable<int> cantidadEnStock, Nullable<int> idProveedor)
        {
            var nombreParameter = nombre != null ?
                new ObjectParameter("nombre", nombre) :
                new ObjectParameter("nombre", typeof(string));
    
            var descripcionParameter = descripcion != null ?
                new ObjectParameter("descripcion", descripcion) :
                new ObjectParameter("descripcion", typeof(string));
    
            var precioParameter = precio.HasValue ?
                new ObjectParameter("precio", precio) :
                new ObjectParameter("precio", typeof(decimal));
    
            var cantidadEnStockParameter = cantidadEnStock.HasValue ?
                new ObjectParameter("cantidadEnStock", cantidadEnStock) :
                new ObjectParameter("cantidadEnStock", typeof(int));
    
            var idProveedorParameter = idProveedor.HasValue ?
                new ObjectParameter("idProveedor", idProveedor) :
                new ObjectParameter("idProveedor", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("AgregarProducto", nombreParameter, descripcionParameter, precioParameter, cantidadEnStockParameter, idProveedorParameter);
        }
    
        public virtual int EditarProducto(Nullable<int> idProducto, string nombre, string descripcion, Nullable<decimal> precio, Nullable<int> cantidadEnStock, Nullable<int> idProveedor)
        {
            var idProductoParameter = idProducto.HasValue ?
                new ObjectParameter("idProducto", idProducto) :
                new ObjectParameter("idProducto", typeof(int));
    
            var nombreParameter = nombre != null ?
                new ObjectParameter("nombre", nombre) :
                new ObjectParameter("nombre", typeof(string));
    
            var descripcionParameter = descripcion != null ?
                new ObjectParameter("descripcion", descripcion) :
                new ObjectParameter("descripcion", typeof(string));
    
            var precioParameter = precio.HasValue ?
                new ObjectParameter("precio", precio) :
                new ObjectParameter("precio", typeof(decimal));
    
            var cantidadEnStockParameter = cantidadEnStock.HasValue ?
                new ObjectParameter("cantidadEnStock", cantidadEnStock) :
                new ObjectParameter("cantidadEnStock", typeof(int));
    
            var idProveedorParameter = idProveedor.HasValue ?
                new ObjectParameter("idProveedor", idProveedor) :
                new ObjectParameter("idProveedor", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("EditarProducto", idProductoParameter, nombreParameter, descripcionParameter, precioParameter, cantidadEnStockParameter, idProveedorParameter);
        }
    
        public virtual int EliminarProducto(Nullable<int> idProducto)
        {
            var idProductoParameter = idProducto.HasValue ?
                new ObjectParameter("idProducto", idProducto) :
                new ObjectParameter("idProducto", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("EliminarProducto", idProductoParameter);
        }
    
        public virtual ObjectResult<MostrarProductos_Result> MostrarProductos()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<MostrarProductos_Result>("MostrarProductos");
        }
    }
}
