//
//  Witnesses_db_cludeUpp+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension Witnesses_db_cludeUpp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Witnesses_db_cludeUpp> {
        return NSFetchRequest<Witnesses_db_cludeUpp>(entityName: "Witnesses_db_cludeUpp");
    }

    @NSManaged public var hint: String?
    @NSManaged public var locationLine: String?
    @NSManaged public var name: String?
    @NSManaged public var visible: Bool
    @NSManaged public var witnessLocation: WitnessLocation_db?
    @NSManaged public var witnessQuestion: WitnessQue_db?
    @NSManaged public var witnessImage: WitnessImage_db?
    @NSManaged public var distance:Double
    @NSManaged public var introgatted:Bool
    @NSManaged public var statement:String?
    @NSManaged public var coolDown:Bool
    @NSManaged public var showHint:Bool
    @NSManaged public var index: Int32
}
