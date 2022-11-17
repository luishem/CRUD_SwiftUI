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
        persistentContainer.loadPersistentStores(completionHandler: completionHandler:{
            (description, error) in
            if let error = error {
                fatalError("Core Data failed to initialize \(error.localizedDescription)")
            }
        })
    }
}

func guardarProducto(id: Int16, nombre: String, marca: String, descripcion: String, precio: Double, existencia: Int16) {
    let producto = Producto(
}
