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
        let user = AppLaunchUser.Builder(userId: "demouser").custom(key: "userType", stringValue: userType).build()
        AppLaunch.sharedInstance.initialize(region: .US_SOUTH, appId: "48fdee1d-3261-469b-bddc-bc8d4e6aa7b7", clientSecret: "c4591d8f-ca5d-4158-9e36-5702eb40310a", config: config, user: user) { (success, failure) in
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
