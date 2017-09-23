//
//  WitnessOption_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension WitnessOption_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WitnessOption_db> {
        return NSFetchRequest<WitnessOption_db>(entityName: "WitnessOption_db");
    }

    @NSManaged public var text: String?
    @NSManaged public var isCorrect: Bool

}
