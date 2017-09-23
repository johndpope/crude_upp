//
//  WitnessImage_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension WitnessImage_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WitnessImage_db> {
        return NSFetchRequest<WitnessImage_db>(entityName: "WitnessImage_db");
    }

    @NSManaged public var id: String?

}
