//
//  Suspects.swift
//
//  Created by Reus on 04/09/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Suspects: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let designated = "designated"
    static let name = "name"
    static let image = "image"
    static let index = "index"
  }

  // MARK: Properties
  public var designated: Bool? = false
  public var name: String?
  public var image: Image?
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
    designated = json[SerializationKeys.designated].boolValue
    name = json[SerializationKeys.name].string
    image = Image(json: json[SerializationKeys.image])
    index = json[SerializationKeys.index].int!
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.designated] = designated
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = image { dictionary[SerializationKeys.image] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.index] = index

    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.designated = aDecoder.decodeBool(forKey: SerializationKeys.designated)
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? Image
    self.index = aDecoder.decodeObject(forKey: SerializationKeys.index) as? Int ?? 0
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(designated, forKey: SerializationKeys.designated)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(index, forKey: SerializationKeys.index)
  }

}
