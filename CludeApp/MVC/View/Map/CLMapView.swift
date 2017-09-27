//
//  HBMapView.swift
//  HoodBook_GMaps
//
//  Created by SOTSYS198 on 29/04/17.
//  Copyright © 2017 SOTSYS198. All rights reserved.
//




import UIKit
import GoogleMaps
import SDWebImage
import AudioToolbox


@objc class CLMapView: UIView, GMSMapViewDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var viewMap: GMSMapView!
    
    let locationManager =  CLLocationManager()
    var VC = UIViewController()
    var arrayWitnesses: [Witnesses_db_cludeUpp]?
    var timeStopperObj:[TimeStopperLocation_db]?
    var markerObject = [GMSMarker]()
    
    var counter = 0
    var timer : Timer?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        locationManager.delegate = self
        //getCurrentLocation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        locationManager.delegate = self
        
        // getCurrentLocation()
        
    }
    
    
    /*!
     *@Customize map initially set current location of user
     *@add pin and make draggable
     */
    
    func customizeMap() -> Void {
        
        
        if locationManager.location?.coordinate != nil {
            
            let camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: kGMSMaxZoomLevel)
            viewMap.camera = camera
            
            
            let setting = viewMap.settings
            setting.consumesGesturesInView = false
            viewMap.delegate = self

            viewMap.isMyLocationEnabled = true
           /* let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
            marker.map = viewMap
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            getAddress(marker: marker)*/
            
            
        }
        
    }
    
    /*!
     * @absrtact customize map for update address
     */
    
    func customizeMap(lattutude:Double, longitude:Double){
        
        self.viewMap.clear()
        let camera = GMSCameraPosition.camera(withLatitude: lattutude, longitude: longitude, zoom: 12.0)
        viewMap.camera = camera
        viewMap.isMyLocationEnabled = true
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lattutude, longitude: longitude)
        marker.map = viewMap
        marker.icon = #imageLiteral(resourceName: "mappin")
        viewMap.delegate = self
        viewMap.isUserInteractionEnabled = true
        marker.isDraggable = true
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        getAddress(marker: marker)
        viewMap.animate(toLocation: marker.position)
        
    }
    
    
    
    func changeMarker(witness:Witnesses_db_cludeUpp){
    
        for marker_tapped in self.markerObject {
            
            if marker_tapped.position.isEqualLocation(CLLocationCoordinate2D(latitude: Double((witness.witnessLocation?.lat)!), longitude: Double((witness.witnessLocation?.long)!))) {
                
                if marker_tapped.iconView != nil{
                    let pinView:RKPinView = marker_tapped.iconView as! RKPinView
                    pinView.imgBox.image = #imageLiteral(resourceName: "full_box_green.png")
                    pinView.imgCheck.isHidden = false
                    self.viewMap.selectedMarker = nil
                    
                }
            }
        }
        
        
    }
    
    
    func customizeMap(witnesses:[Witnesses_db_cludeUpp],timeStopperObj:[TimeStopperLocation_db]){
    
        
        self.arrayWitnesses = witnesses
        
        self.timeStopperObj = timeStopperObj
        
        for witness in witnesses {
            
            let marker = GMSMarker()
            
            
            marker.position = CLLocationCoordinate2D(latitude: Double(( witness.witnessLocation?.lat)!),
                                                     longitude: Double((witness.witnessLocation?.long)!))
            marker.title = witness.name
            marker.snippet = witness.locationLine
            marker.map = viewMap
            
            
            marker.userData  = witness
            
            let pinView = (Bundle.main.loadNibNamed("RKPinView",owner : nil,options:nil)?[0] as? UIView) as! RKPinView
            
            if witness.introgatted {
                
                pinView.imgBox.image = #imageLiteral(resourceName: "full_box_green.png")
                pinView.imgCheck.isHidden = false
                
            }else{
                pinView.imgBox.image = #imageLiteral(resourceName: "full_box.png")
                pinView.imgCheck.isHidden = true


            }
            
            pinView.viewActivity.stopAnimating()
            pinView.witnessImage.sd_setImageWithPreviousCachedImage(with: URL(string: CLConstant.witnessBaseURL+(witness.witnessImage?.id!)!),
                                                               placeholderImage: #imageLiteral(resourceName: "loading.jpg"),
                                                               options: SDWebImageOptions(rawValue: 0),
                                                               progress: nil) { (image, error, chache, url) in
                                                                
                                                                DispatchQueue.main.async {
                                                                    pinView.viewActivity.stopAnimating()
                                                                }
            
            marker.iconView = pinView
                                                                
                                                                if !self.markerObject.contains(marker){
                                                                    self.markerObject.append(marker)
                                                                }
                                                                
        }
    
    }
    
    }
    
        
    
    /*!
     *@get Current location
     */
    
    func getCurrentLocation(from:UIViewController) -> Void {
        
        VC = from
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager.requestWhenInUseAuthorization()
            
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
        self.customizeMap()
    }
    
    /*!
     *@get Current location
     */
    
    func getCurrentLocation() -> Void {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()

            
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
        
    }
    
    
    
    /*!
     *@check location service is enable or not
     */
    
    
    func checkLocationService()->Bool{
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
                return false
            case .authorizedWhenInUse:
                print("Access")
                return true
            case .authorizedAlways:
                return false
            }
        } else {
            return false
        }
        
    }
    
    
    
    
    
    /*!
     *@location manager delegate method
     */
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch status {
            case .notDetermined:
                // If status has not yet been determied, ask for authorization
                manager.requestWhenInUseAuthorization()
                break
            case .authorizedWhenInUse:
                // If authorized when in use
                customizeMap()
                manager.startUpdatingLocation()
                break
            case .authorizedAlways:
                // If always authorized
                customizeMap()
                manager.startUpdatingLocation()
                break
            case .restricted:
                // If restricted by e.g. parental controls. User can't enable Location Services
                break
            case .denied:
                // If user denied your app access to Location Services, but can grant access from Settings.app
                break
            }
            
        }else{
            
        }
        
    }
    
    
    
    func getAddress(marker : GMSMarker) -> Void {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
            
            if let address = response?.firstResult() {
                
                print("Full Address \n \(address)")
                print("Lines \n \(address.lines!)")
            }
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker){
        
        getAddress(marker: marker)
    }
    
    
    
    
    
    /*!
     *@abstract get lattitude and longitude from address
     *@abstract "Neighbourhood- confimation"
     */
    
    func getLatLongFromAddress(address:String,from:UIViewController) -> Void {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            
            if let placemark = placemarks?[0]{
                
                self.viewMap.clear()
                
                let marker = GMSMarker()
                
                marker.position = CLLocationCoordinate2D(latitude: (placemark.location!.coordinate.latitude), longitude: ( placemark.location!.coordinate.longitude))
                
                marker.map = self.viewMap
                marker.icon = #imageLiteral(resourceName: "mappin")
                self.viewMap.isUserInteractionEnabled = true
                self.viewMap.delegate = nil
                marker.isDraggable = false
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2,
                                              execute: {
                                                self.viewMap.animate(toZoom: 14.0)
                                                self.viewMap.animate(toLocation: marker.position)
                })
            }else{
            }
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        viewMap.selectedMarker = nil
        
        let witnessData = marker.userData as! Witnesses_db_cludeUpp
