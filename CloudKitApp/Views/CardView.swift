//
//  CardView.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 14/09/25.
//

import SwiftUI

struct CardView: View {
    
    var reservation : Reservation
    
    var body: some View {
        VStack(spacing: 12){
            HStack{
                Text(reservation.user)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                HStack{
                    Text("\(reservation.guests)")
                    Image(systemName: "person.3.fill")
                }
            }
            HStack(alignment:.bottom){
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "calendar")
                        Text(reservation.date, format: .dateTime.day().month().year())
                    }
                    HStack{
                        Image(systemName: "clock")
                        Text(reservation.date, format: .dateTime.hour().minute())
                    }
                }
                Spacer()
                Text(reservation.isSmoking ? "Smoking" : "Non-smoking")
            }
        }
        .padding()
        .background(.background.secondary)
        .cornerRadius(20)
    }
}

#Preview {
    CardView(reservation: Reservation(user: "Alvin", guests: 5, isSmoking: true, date: Date.now))
}
