//
//  Evidences_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension Evidences_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Evidences_db> {
        return NSFetchRequest<Evidences_db>(entityName: "Evidences_db");
    }

    @NSManaged public var name: String?
    @NSManaged public var designation: String?
    @NSManaged public var evidenceImage: EvidenceImage_db?
    @NSManaged public var isCross:Bool
    @NSManaged public var index: Int32
}
