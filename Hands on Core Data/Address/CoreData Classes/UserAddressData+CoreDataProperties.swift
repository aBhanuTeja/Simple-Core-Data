//
//  UserAddressData+CoreDataProperties.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 17/03/22.
//
//

import Foundation
import CoreData


extension UserAddressData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAddressData> {
        return NSFetchRequest<UserAddressData>(entityName: "UserAddressData")
    }

    @NSManaged public var city: String?
    @NSManaged public var fullName: String?
    @NSManaged public var houseNumber: String?
    @NSManaged public var locality: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var pinCode: String?
    @NSManaged public var state: String?

}

extension UserAddressData : Identifiable {

}
