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
                VStack(spacing: 12){
                    HStack{
                        Text("Edward")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                        HStack{
                            Text("4")
                            Image(systemName: "person.fill")
                        }
                    }
                    HStack(alignment:.bottom){
                        VStack(alignment: .leading){
                            HStack{
                                Image(systemName: "calendar")
                                Text("23 Sept 2024")
                            }
                            HStack{
                                Image(systemName: "clock")
                                Text("07:00")
                            }
                        }
                        Spacer()
                        Text("Non-smoking")
                    }
                }
                .padding()
                .background(.background.secondary)
                .cornerRadius(20)
                
                Form{
                    TextField("Name",text: $name)
                    Stepper(
                        "\(pax.formatted()) guests",
                        value: $pax,
                        in: 2...20,
                        step: 1
                    )
                    Toggle("Smoking Room", isOn: $isSmoking)
                    DatePicker("Date", selection: $date)
                        .datePickerStyle(.compact)
                    
                    Section{
                        Button{
                            //                            add update button here
                            //                            refresh the view card
                        } label:{
                            Text("Update reservation")
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
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
