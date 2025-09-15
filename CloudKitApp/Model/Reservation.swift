//
//  ReservationModel.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 14/09/25.
//

import Foundation
import CloudKit
// imported here so we can access the CKRecord

struct Reservation {
//    this is necessary so it's uniquely identify the object in CloudKit
//    why optional ? so we can still create the obejct locally, before uploading it to the database
    var recordId: CKRecord.ID?
    let user: String
    let guests: Int
    let isSmoking: Bool
    let date: Date
}

extension Reservation {
//    turn CKRecord to Reservation object
//    how to use Reservation(record: CKRecord) -> it will return a Reservation object
    init?(record: CKRecord) {
//        map the reservation from cloud (using the record["something"] to the variable so we can create a reservation object
//        use guard so if there's a mismatch, like type mismatch, it will return nil, not crash.
        guard let user = record["user"] as? String,
              let guests = record["guests"] as? Int,
              let isSmoking = record["isSmoking"] as? Bool,
              let date = record["date"] as? Date
        else {
            return nil
        }
        self.init(recordId: record.recordID, user: user, guests: guests, isSmoking: isSmoking, date: date)
    }
    
//    turn Reservation object to CKRecord
    var record: CKRecord{
//        create a new CKRecord with the type 'Reservation'
//        map the values from the reservation object variables to the record["something"]
//        how to use: reservation.record -> it will return a CKRecord
        let record = CKRecord(recordType: "Reservation")
        record["user"] = user
        record["guests"] = guests
        record["isSmoking"] = isSmoking
        record["date"] = date
        return record
    }
}
