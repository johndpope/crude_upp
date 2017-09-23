//
//  Event_db_cludeUpp+CoreDataClass.swift
//  CludeApp
//
//  Created by Reus on 15/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import Foundation
import CoreData
import MagicalRecord

@objc(Event_db_cludeUpp)
public class Event_db_cludeUpp: NSManagedObject {

    
    static func syncEventInCoreData(event:EventList,teamName:String){
    
        MagicalRecord.save({ (localContext) in
            
            let predicate = NSPredicate(format: "id = %@", event.id!)
            
          //  if Event_db_cludeUpp.mr_countOfEntities(with: predicate, in: localContext) == 0{
                
                let eventContext = Event_db_cludeUpp.mr_create(in: localContext) as! Event_db_cludeUpp
                
                eventContext.teamName         = teamName
                eventContext.name             = event.name
                eventContext.createdAt        = event.createdAt
                eventContext.id               = event.id
                eventContext.price            = "\((event.price)!)"
                eventContext.status           = event.status
                eventContext.v                = Int16(event.v!)
                eventContext.safeZones        = event.safeZones!
                eventContext.reviews          = event.reviews!
                eventContext.caseNotes        = event.caseNotes
                eventContext.timeConsume      = 0
                eventContext.startedAt        = Date().timeIntervalSince1970
                eventContext.endedAt          = 0
                eventContext.delayTime        = 0
                eventContext.isCompleted      = false
                
                for witness_event in event.witnesses!{
                    
                    let witness_db = Witnesses_db_cludeUpp.mr_create(in: localContext) as! Witnesses_db_cludeUpp
                    witness_db.name         = witness_event.name
                    witness_db.hint         = witness_event.hint
                    witness_db.locationLine = witness_event.locationLine
                    witness_db.introgatted  = false
                    witness_db.coolDown     = false
                    witness_db.showHint     = false
                    witness_db.statement    = witness_event.statement
                    // add witnesss location to 
                    
                    witness_db.witnessLocation        = WitnessLocation_db.mr_create(in: localContext) as? WitnessLocation_db
                    witness_db.witnessLocation?.lat   = (witness_event.location?.lat)!
                    witness_db.witnessLocation?.long  = (witness_event.location?.lng)!
                    
                    witness_db.index = Int32(witness_event.index)
                    // add witness question
                    
                    witness_db.witnessQuestion  = WitnessQue_db.mr_create(in: localContext) as? WitnessQue_db
                    
                    witness_db.witnessQuestion?.text = witness_event.question?.text
                    
                    
                    witness_db.witnessImage = WitnessImage_db.mr_create(in: localContext) as? WitnessImage_db
                    witness_db.witnessImage?.id = witness_event.image?.id
                    
                    
                    for options in (witness_event.question?.options)!{
                    
                        let witness_opt_db = WitnessOption_db.mr_create(in: localContext) as! WitnessOption_db
                        
                        witness_opt_db.text         = options.text
                        witness_opt_db.isCorrect    = options.isCorrect!
                        
                        witness_db.witnessQuestion?.addToOptions(witness_opt_db)
                    }
                    
                    eventContext.addToWitnesses(witness_db)
                    
                }
                
                // evidence to core data with event relationship
                for evidence_event in event.evidences!{
                    
                    let evidence_db = Evidences_db.mr_create(in: localContext) as! Evidences_db
                    evidence_db.name = evidence_event.name
                    evidence_db.isCross = false
                    evidence_db.designation = evidence_event.designated! ? "1" : "0"
                    evidence_db.index = Int32(evidence_event.index)
                    // evidence image is sub relationship
                    evidence_db.evidenceImage = EvidenceImage_db.mr_create(in: localContext) as? EvidenceImage_db
                    evidence_db.evidenceImage?.id = evidence_event.image?.id
                    eventContext.addToEvidences(evidence_db)
                    
                }
            
                for suspect_event in event.suspects!{
                
                    let suspect_db = Suspects_db.mr_create(in : localContext) as! Suspects_db
                    
                    suspect_db.name = suspect_event.name
                    suspect_db.isCross = false
                    suspect_db.designation = suspect_event.designated! ? "1" : "0"
                    // suspect image relationship
                    suspect_db.index = Int32(suspect_event.index)
                    suspect_db.suspectImage = SuspectImage_db.mr_create(in: localContext) as? SuspectImage_db
               
                    suspect_db.suspectImage?.id = suspect_event.image?.id
                    
                    eventContext.addToSuspects(suspect_db)
                }
                
                
            //}
            
        }) { (success, error) in
            
        }
        
        CLConstant.delegatObj.appDelegate.saveMagicalContext()
    }
    
}

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
