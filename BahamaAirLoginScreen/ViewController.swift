//
//  ViewController.swift
//  BahamaAirLoginScreen
//
//  Created by Travis Gillespie on 12/14/15.
//  Copyright © 2015 Travis Gillespie. All rights reserved.
//

import UIKit

// A delay function
func delay(seconds seconds: Double, completion:()->()){
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    // MARK view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(status)
        
        status.hidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .Center
        status.addSubview(label)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, animations: {
            self.heading.center.x += self.view.bounds.width
        })
        
        UIView.animateWithDuration(0.5, delay: 0.3, options: [], animations: {
            self.username.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, options: [], animations: {
                self.password.center.x += self.view.bounds.width
            }, completion: nil)
    }
    
    
      // MARK: further methods
    @IBAction func login(sender: UIButton) {
        view.endEditing(true)
    }
    
      // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField.becomeFirstResponder()
        return true
    }

}

