//
//  Producto.swift
//  crud.swiftui.examen
//
//  Created by CCDM15 on 14/11/22.
//

struct Producto: Identifiable {
    
    var id: Int
    var nombre: String
    var marca: String
    var descripcion: String
    var precio: Double
    var existencia: Int
    
    init(id:Int, nombre: String, marca: String, descripcion: String, precio: Double, existencia: Int){
        self.id = id
        self.nombre = nombre
        self.marca = marca
        self.descripcion = descripcion
        self.precio = precio
        self.existencia = existencia
    }
}
