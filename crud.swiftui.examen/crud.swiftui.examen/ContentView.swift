//
//  ContentView.swift
//  crud.swiftui.examen
//
//  Created by CCDM15 on 14/11/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        TabView {
            Text("Home").tabItem{
                Image(systemName: "list.number")
            }
            
            Text("Home")
                .tabItem{
                    Image(systemName: "person.crop.circle")
                    Text("Consultar")
                }
            Text("Create").tabItem{
                Image(systemName: "person.badge.plus")
                Text("Create")
            }
            Text("Modificar").tabItem{
                Image(systemName: "pencil.circle")
                Text("Modificar")
            }
        }
        .padding()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
