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
    @State private var pax = 2
    @State private var isSmoking = false
    @State private var date = Date.now
    
    @State private var currentReservation: Reservation? = nil
    @State private var updatedReservation: Reservation? = nil
    
    @State private var updatedGuests = 0
    @State private var updatedDate = Date.now
    @State private var updatedIsSmoking = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 8){
                Text(
                    "In this page, we will learn how to update or edit records that has been submitted or created in the database."
                )
                Text(
                    "A user just called under the name Edward. He wants to change to a smoking room and the number of guest would be 3."
                )
                Spacer()
                Form {
                    // --- Preview card
                    Section {
                        if let reservation = currentReservation {
                            CardView(reservation: reservation)
                        } else {
                            Text("No reservation found")
                        }
                    }
                                    
                    // --- Editable fields
                    Section(header: Text("Search by Name")) {
                        TextField("Name", text: $name)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                                    
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
//                            displayedComponents: .date
                        )
                    }
                                    
                    // --- Update button
                    Section {
                        Button("Update reservation") {
                            Task {
//                                guard let res = vm.getByName(name).first else {
//                                    return
//                                }
//                                currentReservation = res
//                                                
//                                var newValues: [String: Any] = [:]
//                                                
//                                if updatedGuests != 0 && updatedGuests != res.guests {
//                                    newValues["guests"] = updatedGuests
//                                }
//                                if updatedIsSmoking != res.isSmoking {
//                                    newValues["isSmoking"] = updatedIsSmoking
//                                }
//                                if updatedDate != res.date {
//                                    newValues["date"] = updatedDate
//                                }
//                                                
//                                if !newValues.isEmpty {
//                                    try await vm
//                                        .updateByName(
//                                            name,
//                                            newValues: newValues
//                                        )
//                                    currentReservation = vm
//                                        .getByName(name).first
//                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .cornerRadius(20)
                //                Text("After updating the data will be updated in the card, it will also changed in the public database in the CloudKit.")
                
            }
            .padding()
            .navigationTitle("Update recrod")
        }
    }
}

#Preview {
    UpdateView()
}
