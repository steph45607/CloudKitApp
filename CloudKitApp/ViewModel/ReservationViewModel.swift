//
//  ReservationViewModel.swift
//  CloudKitApp
//
//  Created by Stephanie Staniswinata on 14/09/25.
//

import Foundation
import CloudKit

enum Status{
    case success(reservation: Reservation)
    case error(text: String)
    case idle
}

@Observable class ReservationViewModel: ObservableObject{
    //    access the public database
    private var db = CKContainer(
        identifier: "iCloud.com.staniswinata.CloudKitApp"
    ).publicCloudDatabase
    //    map the CKRecord to a Reservation object, mapping pairs
    private var reservationDict: [CKRecord.ID: Reservation] = [:]
        
    //    an array of reservations
    var reservationsArr: [Reservation] {
        Array(reservationDict.values)
    }
    
    var createStatus : Status = .idle
    var searchStatus : Status = .idle
    
    //    to add resrvation object to the public database
    func createReservation(_ reservation: Reservation) async throws{
        do{
            if reservation.user.isEmpty {
                createStatus = .error(text: "Name can't be empty")
                return
            }
            //            save the reservation.record -> CKRecord to the database
            let record = try await db.save(reservation.record)
            //            create a new Reservation object and store it to new
            let new = Reservation(record: record)
            //            add the new object to the dictionary, with the object's recordID as they key
            reservationDict[(new?.recordId!)!] = new
        } catch {
            print(error.localizedDescription)
            createStatus = .error(text: error.localizedDescription)
            return
        }
        createStatus = .success(reservation: reservation)
        return
    }
    
    func getAll() async throws {
        do {
            //        tell which one they need to query
            let query = CKQuery(
                recordType: "Reservation",
                predicate: NSPredicate(value: true)
            )
            //        store the result here. the ones that matches the query -> Tuple of CKRecord and success/failure
            let result = try await db.records(matching: query)
            //        store the second element of the touple here, it's an array of CKRecords
            let records = result.matchResults.compactMap { try? $0.1.get() }
            
            //        for each of the CKRecords, we have to store it to the dictionary
            try await removeAll()
            records.forEach{
                record in
                reservationDict[record.recordID] = Reservation(record: record)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getByName(name: String)async throws -> Reservation?{
        do{
            let query = CKQuery(
                recordType: "Reservation",
                predicate: NSPredicate(format: "user == %@", name)
            )
            
            let result = try await db.records(matching: query)
            let records = result.matchResults.compactMap { try? $0.1.get() }
            
            //             only get the first
            if let record = records.first,
               let reservation = Reservation(record: record) {
                reservationDict[record.recordID] = reservation
                searchStatus = .success(reservation: reservation)
                print(
                    "get: \(reservation.guests) \(reservation.isSmoking) \(reservation.date)"
                )
                return reservation
            } else {
                searchStatus = .error(text: "No reservation found.")
                return nil // no user found
            }
        } catch {
            print(error)
            searchStatus = .error(text: error.localizedDescription)
            return nil
        }
    }
    
    func getSmoking(isSmoking: Bool)async throws{
        do{
            let query = CKQuery(
                recordType: "Reservation",
                predicate: NSPredicate(format: "isSmoking ==  \(isSmoking)")
            )
            
            let result = try await db.records(matching: query)
            let records = result.matchResults.compactMap { try? $0.1.get() }
            
            try await removeAll()
            records.forEach{ record in
                reservationDict[record.recordID] = Reservation(record: record)
            }
        } catch {
            print(error)
        }
    }
    
    func deleteReservation(_ reservation: Reservation) async throws{
        do{
            //            remove from DB first
            try await db.deleteRecord(withID: reservation.recordId!)
            //            remove from local dic
            reservationDict.removeValue(forKey: reservation.recordId!)
        } catch {
            print(error)
        }
    }
    
    func deleteAll() async throws {
        do{
            //            get all
            let query = CKQuery(
                recordType: "Reservation",
                predicate: NSPredicate(value: true)
            )
            //            store matching records
            let result = try await db.records(matching: query)
            //            store the records only from the tuple
            let records = result.matchResults.compactMap{ try? $0.1.get() }
            //            for each record, it will be deleted
            for record in records {
                try await db.deleteRecord(withID: record.recordID)
                reservationDict.removeValue(forKey: record.recordID)
            }
        }
    }
    
//    func removeAll() async throws {
//        do{
//            //            get all
//            let query = CKQuery(
//                recordType: "Reservation",
//                predicate: NSPredicate(value: true)
//            )
//            //            store matching records
//            let result = try await db.records(matching: query)
//            //            store the records only from the tuple
//            let records = result.matchResults.compactMap{ try? $0.1.get() }
//            //            for each record, it will be deleted
//            for record in records {
//                //                try await db.deleteRecord(withID: record.recordID)
//                reservationDict.removeValue(forKey: record.recordID)
//            }
//        }
//    }
    func removeAll() async throws {
        do{
            for record in reservationDict {
                reservationDict.removeValue(forKey: record.key)
            }
        }
    }
    
    func updateReservation(_ current: Reservation, updated: Reservation) async throws {
        //        print("updated: \(updated.guests) \(updated.isSmoking) \(updated.date)")
        //        print("id: \(current.recordId)")
        guard let recordId = current.recordId else {
            searchStatus = .error(text: "Reservation doesn't exists.")
            return
        }
        //        print("updated2")
        do{
            let record = try await db.record(for: recordId)
            record["guests"] = updated.guests
            record["isSmoking"] = updated.isSmoking
            record["date"] = updated.date
            let savedReservation = try await db.save(record)
            guard let updatedReservation = Reservation(record: savedReservation) else {
                searchStatus = .error(text: "Reservation doesn't exists.")
                return}
            reservationDict[updatedReservation.recordId!] = updatedReservation
            searchStatus = .success(reservation: updatedReservation)
            return
        } catch {
            searchStatus = .error(text: error.localizedDescription)
            print(error)
            return
        }
    }
}

