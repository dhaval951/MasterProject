//
//  RegistrationVC.swift
//  MasterProject
//
//  Created by Sanjay Shah on 04/08/17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldGender: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var buttonProfileImage: UIButton!
    
    // MARK: - Variable Declaration
    var mediaHelper: MediaPickerHelper?
    var isProfileSelected = false
    
    // MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        textFieldFirstName.text = ""
        textFieldLastName.text = ""
        textFieldGender.text = ""
        textFieldEmail.text = ""
        textFieldPassword.text = ""
        textFieldConfirmPassword.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
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
extension RegistrationVC {
    @IBAction func buttonChooseProfileAction(_ sender: UIButton) {
        
        //Simply return the image you don't need to write delegate method of UIImagePickerController here
        mediaHelper = MediaPickerHelper(viewController: self, isAllowEditing: true, imageCallback: { (image) in
            sender.setBackgroundImage(image!, for: .normal)
            self.isProfileSelected = true
        })
    }
    
    @IBAction func buttonRegisterAction(_ sender: UIButton) {
        if validation() {
            self.view.endEditing(true)
            webServiceRegistration()
        }
    }
}

// MARK: - Validate Registration Fields
extension RegistrationVC {
    func validation() -> Bool {
        if textFieldFirstName.text!.isEmpty() {
            self.showTostMessage(message: ValidationMessage.enterFirstName)
            return false
        }else if textFieldLastName.text!.isEmpty() {
            self.showTostMessage(message: ValidationMessage.enterLastName)
            return false
        }else if textFieldGender.text!.isEmpty() {
            self.showTostMessage(message: ValidationMessage.selectGender)
            return false
        }else  if textFieldEmail.text!.isEmpty() {
            self.showTostMessage(message: ValidationMessage.enterEmail)
            return false
        }else if !textFieldEmail.text!.isValidEmail() {
            self.showTostMessage(message: ValidationMessage.enterValidEmail)
            return false
        }else if textFieldPassword.text!.isEmpty() {
            self.showTostMessage(message: ValidationMessage.enterPassword)
            return false
        }else if !textFieldPassword.text!.trimming().isValidPassword() {
            self.showTostMessage(message: ValidationMessage.enterValidPassword)
            return false
        }else if textFieldPassword.text! != textFieldConfirmPassword.text! {
            self.showTostMessage(message: ValidationMessage.passwordDoNotMatch)
            return false
        }else if !isProfileSelected {
            self.showTostMessage(message: ValidationMessage.selectProfile)
            return false
        }
        
        return true
    }
}

// MARK: - Registration API Call
extension RegistrationVC {
    func webServiceRegistration() {
        
        let param = [
            "first_name": textFieldFirstName.text!.trimming(),
            "last_name": textFieldLastName.text!.trimming(),
            "gender": textFieldGender.text!.trimming(),
            "email": textFieldEmail.text!.trimming(),
            "password": textFieldPassword.text!.trimming(),
            "device_type": "ios",
            "device_token": appDelegate.deviceToken
        ]
        
        var imageData = [Data]()
        var imageKey = [String]()
        
        if isProfileSelected {
            imageData.append(UIImagePNGRepresentation(buttonProfileImage.backgroundImage(for: .normal)!)!)
            imageKey = ["user_image"]
        }
        
        webServiceCall(Path.Register, parameter: param, imageKey: imageKey, imageData: imageData) { (json, error) in
            
            self.showTostMessage(message: json["message"].stringValue)
            
            if json["status"].boolValue {
                
                let userDetail = json["user_details"]
                
                let user = UserInfo(userDetail)
                Helper.saveUserData(object: user)
                
                //Do whatever you want do after successfull response
            }else{
                
                self.textFieldEmail.text = ""
                self.textFieldPassword.text = ""
                
                //Do whatever you want do after failure response
            }
        }
    }
}

