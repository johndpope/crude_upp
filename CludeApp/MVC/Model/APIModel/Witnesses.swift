//
//  Witnesses.swift
//
//  Created by Reus on 04/09/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Witnesses: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let location = "location"
    static let image = "image"
    static let locationLine = "location_line"
    static let hint = "hint"
    static let visible = "visible"
    static let statement = "statement"
    static let question = "question"
    static let index = "index"
  }

  // MARK: Properties
  public var name: String?
  public var location: Location?
  public var image: Image?
  public var locationLine: String?
  public var hint: String?
  public var visible: Bool? = false
  public var statement: String?
  public var question: Question?
    
    public var index = 0

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
    location = Location(json: json[SerializationKeys.location])
    image = Image(json: json[SerializationKeys.image])
    locationLine = json[SerializationKeys.locationLine].string
    hint = json[SerializationKeys.hint].string
    visible = json[SerializationKeys.visible].boolValue
    statement = json[SerializationKeys.statement].string
    question = Question(json: json[SerializationKeys.question])
    index = json[SerializationKeys.index].int ?? 0
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
    if let value = image { dictionary[SerializationKeys.image] = value.dictionaryRepresentation() }
    if let value = locationLine { dictionary[SerializationKeys.locationLine] = value }
    if let value = hint { dictionary[SerializationKeys.hint] = value }
    dictionary[SerializationKeys.visible] = visible
    if let value = statement { dictionary[SerializationKeys.statement] = value }
    if let value = question { dictionary[SerializationKeys.question] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.index] = index
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? Location
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? Image
    self.locationLine = aDecoder.decodeObject(forKey: SerializationKeys.locationLine) as? String
    self.hint = aDecoder.decodeObject(forKey: SerializationKeys.hint) as? String
    self.visible = aDecoder.decodeBool(forKey: SerializationKeys.visible)
    self.statement = aDecoder.decodeObject(forKey: SerializationKeys.statement) as? String
    self.question = aDecoder.decodeObject(forKey: SerializationKeys.question) as? Question
    self.index = aDecoder.decodeObject(forKey: SerializationKeys.index) as! Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(location, forKey: SerializationKeys.location)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(locationLine, forKey: SerializationKeys.locationLine)
    aCoder.encode(hint, forKey: SerializationKeys.hint)
    aCoder.encode(visible, forKey: SerializationKeys.visible)
    aCoder.encode(statement, forKey: SerializationKeys.statement)
    aCoder.encode(question, forKey: SerializationKeys.question)
    aCoder.encode(index, forKey: SerializationKeys.index)

  }

}
