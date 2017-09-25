//
//  TimeStopperLocation_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 24/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension TimeStopperLocation_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeStopperLocation_db> {
        return NSFetchRequest<TimeStopperLocation_db>(entityName: "TimeStopperLocation_db");
    }

    @NSManaged public var lat: Float
    @NSManaged public var long: Float

}
