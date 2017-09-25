//
//  TimeStoppers_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 24/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension TimeStoppers_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeStoppers_db> {
        return NSFetchRequest<TimeStoppers_db>(entityName: "TimeStoppers_db");
    }

    @NSManaged public var timeStopperLocation: TimeStopperLocation_db?

}
