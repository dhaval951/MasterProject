//
//  ForgotPasswordVC.swift
//  MasterProject
//
//  Created by Sanjay Shah on 04/08/17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var textFieldEmail: UITextField!
    
    // MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.textFieldEmail.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Button Action
extension ForgotPasswordVC {
    @IBAction func buttonForgotPasswordAction(_ sender: UIButton) {
        if validation() {
            self.view.endEditing(true)
            webServiceForgotPassword()
        }
    }
}

// MARK: - Validate Email Field
extension ForgotPasswordVC {
    func validation() -> Bool {
        
        if textFieldEmail.text!.isEmpty() {
            self.showTostMessage(message: ValidationMessage.enterEmail)
            return false
        }else if !textFieldEmail.text!.isValidEmail() {
            self.showTostMessage(message: ValidationMessage.enterValidEmail)
            return false
        }
        
        return true
    }
}

// MARK: - Forgot Password API Call
extension ForgotPasswordVC {
    func webServiceForgotPassword() {
        
        let param = [
            "email": textFieldEmail.text!.trimming()
        ]
        
        webServiceCall(Path.ForgotPassword, parameter: param) { (json, error) in
            
            self.showTostMessage(message: json["message"].stringValue)
            
            self.textFieldEmail.text = ""
            
            if json["status"].boolValue {
                //Do whatever you want do after successfull response
            }else{
                //Do whatever you want do after failure response
            }
        }
    }
}
