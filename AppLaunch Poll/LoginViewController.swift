//
//  LoginViewController.swift
//  AppLaunch Poll
//
//  Created by Vittal Pai on 1/30/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit
import IBMAppLaunch

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton) {
        applaunchInitialize(userType: "Registered")
    }
    
    @IBAction func login_guest(_ sender: Any) {
        applaunchInitialize(userType: "Guest")
    }
    
    private func applaunchInitialize(userType: String) {
        showOverlay()
        // Initialize AppLaunch SDK
        let config = AppLaunchConfig.Builder().fetchPolicy(.REFRESH_ON_EVERY_START).eventFlushInterval(50).build()
        let user = AppLaunchUser.Builder(userId: "demouser").custom(key: "UserType", stringValue: userType).build()
        AppLaunch.sharedInstance.initialize(region: .US_SOUTH, appId: "c918ba64-7b97-454f-a99d-4064ce3e3866", clientSecret: "825ec630-2a7d-4ddb-8388-50a28258a6e8", config: config, user: user) { (success, failure) in
            self.dismissOverlay()
            if success != nil {
                print("AppLaunch Successfully initialized")
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationView") as! UINavigationController
                self.present(vc, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Alert", message: "AppLaunch Service Intialization Failed, Try again some", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func showOverlay() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    private func dismissOverlay() {
        dismiss(animated: false, completion: nil)
    }
    
}
