//
//  MenuVC.swift
//  MasterProject
//
//  Created by Sanjay Shah on 09/08/17.
//  Copyright © 2017 Sanjay Shah. All rights reserved.
//

import UIKit

// MARK: - Menu Enum
enum LeftMenu: Int {
    case Home
    case MyProfile
    case ChangePassword
    case Logout
}

// MARK: - Menu Protocol
protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class MenuVC: UIViewController, LeftMenuProtocol {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var menuTitle = ["HOME", "MY PROFILE", "CHANGE PASSWORD", "LOGOUT"]
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var loginVC: UIViewController!
    var homeVC: UIViewController!
    var myProfileVC: UIViewController!
    var changePasswordVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let user = Helper.getUserData(), user.userId != nil {
            // Here you get logged in user data
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Change View Controller
    func changeViewController(menu: LeftMenu) {
        
        switch menu {
            
            case .ChangePassword:
                let changePasswordVC = mainStoryboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                self.changePasswordVC = UINavigationController(rootViewController: changePasswordVC)
                self.slideMenuController()?.changeMainViewController(self.changePasswordVC, close: true)
            
            case .Logout:
            
                let alertVC = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
            
                alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                    self.webServiceLogout()
                }))
            
                alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
                self.present(alertVC, animated: true, completion: nil)
                self.slideMenuController()?.closeLeft()
            
            default:
                break
        }
    }
    
    //MARK:- Logout Method
    func webServiceLogout() {
        
        let param: [String: Any] = [
            "user_id": _theUser.userId
        ]
        
        webServiceCall(Path.Login, parameter: param) { (json, error) in
            if json["status"].boolValue {
                if let bundle = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: bundle)
                    UserDefaults.standard.synchronize()
                }
                
                appDelegate.menuSelectedIndex = 0
                let loginVC = self.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.loginVC = UINavigationController(rootViewController: loginVC)
                self.slideMenuController()?.changeMainViewController(self.loginVC, close: true)
            }
        }
    }
}

// MARK: - UITableView Delegate/DataSource Extension
extension MenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            if menu != .Logout {
                appDelegate.menuSelectedIndex = indexPath.row
            }
            changeViewController(menu: menu)
            tableView.reloadData()
        }
    }
}

extension MenuVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        
        cell.lblTitle.text = menuTitle[indexPath.row]
        
        if appDelegate.menuSelectedIndex == indexPath.row {
            // set design for selected menu
        }else{
            // set design for unselected menu
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Menu Cell Class
class MenuCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
}
