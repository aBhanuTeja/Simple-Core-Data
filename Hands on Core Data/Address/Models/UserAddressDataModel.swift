//
//  UserAddressDataModel.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 18/03/22.
//

import Foundation
import CoreData

struct sortDisplayData {
    let dispayString: String
    let isDefalt: Bool
    let isSortOrFiltr: SortOrFilte
}

struct filterDisplayData {
    let dispayString: String
    let isSortOrFiltr: SortOrFilte
}

enum SortOrFilte {
    case sort
    case filter
}


class UserAddressDataModel {
    public static let shared = UserAddressDataModel()
    let context = AddressDatabase.shared.persistentContainer.viewContext
    
    func saveUserAddress(data: UserAddressData) {
        saveDataToDatabase()
    }

    func fetchAddresses() -> [UserAddressData]? {
        do {
            return try context.fetch(UserAddressData.fetchRequest())
        } catch {
            return nil
        }
    }

    func updateUserAddress(data: UserAddressData) {
        saveDataToDatabase()
    }

    func deleteUserAddress(data: UserAddressData) {
        self.context.delete(data)
        saveDataToDatabase()
    }

    func saveDataToDatabase() {
        do {
            try self.context.save()
        } catch {
            
        }
    }

    func getFilterData(_ city: String, isFilterSelected: Bool, isSortSelected: Bool) -> [UserAddressData]? {
        do {
            let completeData = UserAddressData.fetchRequest() as NSFetchRequest<UserAddressData>

            if isSortSelected {
                let sortDescriptor = NSSortDescriptor(key: "pinCode", ascending: true)
                completeData.sortDescriptors = [sortDescriptor]
            }
            
            if isFilterSelected {
                let predicate = NSPredicate(format: "city CONTAINS %@", city)
                completeData.predicate = predicate
            }

            return try context.fetch(completeData)
        } catch {
            return nil
        }
    }
}
