//
//  Event_db_cludeUpp+CoreDataProperties.swift
//  CludeApp
//
//  Created by Reus on 26/09/17.
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
    @NSManaged public var delayTime: Double
    @NSManaged public var endedAt: Double
    @NSManaged public var id: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var name: String?
    @NSManaged public var outcome: String?
    @NSManaged public var pdfSolution: String?
    @NSManaged public var price: String?
    @NSManaged public var reviews: NSObject?
    @NSManaged public var safeZones: NSObject?
    @NSManaged public var startedAt: Double
    @NSManaged public var status: String?
    @NSManaged public var teamID: String?
    @NSManaged public var teamName: String?
    @NSManaged public var timeConsume: Double
    @NSManaged public var terminateTime: Double
    @NSManaged public var updateAt: String?
    @NSManaged public var v: Int16
    @NSManaged public var evidences: NSSet?
    @NSManaged public var leaderboard: NSSet?
    @NSManaged public var startLocation: StartLocation_db?
    @NSManaged public var suspects: NSSet?
    @NSManaged public var timeStoppers: NSSet?
    @NSManaged public var witnesses: NSSet?
    @NSManaged public var timeStoppersLocation: NSSet?

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

// MARK: Generated accessors for timeStoppers
extension Event_db_cludeUpp {

    @objc(addTimeStoppersObject:)
    @NSManaged public func addToTimeStoppers(_ value: TimeStoppers_db)

    @objc(removeTimeStoppersObject:)
    @NSManaged public func removeFromTimeStoppers(_ value: TimeStoppers_db)

    @objc(addTimeStoppers:)
    @NSManaged public func addToTimeStoppers(_ values: NSSet)

    @objc(removeTimeStoppers:)
    @NSManaged public func removeFromTimeStoppers(_ values: NSSet)

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

// MARK: Generated accessors for timeStoppersLocation
extension Event_db_cludeUpp {

    @objc(addTimeStoppersLocationObject:)
    @NSManaged public func addToTimeStoppersLocation(_ value: TimeStopperLocation_db)

    @objc(removeTimeStoppersLocationObject:)
    @NSManaged public func removeFromTimeStoppersLocation(_ value: TimeStopperLocation_db)

    @objc(addTimeStoppersLocation:)
    @NSManaged public func addToTimeStoppersLocation(_ values: NSSet)

    @objc(removeTimeStoppersLocation:)
    @NSManaged public func removeFromTimeStoppersLocation(_ values: NSSet)

}
