//
//  ContentView.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 11/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        NavigationStack{
            TabView {
                Tab("Create", systemImage: "plus") {
                    CreateView()
                }
                
                Tab("Retrieve", systemImage: "magnifyingglass") {
                    RetrieveView()
                }
                
                Tab("Update", systemImage: "pencil") {
                    UpdateView()
                }
                        
                Tab("Delete", systemImage: "trash") {
                    DeleteView()
                }
                Tab("CRUD", systemImage: "books.vertical") {
                    CRUDView()
                }
            }
//            .navigationTitle("Create")
//        }
    }
}

#Preview {
    ContentView()
}
