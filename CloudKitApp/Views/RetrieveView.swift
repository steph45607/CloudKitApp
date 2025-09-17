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
    
    @State private var filter = "All Reservation"
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 8){
                Text("Filters:")
                    .foregroundColor(.secondary)
                    .font(.callout)
                HStack{
                    Button{
                        Task{
                            try await vm.getAll()
                        }
                        filter = "All Reservation"
                    }label: {
                        Text("All")
                            .frame(width:30)
                            .padding(8)
                            .foregroundColor(.blue)
                            .background(.blue.opacity(0.2))
                            .cornerRadius(16)
                        
                    }
                    Button{
                        Task{
                            try await vm.getSmoking(isSmoking: true)
                        }
                        filter = "Smoking Reservation"
                    }label: {
                        Text("Smoking")
                            .padding(8)
                            .foregroundColor(.blue)
                            .background(.blue.opacity(0.2))
                            .cornerRadius(16)
                        
                    }
                    Button{
                        Task{
                            try await vm.getSmoking(isSmoking: false)
                        }
                        filter = "Non-Smoking Reservation"
                    }label: {
                        Text("Non-smoking")
                            .padding(8)
                            .foregroundColor(.blue)
                            .background(.blue.opacity(0.2))
                            .cornerRadius(16)
                        
                        
                    }
                }
                Text(
                    "In this page, it will show all reservations ever made. Use the filter to show matching reservations."
                )
                List{
                    Section(filter){
                        ForEach(
                            filtered(reservations: vm.reservationsArr),
                            id: \.self.recordId
                        ){ reservation in
                            CardView(reservation: reservation)
                        }
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
                    try await vm.getAll()
                }
            }
        }
    }
    private func filtered(reservations: [Reservation]) -> [Reservation] {
        if search.isEmpty {
            return vm.reservationsArr
        } else {
            return vm.reservationsArr.filter {
                //                $0.title.contains(searchText)
                $0.user.localizedCaseInsensitiveContains(search)

            }
        }
    }
}

#Preview {
    RetrieveView()
        .environment(ReservationViewModel())
}
