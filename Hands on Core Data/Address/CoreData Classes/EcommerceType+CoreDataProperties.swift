//
//  EcommerceType+CoreDataProperties.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 20/03/22.
//
//

import Foundation
import CoreData


extension EcommerceType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EcommerceType> {
        return NSFetchRequest<EcommerceType>(entityName: "EcommerceType")
    }

    @NSManaged public var brandName: String?
    @NSManaged public var addressEcommerce: NSSet?

}

// MARK: Generated accessors for addressEcommerce
extension EcommerceType {

    @objc(addAddressEcommerceObject:)
    @NSManaged public func addToAddressEcommerce(_ value: UserAddressData)

    @objc(removeAddressEcommerceObject:)
    @NSManaged public func removeFromAddressEcommerce(_ value: UserAddressData)

    @objc(addAddressEcommerce:)
    @NSManaged public func addToAddressEcommerce(_ values: NSSet)

    @objc(removeAddressEcommerce:)
    @NSManaged public func removeFromAddressEcommerce(_ values: NSSet)

}

extension EcommerceType : Identifiable {

}
