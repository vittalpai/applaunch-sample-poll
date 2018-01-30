//
//  ViewController.swift
//  AppLaunch Poll
//
//  Created by Vittal Pai on 1/29/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit
import IBMAppLaunch

class ViewController: UIViewController {
    
    var popUpText:String = "Sample Text"
    var popUpYes:String = "Yes"
    var popUpNo:String = "No"
    @IBOutlet weak var pollButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Initialize AppLaunch SDK
        let config = AppLaunchConfig.Builder().fetchPolicy(.REFRESH_ON_EVERY_START).eventFlushInterval(50).build()
        let user = AppLaunchUser.Builder(userId: "vittal").custom(key: "PopUpSegment", stringValue: "AllPopupUsers").build()
        AppLaunch.sharedInstance.initialize(region: .US_SOUTH, appId: "48fdee1d-3261-469b-bddc-bc8d4e6aa7b7", clientSecret: "c4591d8f-ca5d-4158-9e36-5702eb40310a", config: config, user: user) { (success, failure) in
            if success != nil {
                print("AppLaunch Successfully initialized")
                self.checkIfFeatureEnabled()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func checkIfFeatureEnabled() {
        do {
            if try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_ez7lk2bb8") {
                popUpText = getPropertyValue("_ez7lk2bb8", "_p3fy1muq6")
                popUpYes = getPropertyValue("_ez7lk2bb8", "_i70rtpt2s")
                popUpNo = getPropertyValue("_ez7lk2bb8", "_l7f61iaye")
            } else {
                pollButton.isHidden = true
            }
        } catch {
            print("AppLaunch SDK is not Initialized")
        }
    }
    
    private func getPropertyValue(_ feature: String, _ property: String) -> String {
        do {
            return try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: feature, propertyCode: property)
        } catch {
            print("AppLaunch SDK is not Initialized")
            return ""
        }
    }
    
    private func sendMetrics(_ metricCode: String) {
        do {
            try AppLaunch.sharedInstance.sendMetrics(codes: [metricCode])
        } catch {
            print("AppLaunch SDK is not Initialized")
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        let alert = UIAlertController(title: popUpText, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: popUpYes, style: .default, handler: { (action: UIAlertAction!) in
            self.sendMetrics("_519jvgpj8")
        }))
        alert.addAction(UIAlertAction(title: popUpNo, style: .destructive, handler: { (action: UIAlertAction!) in
            self.sendMetrics("_dd9hujjpr")
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

