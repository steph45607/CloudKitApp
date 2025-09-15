//
//  ReservationViewModel.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 14/09/25.
//

import Foundation
import CloudKit

@Observable class ReservationViewModel: ObservableObject{
//    access the public database
    private var db = CKContainer(identifier: "iCloud.com.staniswinata.CloudKit").publicCloudDatabase
//    map the CKRecord to a Reservation object, mapping pairs
    private var reservationDict: [CKRecord.ID: Reservation] = [:]
        
//    an array of reservations
        var reservations: [Reservation] {
            reservationDict.values.compactMap { $0 }
        }
    
//    to add resrvation object to the public database
    func createReservation(_ reservation: Reservation) async throws{
        do{
//            save the reservation.record -> CKRecord to the database
            let record = try await db.save(reservation.record)
            guard let new = Reservation(record: record) else {return}
            reservationDict[new.recordId!] = new
        } catch {
            print(error)
        }
    }
}
