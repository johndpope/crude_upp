//
//  WitnessLocation_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension WitnessLocation_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WitnessLocation_db> {
        return NSFetchRequest<WitnessLocation_db>(entityName: "WitnessLocation_db");
    }

    @NSManaged public var lat: Float
    @NSManaged public var long: Float

}
