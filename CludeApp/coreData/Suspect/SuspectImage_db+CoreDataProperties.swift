//
//  SuspectImage_db+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension SuspectImage_db {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SuspectImage_db> {
        return NSFetchRequest<SuspectImage_db>(entityName: "SuspectImage_db");
    }

    @NSManaged public var id: String?

}
