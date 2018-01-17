//
//  LoginVC.swift
//  MasterProject
//
//  Created by Sanjay Shah on 04/08/17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var arrayImage = [Image]()
    
    // MARK: - Class Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        Manually make the arrayImage
        let imageURL1 = Image(imageId: "1", imageURL: "http://spotmeout.zealousys.com/media/post/compressedimage/compresse_post_Cv37TVy.jpg")
        let imageURL2 = Image(imageId: "1", imageURL: "http://spotmeout.zealousys.com/media/post/compressedimage/compresse_post_GGLPwEG.jpg")
        let imageURL3 = Image(imageId: "1", imageURL: "http://www.gstatic.com/webp/gallery/4.jpg")
        let imageURL4 = Image(imageId: "1", imageURL: "http://www.gstatic.com/webp/gallery/5.jpg")
        
        arrayImage.append(imageURL1)
        arrayImage.append(imageURL2)
        arrayImage.append(imageURL3)
        arrayImage.append(imageURL4) 
        */
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //Presenting Image Preview
        //ImagePreviewVC.show(in: self, arrayImage: arrayImage)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        textFieldEmail.text = ""
        textFieldPassword.text = ""
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
extension LoginVC {
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        if validation() {
            self.view.endEditing(true)
            webServiceLogin()
        }
    }
}

// MARK: - Validate Email/Password Field
extension LoginVC {
    func validation() -> Bool {
        
        if textFieldEmail.text!.isEmpty() {
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
        }
        
        return true
    }
}

// MARK: - Login API Call
extension LoginVC {
    func webServiceLogin() {
        
        let param = [
            "email": textFieldEmail.text!.trimming(),
            "password": textFieldPassword.text!.trimming(),
            "device_type": "ios",
            "device_token": appDelegate.deviceToken
        ]
        
        webServiceCall(Path.Login, parameter: param) { (json, error) in
            
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
