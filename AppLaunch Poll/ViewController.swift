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
        do {
            try  AppLaunch.sharedInstance.displayInAppMessages()
        } catch {
            print("AppLaunch SDK is not Initialized")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.checkIfFeatureEnabled()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logout(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
        self.navigationController?.popViewController(animated: true)
    }
    
    private func checkIfFeatureEnabled() {
        do {
            if try AppLaunch.sharedInstance.isFeatureEnabled(featureCode: "_9uqcfzt0m") {
                pollButton.isHidden = false
                popUpText = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_9uqcfzt0m", propertyCode: "_kpdm8tv1a")
                popUpYes = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_9uqcfzt0m", propertyCode: "_1p7xwyg1p")
                popUpNo = try AppLaunch.sharedInstance.getPropertyofFeature(featureCode: "_9uqcfzt0m", propertyCode: "_2dcs3dfl9")
            } else {
                pollButton.isHidden = true
            }
            
        } catch {
            print("AppLaunch SDK is not Initialized")
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        let alert = UIAlertController(title: popUpText, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: popUpYes, style: .default, handler: { (action: UIAlertAction!) in
            do{
                try AppLaunch.sharedInstance.sendMetrics(codes: ["_fngswyvoo"])
            }catch{
                print("AppLaunch SDK is not Initialized")
            }
        }))
        alert.addAction(UIAlertAction(title: popUpNo, style: .destructive, handler: { (action: UIAlertAction!) in
            do{
                try AppLaunch.sharedInstance.sendMetrics(codes: ["_cjj3wmc0r"])
            }catch{
                print("AppLaunch SDK is not Initialized")
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