//        self.cannotBeFound(witness: witnessData)
        
        /*if witness.introgatted {
         
         pinView.imgBox.image = #imageLiteral(resourceName: "full_box_green.png")
         pinView.imgCheck.isHidden = false
         
         }else{
         pinView.imgBox.image = #imageLiteral(resourceName: "full_box.png")
         pinView.imgCheck.isHidden = true
         
         
         }*/
        VC.showCannotFoundPopup(from: VC) { (success) in
            
            if success{
                
                witnessData.introgatted = true
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.cannotFound), object: nil, userInfo: nil)
                
                self.VC.showCaseNotePopUpHint(from: self.VC,
                                          text: (witnessData.statement)!,
                                          testinomy: true,
                                          imgID:"",
                                          name:"",
                                          showHint:witnessData.showHint,
                                          hint:witnessData.hint!,
                                          witnessData: witnessData)
                
                
                let pinView:RKPinView = marker.iconView as! RKPinView
                
                pinView.imgBox.image = #imageLiteral(resourceName: "full_box_green.png")
                pinView.imgCheck.isHidden = false
                
               // self.customizeMap(witnesses: self.arrayWitnesses!)
                
            }
        }
        
        
    }
    
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        let witnessData = marker.userData as! Witnesses_db_cludeUpp
        
        if witnessData.introgatted {
            
            VC.showCaseNotePopUpHint(from: VC,
                                 text: witnessData.statement!,
                                 testinomy: true,
                                 imgID: (witnessData.witnessImage?.id)!,
                                 name: witnessData.name!,
                                 showHint:witnessData.showHint,
                                  hint:witnessData.hint!,
                                  witnessData: witnessData)
            
            return nil
            
        }else{
            
            let placeLocation = CLLocation(latitude: Double((witnessData.witnessLocation?.lat)!),
                                           longitude: Double((witnessData.witnessLocation?.long)!))
            
            let distanceInMeters:Double = (self.locationManager.location?.distance(from: placeLocation))!
            
            if distanceInMeters < Double(20.0){
                
                if witnessData.coolDown && !(CLConstant.delegatObj.appDelegate.questionAlreadyinWindow){
                    CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = true
                    self.viewMap.selectedMarker = nil
                    
                    VC.showCoolDownPopUp(from: VC, wrongAns: true)
                    
                }else{
                    
                    VC.showQuestionDailougeForWitness(from: VC,
                                                      witness: witnessData,
                                                      action: { (correct) in
                                                        
                                                        if correct{
                                                            self.viewMap.selectedMarker = nil
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2,
                                                                                          execute: {
                                                                                            witnessData.introgatted = true
                                                                                            
                                                                                            self.changeMarker(witness: witnessData)
                                                                                            
                                                                                            self.arrayWitnesses = self.arrayWitnesses?.filter { $0 != witnessData }
                                                                                            
                                                                                            CLConstant.delegatObj.appDelegate.saveMagicalContext()
                                                            })
                                                            
                                                            self.VC.showCaseNotePopUpHint(from: self.VC,
                                                                                      text: (witnessData.statement)!,
                                                                                      testinomy: true,
                                                                                      imgID:"",
                                                                                      name:"",
                                                                                      showHint:witnessData.showHint,
                                                                                       hint:witnessData.hint!,
                                                                                       witnessData: witnessData)
                                                            
                                                        }else{
                                                            witnessData.coolDown  = true
                                                            self.viewMap.selectedMarker = nil
                                                            CLConstant.delegatObj.appDelegate.saveMagicalContext()

                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 60, execute: {
                                                                
                                                                self.removeCoolDown(witness: witnessData)
                                                            })
                                                            
                                                            self.VC.showSubmitPopUp(from: self.VC,wrongAns:true)
                                                            
                                                        }
                                                        
                    })
                }
                    
                return nil
                
            }else{
                
                let infoWindow = Bundle.main.loadNibNamed("RKCalloutView", owner: self.viewMap, options: nil)!.first! as! RKCalloutView
                
                infoWindow.lblWitnessName.text = witnessData.name
                infoWindow.viewActivity.stopAnimating()
                infoWindow.imgWitness.sd_setImageWithPreviousCachedImage(with: URL(string: CLConstant.witnessBaseURL+(witnessData.witnessImage?.id!)!),
                                                                         placeholderImage: #imageLiteral(resourceName: "loading.jpg"),
                                                                         options: SDWebImageOptions(rawValue: 0),
                                                                         progress: nil) { (image, error, chache, url) in
                                                                            
                                                                            DispatchQueue.main.async {
                                                                                
                                                                                infoWindow.viewActivity.stopAnimating()
                                                                            }
                                                                            
                }
                return infoWindow
                
            }
            
            
            
        }
        
        
     }
    
    
    
    func removeCoolDown(witness:Witnesses_db_cludeUpp){
        
        witness.coolDown = false
        CLConstant.delegatObj.appDelegate.saveMagicalContext()
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
      //  let coordinate = locations.last?.coordinate
//        let camera = GMSCameraPosition.camera(withLatitude: (coordinate?.latitude)!, longitude: (coordinate?.longitude)!, zoom: 14.0)
//        viewMap.camera = camera
        if (self.arrayWitnesses?.count)! > 1 {
            self.getDistance()
        }
        
       // self.getTimeStoppperObj(location: locations.first!)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError",error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("didStartMonitoringFor")
    }
    
    
    func getDistance() {
        
        self.arrayWitnesses = self.arrayWitnesses?.filter { $0.introgatted == false }
        
        let array = self.arrayWitnesses?.map({ (place) -> Witnesses_db_cludeUpp in
            
            
            let placeLocation = CLLocation(latitude: Double((place.witnessLocation?.lat)!),
                                          longitude: Double((place.witnessLocation?.long)!))
            
            let distanceInMeters = self.locationManager.location?.distance(from: placeLocation)
            
            place.distance = distanceInMeters!
            
            return place
            
        })
        
        self.arrayWitnesses = array?.sorted(by: {$0.distance < $1.distance})
        
        if (self.arrayWitnesses?.count)! > 0 {
            
            let placeObj = self.arrayWitnesses?.first
            
            if (placeObj?.distance)! < Double(20.0) {
                
                if !CLConstant.delegatObj.appDelegate.questionAlreadyinWindow && !(placeObj?.introgatted)!  && !(placeObj?.coolDown)!{
                    
                    CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = true
                    
                    counter = 0
                    timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(CLMapView.vibratePhone), userInfo: nil, repeats: true)
                    
                    VC.showQuestionDailougeForWitness(from: VC,
                                                      witness: placeObj!,
                                                      action: { (correct) in
                                                        if correct{
                                                            
                                                            self.changeMarker(witness: placeObj!)
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2,
                                                                                          execute: {
                                                                                            placeObj?.introgatted = true
                                                                                            self.arrayWitnesses = self.arrayWitnesses?.filter { $0 != placeObj }
                                                                                            
                                                                                            CLConstant.delegatObj.appDelegate.saveMagicalContext()
                                                            })
                                                            
                                                            
                                                            
                                                            self.VC.showCaseNotePopUpHint(from: self.VC,
                                                                                      text: (placeObj?.statement)!,
                                                                                      testinomy: true,
                                                                                      imgID:"",
                                                                                      name:"",
                                                                                      showHint:(placeObj?.showHint)!,
                                                                                       hint:(placeObj?.hint!)!,
                                                                                       witnessData: placeObj!)
                                                            
                                                        }else{
                                                            
                                                            placeObj?.coolDown  = true
                                                            self.viewMap.selectedMarker = nil
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 60, execute: {
                                                                self.removeCoolDown(witness: placeObj!)
                                                            })
                                                            CLConstant.delegatObj.appDelegate.saveMagicalContext()
                                                            
                                                            self.VC.showSubmitPopUp(from: self.VC,wrongAns:true)
                                                            
                                                        }
                                                        
                    })
                }else{
                    
                    if (placeObj?.coolDown)! && !(CLConstant.delegatObj.appDelegate.questionAlreadyinWindow){
                        
                       // self.viewMap.selectedMarker = nil
                        
                       // CLConstant.delegatObj.appDelegate.questionAlreadyinWindow = true
                        
                       // VC.showCoolDownPopUp(from: VC, wrongAns: true)
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    
    
    
    /*vibrate phone*/
    
    func vibratePhone() {
        counter += 1
        switch counter {
        case 1, 2:
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        default:
            timer?.invalidate()
        }
    }
    
    
    func getTimeStoppperObj(location:CLLocation){
    
        
        if self.timeStopperObj != nil {
            
            for stoperLocation in self.timeStopperObj! {
                
               // if stoperLocation.lat != nil {
                    
                    let stopperLoc = CLLocationCoordinate2D(latitude: Double((stoperLocation.lat)),
                                                            longitude: Double((stoperLocation.long)))
                    
                    if stopperLoc.isEqualLocation(location.coordinate) && !CLConstant.delegatObj.appDelegate.timeStopperShow {
                        
                        CLConstant.delegatObj.appDelegate.timeStopperShow = true
                        
                        counter = 0
                        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(CLMapView.vibratePhone), userInfo: nil, repeats: true)
                        
                        VC.showTimeStopperPopup(from: VC,
                                                action: { (action) in
                                                    
                                                    if action{
                                                        
                                                        CLConstant.delegatObj.appDelegate.timeStopperShow = false
                                                        
                                                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: CLConstant.NotificationObserver.stoppper), object: nil, userInfo: nil)
                                                        
                                                    }
                        })
                    }
                //}
            }
 
        }
        
        
    }
    

    @IBAction func currentLocation(_ sender: Any) {
        
        let camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 12.0)
        
        self.viewMap.animate(to: camera)
        
    }
    
}

extension CLLocationCoordinate2D {
    func isEqualLocation(_ coord: CLLocationCoordinate2D) -> Bool {
        return (fabs(self.latitude - coord.latitude) < .ulpOfOne) && (fabs(self.longitude - coord.longitude) < .ulpOfOne)
    }
}
