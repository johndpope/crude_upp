//
//  CLApiManager.swift
//  CludeApp
//
//  Created by Reus on 04/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class CLApiManager: NSObject {

    typealias SOAPICompletionHandler = (_ code:Int, _ error:NSError?, _ response:JSON? , _ statusCode : Int?) -> Void

    struct API {
        
        static let baseURL            = "http://ec2-52-39-6-40.us-west-2.compute.amazonaws.com:3000/api/"
        static let eventList          = "game/published"
        static let vocuher            = "redeem/checkVoucher"
        static let addTeam            = "redeem"
        static let submitSolutions    = "game/leaderboard/"
    }
    
    
    
    /*!
     * @abstract Event List
     */
    
    func getEventList(completionHandler:@escaping SOAPICompletionHandler){
    
        SVProgressHUD.show()
        
        Alamofire.request(API.baseURL+API.eventList).responseJSON{ response in
            debugPrint(response)
            let statuscode = response.response?.statusCode
            if response.result.isSuccess {
                let jsonObject = JSON(response.result.value!)
                SVProgressHUD.dismiss()
                completionHandler(1, nil, jsonObject , statuscode)
            } else {
                SVProgressHUD.dismiss()
                let error = response.result.error! as NSError
                completionHandler(0, error, nil , statuscode)
            }
        }
        
    }
    
    
    /*!
     * @abstract Validate Voucher Code
     */
    //
    func validateVoucherCode(param:[String:Any],completionHandler:@escaping SOAPICompletionHandler){
    
        
        SVProgressHUD.show()
        
        Alamofire.request(API.baseURL+API.vocuher, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            let statuscode = response.response?.statusCode
            SVProgressHUD.dismiss()

            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let jsonObject = JSON(response.result.value!)
                    completionHandler(1, nil, jsonObject , statuscode)
                }
                break
                
            case .failure(_):
                let error = response.result.error! as NSError
                completionHandler(0, error, nil , statuscode)
                break
                
            }
        }
        
    }
    
    /*!
     * @abstract Validate Voucher Code
     */
    
    func addTeam(param:[String:Any],completionHandler:@escaping SOAPICompletionHandler){
        
        
        SVProgressHUD.show()
        
        Alamofire.request(API.baseURL+API.addTeam, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            let statuscode = response.response?.statusCode
            SVProgressHUD.dismiss()
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let jsonObject = JSON(response.result.value!)
                    completionHandler(1, nil, jsonObject , statuscode)
                }
                break
                
            case .failure(_):
                let error = response.result.error! as NSError
                completionHandler(0, error, nil , statuscode)
                break
                
            }
        }
        
    }
    
    
    /*!
     * @anstract submit solutions
     */
    
    func submitSolutions(gameID:String,param:[String:Any],completionHandler: @escaping SOAPICompletionHandler){
        
        SVProgressHUD.show()
        let submitSolutionAPI = API.baseURL+API.submitSolutions + gameID
        
        Alamofire.request(submitSolutionAPI, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            let statuscode = response.response?.statusCode
            SVProgressHUD.dismiss()
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    let jsonObject = JSON(response.result.value!)
                    completionHandler(1, nil, jsonObject , statuscode)
                }
                break
                
            case .failure(_):
                let error = response.result.error! as NSError
                completionHandler(0, error, nil , statuscode)
                break
                
            }
        }
        
    }
    
    
    
}
