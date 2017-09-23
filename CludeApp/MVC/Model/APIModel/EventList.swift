//
//  EventList.swift
//
//  Created by Reus on 04/09/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EventList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let timeStoppers = "time_stoppers"
    static let safeZones = "safeZones"
    static let createdAt = "createdAt"
    static let outcome = "outcome"
    static let price = "price"
    static let reviews = "reviews"
    static let status = "status"
    static let witnesses = "witnesses"
    static let suspects = "suspects"
    static let id = "_id"
    static let evidences = "evidences"
    static let updatedAt = "updatedAt"
    static let v = "__v"
    static let startLocation = "startLocation"
    static let caseNotes = "caseNotes"
    static let leaderboard = "leaderboard"
  }

  // MARK: Properties
  public var name: String?
  public var timeStoppers: [TimeStoppers]?
  public var safeZones: [Any]?
  public var createdAt: String?
  public var outcome: String?
  public var price: Int?
  public var reviews: [Any]?
  public var status: String?
  public var witnesses: [Witnesses]?
  public var suspects: [Suspects]?
  public var id: String?
  public var evidences: [Evidences]?
  public var updatedAt: String?
  public var v: Int?
  public var startLocation: StartLocation?
  public var caseNotes: String?
  public var leaderboard: [Leaderboard]?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    name = json[SerializationKeys.name].string
    if let items = json[SerializationKeys.timeStoppers].array { timeStoppers = items.map { TimeStoppers(json: $0) } }
    if let items = json[SerializationKeys.safeZones].array { safeZones = items.map { $0.object} }
    createdAt = json[SerializationKeys.createdAt].string
    outcome = json[SerializationKeys.outcome].string
    price = json[SerializationKeys.price].int
    if let items = json[SerializationKeys.reviews].array { reviews = items.map { $0.object} }
    status = json[SerializationKeys.status].string
  
    if let items = json[SerializationKeys.witnesses].array {
        witnesses = []
        for (index, witnes) in items.enumerated() {
            var jWitnes = witnes
            jWitnes["index"] = JSON(index)
            let wtns = Witnesses(json: jWitnes)
            witnesses?.append(wtns)
        }
        
    }
    
    var suspectIndex = 0
    if let items = json[SerializationKeys.suspects].array { suspects = items.map { jSuspect in
        var json = jSuspect
        suspectIndex += 1
        json["index"]  = JSON(suspectIndex)
        return Suspects(json: json)
        }
    }
    
    id = json[SerializationKeys.id].string
    
    if let items = json[SerializationKeys.evidences].array {
        evidences = []
        for (index, evdns) in items.enumerated() {
            var jEvd = evdns
            jEvd["index"] = JSON(index)
            let evdns = Evidences(json: jEvd)
            evidences?.append(evdns)
        }
    
    }
    
    
    updatedAt = json[SerializationKeys.updatedAt].string
    v = json[SerializationKeys.v].int
    startLocation = StartLocation(json: json[SerializationKeys.startLocation])
    caseNotes = json[SerializationKeys.caseNotes].string
    if let items = json[SerializationKeys.leaderboard].array { leaderboard = items.map { Leaderboard(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = timeStoppers { dictionary[SerializationKeys.timeStoppers] = value.map { $0.dictionaryRepresentation() } }
    if let value = safeZones { dictionary[SerializationKeys.safeZones] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = outcome { dictionary[SerializationKeys.outcome] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    if let value = reviews { dictionary[SerializationKeys.reviews] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = witnesses { dictionary[SerializationKeys.witnesses] = value.map { $0.dictionaryRepresentation() } }
    if let value = suspects { dictionary[SerializationKeys.suspects] = value.map { $0.dictionaryRepresentation() } }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = evidences { dictionary[SerializationKeys.evidences] = value.map { $0.dictionaryRepresentation() } }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = v { dictionary[SerializationKeys.v] = value }
    if let value = startLocation { dictionary[SerializationKeys.startLocation] = value.dictionaryRepresentation() }
    if let value = caseNotes { dictionary[SerializationKeys.caseNotes] = value }
    if let value = leaderboard { dictionary[SerializationKeys.leaderboard] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.timeStoppers = aDecoder.decodeObject(forKey: SerializationKeys.timeStoppers) as? [TimeStoppers]
    self.safeZones = aDecoder.decodeObject(forKey: SerializationKeys.safeZones) as? [Any]
    self.createdAt = aDecoder.decodeObject(forKey: SerializationKeys.createdAt) as? String
    self.outcome = aDecoder.decodeObject(forKey: SerializationKeys.outcome) as? String
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? Int
    self.reviews = aDecoder.decodeObject(forKey: SerializationKeys.reviews) as? [Any]
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.witnesses = aDecoder.decodeObject(forKey: SerializationKeys.witnesses) as? [Witnesses]
    self.suspects = aDecoder.decodeObject(forKey: SerializationKeys.suspects) as? [Suspects]
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.evidences = aDecoder.decodeObject(forKey: SerializationKeys.evidences) as? [Evidences]
    self.updatedAt = aDecoder.decodeObject(forKey: SerializationKeys.updatedAt) as? String
    self.v = aDecoder.decodeObject(forKey: SerializationKeys.v) as? Int
    self.startLocation = aDecoder.decodeObject(forKey: SerializationKeys.startLocation) as? StartLocation
    self.caseNotes = aDecoder.decodeObject(forKey: SerializationKeys.caseNotes) as? String
    self.leaderboard = aDecoder.decodeObject(forKey: SerializationKeys.leaderboard) as? [Leaderboard]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(timeStoppers, forKey: SerializationKeys.timeStoppers)
    aCoder.encode(safeZones, forKey: SerializationKeys.safeZones)
    aCoder.encode(createdAt, forKey: SerializationKeys.createdAt)
    aCoder.encode(outcome, forKey: SerializationKeys.outcome)
    aCoder.encode(price, forKey: SerializationKeys.price)
    aCoder.encode(reviews, forKey: SerializationKeys.reviews)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(witnesses, forKey: SerializationKeys.witnesses)
    aCoder.encode(suspects, forKey: SerializationKeys.suspects)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(evidences, forKey: SerializationKeys.evidences)
    aCoder.encode(updatedAt, forKey: SerializationKeys.updatedAt)
    aCoder.encode(v, forKey: SerializationKeys.v)
    aCoder.encode(startLocation, forKey: SerializationKeys.startLocation)
    aCoder.encode(caseNotes, forKey: SerializationKeys.caseNotes)
    aCoder.encode(leaderboard, forKey: SerializationKeys.leaderboard)
  }

}
