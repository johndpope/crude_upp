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
    
    lazy var requestedComponent: Set<Calendar.Component> = [.year,.month,.hour,.minute,.second,.nanosecond]
    
    var timeInHHMMSS: String {
        let miliseconds = Int(self.time!)
        let minutesTemp = miliseconds / 1000 / 60
        let h = minutesTemp / 60
        let m = (miliseconds - h * 60 * 60 * 1000) / 1000 / 60
        let s = (miliseconds - h * 60 * 60 * 1000 - m * 60 * 1000) / 1000

//        let h = (time! / 3600000).truncatingRemainder(dividingBy: 24)
//        let m = (time! / 60000).truncatingRemainder(dividingBy: 60)
//        let s = (time! / 1000).truncatingRemainder(dividingBy: 60)
//        
        return "\(Int(h) > 9 ? "\(Int(h))" : "0\(Int(h))"):\(Int(m) > 9 ? "\(Int(m))" : "0\(Int(m))"):\(Int(s) > 9 ? "\(Int(s))" : "0\(Int(s))")"
    }
    
    
    func convertTime(miliseconds: Int) -> String {
        
        var seconds: Int = 0
        var minutes: Int = 0
        var hours: Int = 0
        var days: Int = 0
        var secondsTemp: Int = 0
        var minutesTemp: Int = 0
        var hoursTemp: Int = 0
        
        if miliseconds < 1000 {
            return ""
        } else if miliseconds < 1000 * 60 {
            seconds = miliseconds / 1000
            return "\(seconds) seconds"
        } else if miliseconds < 1000 * 60 * 60 {
            secondsTemp = miliseconds / 1000
            minutes = secondsTemp / 60
            seconds = (miliseconds - minutes * 60 * 1000) / 1000
            return "\(minutes) minutes, \(seconds) seconds"
        } else if miliseconds < 1000 * 60 * 60 * 24 {
            minutesTemp = miliseconds / 1000 / 60
            hours = minutesTemp / 60
            minutes = (miliseconds - hours * 60 * 60 * 1000) / 1000 / 60
            seconds = (miliseconds - hours * 60 * 60 * 1000 - minutes * 60 * 1000) / 1000
            return "\(hours) hours, \(minutes) minutes, \(seconds) seconds"
        } else {
            hoursTemp = miliseconds / 1000 / 60 / 60
            days = hoursTemp / 24
            hours = (miliseconds - days * 24 * 60 * 60 * 1000) / 1000 / 60 / 60
            minutes = (miliseconds - days * 24 * 60 * 60 * 1000 - hours * 60 * 60 * 1000) / 1000 / 60
            seconds = (miliseconds - days * 24 * 60 * 60 * 1000 - hours * 60 * 60 * 1000 - minutes * 60 * 1000) / 1000
            return "\(days) days, \(hours) hours, \(minutes) minutes, \(seconds) seconds"
        }
    }

    var dateFormattor: DateFormatter = {
        let dateformator = DateFormatter()
        dateformator.dateFormat = "dd/MM/yyyy"
        dateformator.timeZone = TimeZone.current
        return dateformator
    }()
    
    var todayEvent: Bool {

        let startDateTime = Date(timeIntervalSince1970: 1506447604871.0)
        let stDateStr = dateFormattor.string(from: startDateTime)
        let nowDateStr = dateFormattor.string(from: Date())
        
        print("TIMESTAMP:\(Double(timestamp!))")
        print("STARTDATE: \(stDateStr)")
        print("TODAYDATE: \(nowDateStr)")

        return stDateStr == nowDateStr ? true:false
        
    }
    
    
    
    func checkDate(timeStamp:Int)->Bool{
    
        let startDateTime = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let stDateStr = dateFormattor.string(from: startDateTime)
        let nowDateStr = dateFormattor.string(from: Date())
        
        print("TIMESTAMP:\(timeStamp)")
        print("STARTDATE: \(stDateStr)")
        print("TODAYDATE: \(nowDateStr)")
        
        return stDateStr == nowDateStr ? true:false
        
    }
    
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
