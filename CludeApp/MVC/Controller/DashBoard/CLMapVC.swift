//
//  CLMapVC.swift
//  CludeApp
//
//  Created by Reus on 03/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//




import UIKit

class CLMapVC: UIViewController {

    @IBOutlet weak var viewMapContainer: UIView!
    
    var mapIntrogation:CLMapView?
    var event:EventList?
    var event_local:Event_db_cludeUpp?
    var witnessArray = [Witnesses_db_cludeUpp]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        witnessArray = event_local?.witnesses?.allObjects as! [Witnesses_db_cludeUpp]
        witnessArray = witnessArray.sorted(by: { ($0.name?.characters.count)! > ($1.name?.characters.count)! })
        
        mapIntrogation = (Bundle.main.loadNibNamed("CLMapView",owner : nil,options:nil)?[0] as? UIView) as? CLMapView
        mapIntrogation?.frame.size.height = viewMapContainer.bounds.height
        mapIntrogation?.frame.size.width  = viewMapContainer.bounds.width
        mapIntrogation?.getCurrentLocation(from: self)
        mapIntrogation?.arrayWitnesses = witnessArray
        DispatchQueue.main.async {
            
             self.viewMapContainer.addSubview(self.mapIntrogation!)
        }
        
        mapIntrogation?.customizeMap(witnesses:witnessArray,timeStopperObj:event_local?.timeStoppersLocation?.allObjects as! [TimeStopperLocation_db])


    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        mapIntrogation?.locationManager.startUpdatingLocation()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        mapIntrogation?.locationManager.stopUpdatingLocation()
    }
    
    
    
    @IBAction func backTapped(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnViewListTapped(_ sender: Any) {
        
        let aViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: CLMapListVC.self)) as! CLMapListVC
        aViewController.witness = self.witnessArray
        aViewController.protocolWitness = self
        DispatchQueue.main.async {
            
            self.navigationController?.pushViewController(aViewController, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension CLMapVC:WitnessTapped{
    
   func didIntrogateWitness(witness: Witnesses_db_cludeUpp) {
        if witness.introgatted {
            
            self.showCaseNotePopUpHint(from: self,
                                   text: witness.statement!,
                                   testinomy: true,
                                   imgID:(witness.witnessImage?.id)!,
                                   name:witness.name!,
                                   showHint: witness.showHint,
                                   hint: witness.hint!,
                                   witnessData: witness,
                                   checkWitness: { (succes) in
                                    
                                    
            })
        }
    }


    func didTapAtWintess(witness: Witnesses_db_cludeUpp) {
        
        self.mapIntrogation?.changeMarker(witness: witness)
    }

    
    
    
}




