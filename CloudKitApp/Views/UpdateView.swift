//
//  UpdateView.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 12/09/25.
//

import SwiftUI

struct UpdateView: View {
    
    @EnvironmentObject private var vm : ReservationViewModel
    
    @State private var name = ""
//    @State private var pax = 0
//    @State private var isSmoking = false
//    @State private var date = Date.now
    
    @State private var currentReservation: Reservation? = nil
    @State private var updatedReservation: Reservation? = nil
    
    @State private var updatedGuests = 0
    @State private var updatedDate = Date.now
    @State private var updatedIsSmoking = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 8){
                Text(
                    "In this page, we will learn how to update / edit records that has been created in the database."
                )
                
                Spacer()
                
                HStack{
                    Button{
                        print("pressed")
                        Task{
                            print("task")
                            currentReservation = try await vm.getByName(name: name)
                            if currentReservation != nil{
                                updatedGuests = currentReservation!.guests
                                updatedIsSmoking = currentReservation!.isSmoking
                                updatedDate = currentReservation!.date
                            }
                            print("task2")
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                    }
                    TextField("Search", text: $name)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(8)
                .background(.background.secondary)
                .cornerRadius(12)
                
                switch vm.searchStatus {
                case .success(let reservation):
                    CardView(reservation: reservation)
                        .padding()
                        .background(.background.secondary)
                        .cornerRadius(16)
                case .error(let text):
                    Text(text)
                        .foregroundColor(.red)
                default:
                    Text("(Input name of reservation)")
                        .foregroundColor(.secondary)
                    
                }
                Form {
                    Section(header: Text("Update Details")) {
                        Stepper(
                            "\(updatedGuests.formatted()) guests",
                            value: $updatedGuests,
                            in: 2...20,
                            step: 1
                        )
                        Toggle("Smoking Room", isOn: $updatedIsSmoking)
                        DatePicker(
                            "Date",
                            selection: $updatedDate
                        )
                    }
                                    
                    Section {
                        Button("Update reservation") {
                            Task {
                                updatedReservation = Reservation(user: name, guests: updatedGuests, isSmoking: updatedIsSmoking, date: updatedDate)
                                print("local")
                                try await vm.updateReservation(currentReservation!, updated: updatedReservation!)
                                print("update")
                                currentReservation = try await vm.getByName(name: name)
                                print("fetch")
                                if currentReservation != nil{
                                    updatedGuests = currentReservation!.guests
                                    updatedIsSmoking = currentReservation!.isSmoking
                                    updatedDate = currentReservation!.date
                                }
                                print("all")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .cornerRadius(20)
                Text(
                    "After updating it will change the card details and the database."
                )
                
            }
            .padding()
            .navigationTitle("Update record")
        }
    }
}

#Preview {
    UpdateView()
        .environment(ReservationViewModel())
}
