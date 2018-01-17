//
//  Constant.swift
//  MasterProject
//
//  Created by Sanjay Shah on 03/08/17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

import Foundation

var _theUser: UserInfo! //LoggedIn User Detail

struct BasePath {
    static var Path                         = ""
}

struct Path {
    static let Login                        = "\(BasePath.Path)login"
    static let Register                     = "\(BasePath.Path)registration"
    static let ForgotPassword               = "\(BasePath.Path)forgot_password"
    static let ChangePassword               = "\(BasePath.Path)change_password"
    static let Logout                       = "\(BasePath.Path)logout"
}

struct ValidationMessage {
    
    static let somthingWrong                = "Something went wrong. Please try again later."
    static let internetNotAvailable         = "Internet connection not found. Please try again later."
    static let enterEmail                   = "Please enter email."
    static let enterPassword                = "Please enter password."
    static let enterConfirmPassword         = "Please enter confirm password."
    static let enterValidPassword           = "Password should be at least 6 characters long."
    static let enterValidOldPassword        = "Old password should be at least 6 characters long."
    static let enterValidNewPassword        = "New password should be at least 6 characters long."
    static let enterValidConfirmPassword    = "Confirm password should contain minimum 6 characters."
    static let enterValidEmail              = "Please enter valid email."
    static let enterFirstName               = "Please enter first name."
    static let enterLastName                = "Please enter last name."
    static let selectGender                 = "Please select gender."
    static let selectProfile                = "Please select profile image."
    static let passwordDoNotMatch           = "Password and confirm password must be same."
    static let newPasswordDoNotMatch        = "New password and confirm password must be same."
    static let oldNewPasswordDoNotSame      = "Old password and new password can't be same."
    static let enterOldPassword             = "Please enter old password."
    static let enterNewPassword             = "Please enter new password."
    static let acceptTermsAndCondition      = "Please accept terms and conditions."
}
