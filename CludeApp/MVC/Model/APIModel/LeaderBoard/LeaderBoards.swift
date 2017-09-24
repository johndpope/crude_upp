//
//  LeaderBoards.swift
//
//  Created by Reus on 24/09/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LeaderBoards: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let score = "score"
    static let startedAtMili = "startedAt_mili"
    static let startedAt = "startedAt"
    static let minutesDelay = "minutesDelay"
    static let timestamp = "timestamp"
    static let time = "time"
    static let endedAtMili = "endedAt_mili"
    static let endedAt = "endedAt"
  }

  // MARK: Properties
  public var name: String?
  public var score: Int?
  public var startedAtMili: Float?
  public var startedAt: Float?
  public var minutesDelay: Int?
  public var timestamp: Int?
  public var time: Float?
  public var endedAtMili: Float?
  public var endedAt: Float?

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
    score = json[SerializationKeys.score].int
    startedAtMili = json[SerializationKeys.startedAtMili].float
    startedAt = json[SerializationKeys.startedAt].float
    minutesDelay = json[SerializationKeys.minutesDelay].int
    timestamp = json[SerializationKeys.timestamp].int
    time = json[SerializationKeys.time].float
    endedAtMili = json[SerializationKeys.endedAtMili].float
    endedAt = json[SerializationKeys.endedAt].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = score { dictionary[SerializationKeys.score] = value }
    if let value = startedAtMili { dictionary[SerializationKeys.startedAtMili] = value }
    if let value = startedAt { dictionary[SerializationKeys.startedAt] = value }
    if let value = minutesDelay { dictionary[SerializationKeys.minutesDelay] = value }
    if let value = timestamp { dictionary[SerializationKeys.timestamp] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = endedAtMili { dictionary[SerializationKeys.endedAtMili] = value }
    if let value = endedAt { dictionary[SerializationKeys.endedAt] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.score = aDecoder.decodeObject(forKey: SerializationKeys.score) as? Int
    self.startedAtMili = aDecoder.decodeObject(forKey: SerializationKeys.startedAtMili) as? Float
    self.startedAt = aDecoder.decodeObject(forKey: SerializationKeys.startedAt) as? Float
    self.minutesDelay = aDecoder.decodeObject(forKey: SerializationKeys.minutesDelay) as? Int
    self.timestamp = aDecoder.decodeObject(forKey: SerializationKeys.timestamp) as? Int
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? Float
    self.endedAtMili = aDecoder.decodeObject(forKey: SerializationKeys.endedAtMili) as? Float
    self.endedAt = aDecoder.decodeObject(forKey: SerializationKeys.endedAt) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(score, forKey: SerializationKeys.score)
    aCoder.encode(startedAtMili, forKey: SerializationKeys.startedAtMili)
    aCoder.encode(startedAt, forKey: SerializationKeys.startedAt)
    aCoder.encode(minutesDelay, forKey: SerializationKeys.minutesDelay)
    aCoder.encode(timestamp, forKey: SerializationKeys.timestamp)
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(endedAtMili, forKey: SerializationKeys.endedAtMili)
    aCoder.encode(endedAt, forKey: SerializationKeys.endedAt)
  }

}
