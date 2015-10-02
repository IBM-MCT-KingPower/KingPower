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
    
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnOk.layer.cornerRadius = 5
        self.btnOk.layer.borderColor = UIColor.whiteColor().CGColor
        self.btnOk.layer.borderWidth = 1.0
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okMethod(sender: AnyObject) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func setupNavigationBar(){
        print("navigation frame: \(navigationController!.navigationBar.frame.width) x \(navigationController!.navigationBar.frame.height)")
        //Remove the shadow image altogether
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        //Container Layout
        navBar.frame=CGRectMake(0, 0, navigationController!.navigationBar.frame.width, navigationController!.navigationBar.frame.height)
        navBar.barTintColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))//UIColor(hexString: "000000")
        self.view.addSubview(navBar)
        self.view.sendSubviewToBack(navBar)
        
        //Navigation Bar
        self.navigationController!.navigationBar.barTintColor =  UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))
        
        let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
        let imageTitleView = UIImageView(frame: CGRect(
            x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
            y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
            width: gv.getConfigValue("navigationBarImgWidth") as! Int,
            height: gv.getConfigValue("navigationBarImgHeight") as! Int))
        
        imageTitleView.contentMode = .ScaleAspectFit
        imageTitleView.image = imageTitleItem
        self.navigationItem.titleView = imageTitleView
        
        self.addRightNavItemOnView()
        self.addLeftNavItemOnView()
        
    }
    func addLeftNavItemOnView()
    {
        //Menu
        let buttonMenu = UIButton(type: UIButtonType.Custom) as UIButton
        buttonMenu.frame = CGRectMake(
            gv.getConfigValue("navigationItemHamburgerImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemHamburgerImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemHamburgerImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemHamburgerImgHeight") as! CGFloat)
        
        
        
        buttonMenu.setImage(UIImage(named: gv.getConfigValue("navigationItemHamburgerImgName") as! String), forState: UIControlState.Normal)
        buttonMenu.addTarget(self.revealViewController(), action: "revealToggle:", forControlEvents: UIControlEvents.TouchUpInside) //use thiss
        let leftBarButtonItemMenu = UIBarButtonItem(customView: buttonMenu)
        
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            //btnMenu2.target = self.langRevealViewController()
            //btnMenu2.action = "langRevealToggle:"
            // Uncomment to change the width of menu
            //self.revealViewController().rearViewRevealWidth = 62
        }

        
        //Flight
        let buttonFlight = UIButton(type: UIButtonType.Custom) as UIButton
        buttonFlight.frame = CGRectMake(
            gv.getConfigValue("navigationItemAirplainImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgHeight") as! CGFloat)
        buttonFlight.setImage(UIImage(named: gv.getConfigValue("navigationItemAirplainImgName") as! String), forState: UIControlState.Normal)
        buttonFlight.addTarget(self, action: "navItemFlightClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButtonItemFilght = UIBarButtonItem(customView: buttonFlight)
        
        
        // add multiple right bar button items
        self.navigationItem.setLeftBarButtonItems([leftBarButtonItemMenu,leftBarButtonItemFilght], animated: true)
        // uncomment to add single right bar button item
        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
        
    }
    func addRightNavItemOnView()
    {
        //Call
        let buttonCall = UIButton(type: UIButtonType.Custom) as UIButton
        buttonCall.frame = CGRectMake(
            gv.getConfigValue("navigationItemCallImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgHeight") as! CGFloat)
        
        buttonCall.setImage(UIImage(named: gv.getConfigValue("navigationItemCallImgName") as! String), forState: UIControlState.Normal)
        buttonCall.addTarget(self, action: "navItemCallClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemCall = UIBarButtonItem(customView: buttonCall)
        
        
        
        
        // add multiple right bar button items
        self.navigationItem.setRightBarButtonItems([rightBarButtonItemCall], animated: true)
        
        // uncomment to add single right bar button item
        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
    }
    
    //Navigation Bar
    func backToPreviousPage(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func navItemFlightClick(sender:UIButton!)
    {
        print("navItemFlightClick")
    }
    
    func navItemCallClick(sender:UIButton!)
    {
        print("navItemCallClick")
        var callAssistViewController: CallAssistViewController!
        callAssistViewController = CallAssistViewController(nibName: "CallAssistViewController", bundle: nil)
        callAssistViewController.title = "This is a popup view"
        callAssistViewController.showInView(self.view, animated: true)
        
    }
    
    func navItemCartClick(sender:UIButton!)
    {
        print("navItemCartClick")
        let cartViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CartViewController") as? CartViewController
        self.navigationController?.pushViewController(cartViewController!, animated: true)
    }
    
    func navItemSearchClick(sender:UIButton!)
    {
        print("navItemSearchClick")
    }
    

}
