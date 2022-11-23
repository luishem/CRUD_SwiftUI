//
//  crud_swiftui_examenApp.swift
//  crud.swiftui.examen
//
//  Created by CCDM15 on 14/11/22.
//

import SwiftUI

@main

struct crud_swiftui_examenApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(coreDM : CoreDataManager())
        }
    }
}
