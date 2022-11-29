//
//  ContentView.swift
//  crud.swiftui.examen
//
//  Created by CCDM15 on 14/11/22.
//finishit

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var coreDM: CoreDataManager
    
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
                            Text("Id: \(String(prod.id))")
                            Text("Nombre: \(prod.nombre ?? "")")
                            Text("Marca: \(prod.marca ?? "")")
                            Text("Descripcion: \(prod.descripcion ?? "")")
                            Text("Precio: \(String(prod.precio))")
                            NavigationLink(destination: EditarView(coreDM: coreDM, producto: prod)){
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
                    coreDM = CoreDataManager()
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
    @State private var id: Int64 = 0
    @State private var nombre: String = ""
    @State private var marca: String = ""
    @State private var descripcion: String = ""
    @State private var precio: Float = 0
    
    private let numberFormatter = NumberFormatter()
    var body: some View {
        
        VStack {
            
            Stepper("Id del producto: " + String(id), value: $id, in: 0...100)
            TextField("Nombre del producto: ", text: $nombre).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Marca del producto: ", text: $marca).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Descripcion del producto: ", text: $descripcion).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Precio: ", value: $precio, formatter: numberFormatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            //TextField("Precio del producto: ", text: ($precio)).textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Guardar") {
                coreDM.guardarProducto(id: id, nombre: nombre, marca: marca, descripcion: descripcion, precio: precio)
                //mostrarProductos()
                
            }
            
        }.padding()
        .navigationTitle("Agregar Producto")
    }
}


struct EditarView: View {
    let coreDM: CoreDataManager
    @State var producto: Producto
    //@State private var id: Int64 = 0
    @State private var nombre: String = ""
    @State private var marca: String = ""
    @State private var descripcion: String = ""
    @State private var precio: Float = 0
    
    private let numberFormatter = NumberFormatter()
    var body: some View {
        
        VStack {
            
            //TextField("Id del producto: ", text: $id).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Nombre del producto: ", text: $nombre).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Marca del producto: ", text: $marca).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Descripcion del producto: ", text: $descripcion).textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("", value: $precio, formatter: numberFormatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            //TextField("Precio del producto: ", text: ($precio)).textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Actualizar") {
                
                //mostrarProductos()
                //producto.id = Int64(id)
                producto.nombre = nombre
                producto.marca = marca
                producto.descripcion = descripcion
                producto.precio = Float(precio)
                coreDM.editarproducto(producto : producto)
            }
            
        }.padding()
        .navigationTitle("Editar Producto")
        .onAppear{
            nombre = producto.nombre ?? ""
            marca = producto.marca ?? ""
            descripcion = producto.descripcion ?? ""
            precio = producto.precio
        }
    }
}
