//
//  ContentView.swift
//  crud.swiftui.examen
//
//  Created by CCDM15 on 14/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let coreDM: CoreDataManager
    
    @State private var productos: [Producto] = [Producto]()

    var body: some View {
        NavigationView {
            VStack {
                
                NavigationLink(destination: GuardarView(coreDM: coreDM)) {
                    Text("Agregar")
                }
                
                
                List {
                    ForEach(productos, id: \.self) {
                        prod in
                        VStack {
                            Text(prod.id ?? "")
                            Text(prod.nombre ?? "")
                            Text(prod.marca ?? "")
                            Text(prod.descripcion ?? "")
                            Text(prod.precio ?? "")
                            NavigationLink(destination: GuardarView(coreDM: coreDM, producto: producto)){
                            }
                        }
                    }
                    .onDelete(perform: {
                        IndexSet in
                        IndexSet.forEach({ index in
                            let producto = productos[index]
                            coreDM.borrarProducto(producto: producto)
                            mostrarProductos()
                        })
                    })
                }
                Spacer()
            }.padding()
                .navigationTitle("Lista Productos")
                .onAppear(perform: {
                    mostrarProductos()
                })
        }
    }
    
    func mostrarProductos() {
        productos = coreDM.leerTodosProductos()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}

struct GuardarView: View {
    let coreDM: CoreDataManager
    let producto: Producto?
    @State private var id: Int64 = 0
    @State private var nombre: String = ""
    @State private var marca: String = ""
    @State private var descripcion: String = ""
    @State private var precio: Float = 0
    var body: some View {
        
        VStack {
            
            TextField("Id del producto: ", text: $id).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Nombre del producto: ", text: $nombre).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Marca del producto: ", text: $marca).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Descripcion del producto: ", text: $descripcion).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Precio del producto: ", text: ($precio)).textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Guardar") {
                coreDM.guardarProducto(id: id, nombre: nombre, marca: marca, descripcion: descripcion, precio: precio)
                //mostrarProductos()
                id = ""
                nombre = ""
                marca = ""
                descripcion = ""
                precio = ""
            }
            
        }
        .navigationTitle("Agregar Producto")
    }
}
