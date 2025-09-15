//
//  CardView.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 14/09/25.
//

import SwiftUI

struct CardView: View {
    
    
    var body: some View {
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
    }
}

#Preview {
    CardView()
}
