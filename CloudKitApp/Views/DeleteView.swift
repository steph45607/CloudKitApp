//
//  DeleteView.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 12/09/25.
//

import SwiftUI

struct DeleteView: View {
    
    @EnvironmentObject private var vm : ReservationViewModel
    
    @State private var reservations = ["David", "Lucas"]
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment:.leading){
                Text(
                    "In this page, we will learn how to delete a record. This data will be premanently deleted from the database."
                )
                HStack(alignment: .top){
                    Image(systemName: "phone.badge.waveform")
                        .symbolEffect(
                            .variableColor.iterative.hideInactiveLayers.nonReversing,
                            options: .repeat(.continuous)
                        )
                        .foregroundColor(.blue)
                    Text(
                        "Hi, I would like to cancel my reservation please. My name is Jessica. Yeah the one for 23 September 2024. Thank you!"
                    )
                    .italic()
                }
                .padding()
                .background(.background.secondary)
                .cornerRadius(8)
                List{
                    ForEach(reservations, id: \.self){ reservation in
                        Text(reservation)
                    }
                                        .onDelete(perform: { indexSet in
                                            for index in indexSet {
                                                Task {
//                                                    delete function here
                                                }
                                            }
                                        })
                }
                .cornerRadius(8)
                Spacer()
            }
            .padding()
            .navigationTitle("Delete record")
        }
    }
}

#Preview {
    DeleteView()
}
