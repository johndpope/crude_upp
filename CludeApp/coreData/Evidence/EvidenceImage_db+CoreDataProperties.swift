//
//  EvidenceImage_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension EvidenceImage_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EvidenceImage_db> {
        return NSFetchRequest<EvidenceImage_db>(entityName: "EvidenceImage_db");
    }

    @NSManaged public var id: String?

}
