//
//  CLConstant.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit

let ScreenSize = UIScreen.main.bounds.size

let widthRatio =  isPad ? 1.4 : ScreenSize.width/375

var isPad: Bool {
 return UI_USER_INTERFACE_IDIOM() == .pad
}

class CLConstant: NSObject {

    static let witnessBaseURL = "https://s3.amazonaws.com/clueup2/"
    
    static let runningEventID = "runningEvent"
    static let runningEventTeamID = "runningEventTeamID"

    static let homeFirstTime = "home"
    static let evideFirstTime = "evidence"
    static let suspectFirstTime = "suspects"
    
    struct NotificationObserver {
        
        static let cannotFound = "cannotFound"
        static let hint = "hint"
        static let stoppper = "stopper"
        
    }
    
    
    
    static var firstHome: Bool? {
        set{
            UserDefaults.standard.set(newValue, forKey: homeFirstTime)
        }get{
            return UserDefaults.standard.bool(forKey: homeFirstTime)
        }
    }
    
    static var firstSuspect: Bool? {
        set{
            UserDefaults.standard.set(newValue, forKey: suspectFirstTime)
        }get{
            return UserDefaults.standard.bool(forKey: suspectFirstTime)
        }
    }
    
    static var firstEvidence: Bool? {
        set{
            UserDefaults.standard.set(newValue, forKey: evideFirstTime)
        }get{
            return UserDefaults.standard.bool(forKey: evideFirstTime)
        }
    }
    
    
    struct storyBoard {
        
         static let main       = UIStoryboard(name: "Main", bundle: nil)
         static let dashBoard  = UIStoryboard(name: "DashBoard", bundle: nil)
    }
    
    
    struct Alert {
        
        static let dashTitle = "Hi Detective,"
        static let dashMsg   = "Here's a handy induction video to get you started. Once you've wathced it once, you'll be able to find it again under the \"Instructions\" menu option"
        static let dashButton = "VIEW"
        
        static let evidMsg  = "Please press on a weapon and hold-down to eliminate it from your list."
        static let gotIt = "GOT IT"
        static let suspectMsg  = "Please press on a suspect and hold-down to eliminate it from your list."
        
        static let startGameTitle = "Start Game Now"
        static let startGameMessage = "If you press the button below your game-timer will start, do you wish to procced?"
        
        static let startGameButton = "YES, START MY GAME"
        

    }
    
    
    struct delegatObj {
        
        static let appDelegate = UIApplication.shared.delegate as! CLAppDelegate
    }
    
    struct Keys {
        
        //AIzaSyBgvkLk7iNVEirXbBT7eLjVzwNZCjVJ3Tk  // new key (build 1.1)
        //AIzaSyBI0dBQQIjc3omEFjgKtO9ZPtjCKUPh8w4 // my key
        //AIzaSyCMeC7Dc6JB8Xj_VORIOG2KSSPRRakhJC4 //hoodbok client key // set while sending build
        
        static let map = "AIzaSyBI0dBQQIjc3omEFjgKtO9ZPtjCKUPh8w4"
    }
    
}


class WidthLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      self.font = UIFont(name: self.font.fontName, size: self.font.pointSize * widthRatio)
    }
}
