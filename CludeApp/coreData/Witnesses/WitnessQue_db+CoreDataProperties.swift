//
//  WitnessQue_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension WitnessQue_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WitnessQue_db> {
        return NSFetchRequest<WitnessQue_db>(entityName: "WitnessQue_db");
    }

    @NSManaged public var text: String?
    @NSManaged public var options: NSSet?

}

// MARK: Generated accessors for options
extension WitnessQue_db {

    @objc(addOptionsObject:)
    @NSManaged public func addToOptions(_ value: WitnessOption_db)

    @objc(removeOptionsObject:)
    @NSManaged public func removeFromOptions(_ value: WitnessOption_db)

    @objc(addOptions:)
    @NSManaged public func addToOptions(_ values: NSSet)

    @objc(removeOptions:)
    @NSManaged public func removeFromOptions(_ values: NSSet)

}
