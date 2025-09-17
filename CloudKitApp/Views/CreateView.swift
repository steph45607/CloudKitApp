//
//  CreateView.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 12/09/25.
//

import SwiftUI

struct CreateView: View {
    
    @EnvironmentObject private var vm : ReservationViewModel
    
    @State private var name = ""
    @State private var pax = 2
    @State private var isSmoking = false
    @State private var date = Date.now
    
    @State private var newReservation: Reservation? = nil
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 8){
                Text(
                    "In this page we will learn how to create a record and it will be added to the public database in CloudKit."
                )
                Spacer()
                switch vm.createStatus{
                case .success:
                    Text("Reservation added successfully!")
                        .foregroundColor(.green)
                    CardView(reservation: newReservation!)
                        .padding()
                        .background(.background.secondary)
                        .cornerRadius(16)
                case .error(let text):
                    Text(text)
                        .foregroundColor(.red)
                default:
                    Text("Add new reservation here:")
                }
                Form{
                    TextField("Name",text: $name)
                    Stepper(
                        "\(pax.formatted()) guests",
                        value: $pax,
                        in: 2...20,
                        step: 1
                    )
                    Toggle("Smoking Room", isOn: $isSmoking)
                    DatePicker("Date", selection: $date).datePickerStyle(.compact)
                    
                    Section{
                        Button{
                            Task{
                                newReservation = Reservation(user: name, guests: pax, isSmoking: isSmoking, date: date)
                                try await vm.createReservation(newReservation!)
                            }
                        } label:{
                            Text("Create reservation")
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                }
                .cornerRadius(20)
                Text(
                    "After the user submit, it will be added to the public database. Now the data would be visible in the retrieve page."
                )
                
            }
            .padding()
            .navigationTitle("Create a record")
        }
    }
}

#Preview {
    CreateView()
        .environment(ReservationViewModel())
}
