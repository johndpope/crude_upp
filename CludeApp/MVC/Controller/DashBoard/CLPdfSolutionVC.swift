//
//  CLPdfSolutionVC.swift
//  CludeApp
//
//  Created by Reus on 24/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit
import SVProgressHUD

class CLPdfSolutionVC: UIViewController {

    @IBOutlet weak var webViewSolutions: UIWebView!
    
    var pdfUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webViewSolutions.loadRequest(NSURLRequest(url: NSURL(string: pdfUrl!) as! URL) as URLRequest)
        webViewSolutions.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func btnBack(_ sender: Any) {
        
        self.dismiss(animated: true,
                     completion: nil)
    }
    

}


extension CLPdfSolutionVC:UIWebViewDelegate{

    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
}
