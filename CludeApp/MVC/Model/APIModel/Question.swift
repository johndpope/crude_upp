//
//  Question.swift
//
//  Created by Reus on 04/09/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Question: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let options = "options"
    static let text = "text"
  }

  // MARK: Properties
  public var options: [Options]?
  public var text: String?

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
    if let items = json[SerializationKeys.options].array { options = items.map { Options(json: $0) } }
    text = json[SerializationKeys.text].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = options { dictionary[SerializationKeys.options] = value.map { $0.dictionaryRepresentation() } }
    if let value = text { dictionary[SerializationKeys.text] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.options = aDecoder.decodeObject(forKey: SerializationKeys.options) as? [Options]
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(options, forKey: SerializationKeys.options)
    aCoder.encode(text, forKey: SerializationKeys.text)
  }

}
