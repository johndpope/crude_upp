//
//  Suspects_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension Suspects_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Suspects_db> {
        return NSFetchRequest<Suspects_db>(entityName: "Suspects_db");
    }

    @NSManaged public var name: String?
    @NSManaged public var designation: String?
    @NSManaged public var suspectImage: SuspectImage_db?
    @NSManaged public var isCross : Bool
    @NSManaged public var index: Int32
}
