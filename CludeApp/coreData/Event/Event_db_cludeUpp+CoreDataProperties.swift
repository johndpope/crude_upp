//
//  Event_db_cludeUpp+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData


extension Event_db_cludeUpp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event_db_cludeUpp> {
        return NSFetchRequest<Event_db_cludeUpp>(entityName: "Event_db_cludeUpp");
    }

    @NSManaged public var caseNotes: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var outcome: String?
    @NSManaged public var price: String?
    @NSManaged public var status: String?
    @NSManaged public var updateAt: String?
    @NSManaged public var v: Int16
    @NSManaged public var evidences: NSSet?
    @NSManaged public var leaderboard: NSSet?
    @NSManaged public var startLocation: StartLocation_db?
    @NSManaged public var suspects: NSSet?
    @NSManaged public var timeStoppers: TimeStoppers_db?
    @NSManaged public var witnesses: NSSet?
    @NSManaged public var safeZones: Any
    @NSManaged public var reviews: Any
    @NSManaged public var startedAt:Double
    @NSManaged public var endedAt :Double
    @NSManaged public var timeConsume:Double
    @NSManaged public var teamName:String?
    @NSManaged public var delayTime:Double
    @NSManaged public var isCompleted:Bool
}

// MARK: Generated accessors for evidences
extension Event_db_cludeUpp {

    @objc(addEvidencesObject:)
    @NSManaged public func addToEvidences(_ value: Evidences_db)

    @objc(removeEvidencesObject:)
    @NSManaged public func removeFromEvidences(_ value: Evidences_db)

    @objc(addEvidences:)
    @NSManaged public func addToEvidences(_ values: NSSet)

    @objc(removeEvidences:)
    @NSManaged public func removeFromEvidences(_ values: NSSet)

}

// MARK: Generated accessors for leaderboard
extension Event_db_cludeUpp {

    @objc(addLeaderboardObject:)
    @NSManaged public func addToLeaderboard(_ value: Leaderboard_db)

    @objc(removeLeaderboardObject:)
    @NSManaged public func removeFromLeaderboard(_ value: Leaderboard_db)

    @objc(addLeaderboard:)
    @NSManaged public func addToLeaderboard(_ values: NSSet)

    @objc(removeLeaderboard:)
    @NSManaged public func removeFromLeaderboard(_ values: NSSet)

}

// MARK: Generated accessors for suspects
extension Event_db_cludeUpp {

    @objc(addSuspectsObject:)
    @NSManaged public func addToSuspects(_ value: Suspects_db)

    @objc(removeSuspectsObject:)
    @NSManaged public func removeFromSuspects(_ value: Suspects_db)

    @objc(addSuspects:)
    @NSManaged public func addToSuspects(_ values: NSSet)

    @objc(removeSuspects:)
    @NSManaged public func removeFromSuspects(_ values: NSSet)

}

// MARK: Generated accessors for witnesses
extension Event_db_cludeUpp {

    @objc(addWitnessesObject:)
    @NSManaged public func addToWitnesses(_ value: Witnesses_db_cludeUpp)

    @objc(removeWitnessesObject:)
    @NSManaged public func removeFromWitnesses(_ value: Witnesses_db_cludeUpp)

    @objc(addWitnesses:)
    @NSManaged public func addToWitnesses(_ values: NSSet)

    @objc(removeWitnesses:)
    @NSManaged public func removeFromWitnesses(_ values: NSSet)

}
