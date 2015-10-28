//
//  ThankyouViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/25/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class ThankyouViewController: UIViewController {
    
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    
    var setupNav = KPNavigationBar()
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    var orderNo = ""
    
    override func viewDidLoad() {
        print("ThankyouViewController")
        super.viewDidLoad()
        self.btnOk.layer.cornerRadius = 5
        self.btnOk.layer.borderColor = UIColor.whiteColor().CGColor
        self.btnOk.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
        self.lblOrderNo.text = orderNo
        self.setupNav.setupNavigationBar(self)

    }
    
    override func viewWillDisappear(animated: Bool) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(0, forKey: gv.getConfigValue("currentAmountInCart") as! String)
        prefs.synchronize()
        
      //  let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        let userId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentUserId") as! String))
        CartController().deleteByCustomerId(custId,user_id: userId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okMethod(sender: AnyObject) {
        
    }
    

    // MARK: - Navigation bar
    func callAssistMethod(){
        self.removeNavigateView()
        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
        CommonViewController().callAssistMethod(self, call: callAssistanceViewController)
    }
    
    func removeNavigateView(){
        if(flightViewController != nil && !flightViewController.view.hidden)
        {
            flightViewController.view.removeFromSuperview()
        }
        if(callAssistanceViewController != nil && !callAssistanceViewController.view.hidden)
        {
            callAssistanceViewController.view.removeFromSuperview()
        }
    }
    
}
