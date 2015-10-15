//
//  LoginByTypeViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/18/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class LoginByTypeViewController: UIViewController {
    
    var gv = GlobalVariable()
    var setupNav = KPNavigationBar()
    var commonViewController = CommonViewController()
    var customer : CustomerModel?
    
    @IBOutlet weak var cardIdTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginByTypeViewController")
        
        setupNav.setupNavigationBar(self)
        
        //        let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
        //        let imageTitleView = UIImageView(frame: CGRect(
        //            x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
        //            y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
        //            width: gv.getConfigValue("navigationBarImgWidth") as! Int,
        //            height: gv.getConfigValue("navigationBarImgHeight") as! Int))
        //
        //        imageTitleView.contentMode = .ScaleAspectFit
        //        imageTitleView.image = imageTitleItem
        //
        //        self.navigationItem.titleView = imageTitleView
        //
        //        var nav = self.navigationController?.navigationBar
        //        nav?.barTintColor = UIColor(hexString: gv.getConfigValue("navigationBarColor") as! String)
        //
        //        let buttonSignout: UIButton = UIButton(type: UIButtonType.Custom)
        //        buttonSignout.frame = CGRect(
        //            x: gv.getConfigValue("navigationItemSignoutImgPositionX") as! CGFloat,
        //            y: gv.getConfigValue("navigationItemSignoutImgPositionY") as! CGFloat,
        //            width:  gv.getConfigValue("navigationItemSignoutImgWidth") as! CGFloat,
        //            height: gv.getConfigValue("navigationItemSignoutImgHeight") as! CGFloat)
        //
        //        buttonSignout.setImage(UIImage(named: gv.getConfigValue("navigationItemSignoutImgName") as! String), forState: UIControlState.Normal)
        //        buttonSignout.addTarget(self, action: "SignoutMethod", forControlEvents: UIControlEvents.TouchUpInside)
        //        var rightBarButtonItemSignout: UIBarButtonItem = UIBarButtonItem(customView: buttonSignout)
        //        self.navigationItem.setRightBarButtonItems([rightBarButtonItemSignout], animated: true)
        //
        //        let buttonBack : UIButton = UIButton(type: UIButtonType.Custom)
        //        buttonBack.frame = CGRect(
        //            x: gv.getConfigValue("navigationItemBackImgPositionX") as! CGFloat,
        //            y: gv.getConfigValue("navigationItemBackImgPositionY") as! CGFloat,
        //            width:  gv.getConfigValue("navigationItemBackImgWidth") as! CGFloat,
        //            height: gv.getConfigValue("navigationItemBackImgHeight") as! CGFloat)
        //
        //        buttonBack.setImage(UIImage(named: gv.getConfigValue("navigationItemBackImgName") as! String), forState: UIControlState.Normal)
        //        buttonBack.addTarget(self, action: "BackMethod", forControlEvents: UIControlEvents.TouchUpInside)
        //        var leftBarButtonItemBack : UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
        //        self.navigationItem.setLeftBarButtonItems([leftBarButtonItemBack], animated: true)
        //
        //        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func SignoutMethod(){
        commonViewController.signoutMethod(self)
        
    }
    
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSubmitTapped(sender: AnyObject) {
        
        //Check required
        if(self.cardIdTextField!.text == ""){
            commonViewController.alertView(self, title: gv.getConfigValue("messageMemberValidationFailTitle") as! String, message: gv.getConfigValue("messageMemberRequiredField") as! String)
        }else{
            
            print("Tapped Submit Button with info : \(self.cardIdTextField!.text!)")
            var customerController = CustomerController()
            
            self.customer = customerController.getCustomerByMemberId(self.cardIdTextField!.text!)
            print(".. \(self.customer?.cust_first_name)")
            print(self.customer?.cust_birthdate)
            if(customer == nil){
                commonViewController.alertView(self, title: gv.getConfigValue("messageMemberValidationFailTitle") as! String, message: gv.getConfigValue("messageMemberNotFound") as! String)
            }else{
                let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                
                prefs.setInteger(self.customer!.cust_id.hashValue, forKey: gv.getConfigValue("currentCustomerId") as! String)
                prefs.synchronize()
                
                //                The way to get currentCustomer
                //                var test: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
                
                performSegueWithIdentifier("loginDetailSegue", sender: sender)
                
            }
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "loginDetailSegue" {
            print("Prepare for Segue: Navigate to LoginDetailViewController")
            print("Customer : \(self.customer!.cust_first_name)")
            (segue.destinationViewController as! LoginDetailViewController).customer = self.customer!
        }
        
    }
    
    
}
