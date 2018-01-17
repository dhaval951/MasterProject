//
//  ChangePasswordVC.swift
//  MasterProject
//
//  Created by Sanjay Shah on 04/08/17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var textFieldOldPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    
    // MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.textFieldOldPassword.text = ""
        self.textFieldNewPassword.text = ""
        self.textFieldConfirmPassword.text = ""
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
extension ChangePasswordVC {
    @IBAction func buttonChangePasswordAction(_ sender: UIButton) {
        if validation() {
            self.view.endEditing(true)
            webServiceChangePassword()
        }
    }
}

// MARK: - Validate Password Fields
extension ChangePasswordVC {
    func validation() -> Bool {
        
        if textFieldOldPassword.text!.trimming().isEmpty() {
            self.showTostMessage(message: ValidationMessage.enterOldPassword)
            return false
        }else if !textFieldOldPassword.text!.trimming().isValidPassword() {
            self.showTostMessage(message: ValidationMessage.enterValidOldPassword)
            return false
        }else if textFieldNewPassword.text!.trimming().isEmpty() {
            self.showTostMessage(message: ValidationMessage.enterNewPassword)
            return false
        }else if !textFieldNewPassword.text!.trimming().isValidPassword() {
            self.showTostMessage(message: ValidationMessage.enterValidNewPassword)
            return false
        }else if textFieldOldPassword.text == textFieldNewPassword.text {
            self.showTostMessage(message: ValidationMessage.oldNewPasswordDoNotSame)
            return false
        }else if textFieldNewPassword.text! != textFieldConfirmPassword.text! {
            self.showTostMessage(message: ValidationMessage.newPasswordDoNotMatch)
            return false
        }
        
        return true
    }
}

// MARK: - Change Password API Call
extension ChangePasswordVC {
    func webServiceChangePassword() {
        
        let param = [
            "user_id": _theUser.userId!,
            "old_password": textFieldOldPassword.text!.trimming(),
            "new_password": textFieldOldPassword.text!.trimming(),
        ]
        
        webServiceCall(Path.ChangePassword, parameter: param) { (json, error) in
            
            self.showTostMessage(message: json["message"].stringValue)
            
            self.textFieldOldPassword.text = ""
            self.textFieldNewPassword.text = ""
            self.textFieldConfirmPassword.text = ""
            
            if json["status"].boolValue {
                
                //Do whatever you want do after successfull response
            }else{
                
                //Do whatever you want do after failure response
            }
        }
    }
}
