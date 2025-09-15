//
//  RetrieveView.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 12/09/25.
//

import SwiftUI

struct RetrieveView: View {
    
    @EnvironmentObject private var vm : ReservationViewModel
    
    @State private var search = ""
    @State private var reservations = ["David", "Lucas"]
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 8){
                Text(
                    "In this page, it will show all reservations ever made. Use the filter to show matching reservations."
                )
                List{
                    ForEach(vm.reservations, id: \.self.recordId){ reservation in
                        CardView(reservation: reservation)
                    }
                }
                .searchable(text: $search)
                .cornerRadius(16)
                Spacer()
            }
            .padding()
            .navigationTitle("Retrieve record")
            .onAppear(){
                Task{
//                    populate here
                }
            }
        }
    }
}

#Preview {
    RetrieveView()
}
