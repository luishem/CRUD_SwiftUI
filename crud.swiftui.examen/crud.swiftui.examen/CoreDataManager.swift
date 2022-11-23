//
//  CoreDataManager.swift
//  crud.swiftui.examen
//
//  Created by CCDM23 on 17/11/22.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer : NSPersistentContainer
    
    init(){
        persistentContainer = NSPersistentContainer(name: "crud_swiftui_examen")
        persistentContainer.loadPersistentStores{ (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func borrarProducto(producto: Producto) {
        persistentContainer.viewContext.delete(producto)
        
        do {
            return try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
    
    func leerTodosProductos() -> [Producto] {
        let fetchRequest: NSFetchRequest <Producto> = Producto.fetchRequest()
        
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func guardarProducto(id: Int32, nombre: String, marca: String, descripcion: String, precio: Double) {
        let producto = Producto(context: persistentContainer.viewContext)
        producto.id = id
        producto.nombre = nombre
        producto.marca = marca
        producto.descripcion = descripcion
        producto.precio = precio
        
        do {
            try persistentContainer.viewContext.save()
            print("Producto guardado")
        }
        catch {
            print("Failed to save error en \(error)")
        }
    }
}


