//
//  LoginViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/2/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imgPromo: UIImageView!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var txtStaffId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var gv = GlobalVariable()
    var constat = Constants()
    var commonViewController = CommonViewController()
    var lol = Locale()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.decorate()
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= gv.getConfigValue("keyboardHeight") as! CGFloat
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += gv.getConfigValue("keyboardHeight") as! CGFloat
    }
    
    //DIP:: Do view recorating form here
    func decorate() {
        
        imgPromo.image = UIImage(named: "Promo 2.jpg")
        
        self.navigationController?.navigationBarHidden = true
        
        self.lblCompanyName.text = self.constat.customLocalizedString("loginCompanyName", comment: "this is comment")as String
        self.lblCompanyName.text = ""
        self.txtStaffId.placeholder = self.constat.customLocalizedString("loginStaffId", comment: "this is comment")as String
        self.txtPassword.placeholder = self.constat.customLocalizedString("loginStaffPassword", comment: "this is comment") as String
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnLogintapped(sender: AnyObject) {
        let staffId = self.txtStaffId!.text
        let password = self.txtPassword!.text
        
        //Validate Required
        if(staffId=="" || password==""){
            commonViewController.alertView(self, title: gv.getConfigValue("messageAuthenFailTitle") as! String, message: gv.getConfigValue("messageAuthenRequiredField") as! String)
            
        }else{
            
            var userController = UserController()
            
            var userModel : UserModel?
            userModel = userController.authentication(staffId!, password: password!)
            
            if (userModel ==  nil) {
                commonViewController.alertView(self, title: gv.getConfigValue("messageAuthenFailTitle") as! String, message: gv.getConfigValue("messageAuthenFail") as! String)
            }else{
                print("\nAuthentication Passed : [ID: \(userModel!.user_id)] : [USERNAME: \(userModel!.user_username)]")
                
                let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                prefs.setInteger(userModel!.user_id.hashValue, forKey: gv.getConfigValue("currentUserId") as! String)
                prefs.synchronize()
                
                self.performSegueWithIdentifier("loginSegue", sender: sender)
                
            }
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "loginSegue"{
            /*
            let item = sender as! NSDictionary
            let id: Int = item["PRO_ID"] as! Int
            let fname: String = item["PRO_FNAME"] as! String
            let lname: String = item["PRO_LNAME"] as! String
            let workunit: String = item["PRO_WORKUNIT"] as! String
            
            print("ID:         \(id)")
            print("FIRST NAME: \(fname)")
            print("LAST NAME:  \(lname)")
            print("WORK UNIT:  \(workunit)")
            
            let navMainPageVC = segue.destinationViewController as! UINavigationController
            let mainPageVC = navMainPageVC.topViewController as! MainPageViewController
            mainPageVC.vTechnicianName = "\(fname) \(lname)/\(workunit)"
            mainPageVC.vWorkUnit = workunit
            */
        }
    }
    
}
