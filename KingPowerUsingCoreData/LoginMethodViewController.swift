//
//  LoginMethodViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/18/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class LoginMethodViewController: UIViewController {

    var gv = GlobalVariable()
    
    @IBAction func TappedCardReader(sender: AnyObject) {
        let alertController = UIAlertController(title: "Card Reader Method", message:
            "Under Implemenation", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }
    @IBAction func TappedCamera(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Camera Method", message:
            "Under Implemenation", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginMethodViewController")
        
        let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
        let imageTitleView = UIImageView(frame: CGRect(
            x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
            y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
            width: gv.getConfigValue("navigationBarImgWidth") as! Int,
            height: gv.getConfigValue("navigationBarImgHeight") as! Int))
        
        imageTitleView.contentMode = .ScaleAspectFit
        imageTitleView.image = imageTitleItem
        
        self.navigationItem.titleView = imageTitleView
        
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(hexString: gv.getConfigValue("navigationBarColor") as! String)
        
        let buttonSignout: UIButton = UIButton(type: UIButtonType.Custom)
        buttonSignout.frame = CGRect(
            x: gv.getConfigValue("navigationItemSignoutImgPositionX") as! CGFloat,
            y: gv.getConfigValue("navigationItemSignoutImgPositionY") as! CGFloat,
            width:  gv.getConfigValue("navigationItemSignoutImgWidth") as! CGFloat,
            height: gv.getConfigValue("navigationItemSignoutImgHeight") as! CGFloat)
        
        buttonSignout.setImage(UIImage(named: gv.getConfigValue("navigationItemSignoutImgName") as! String), forState: UIControlState.Normal)
        buttonSignout.addTarget(self, action: "SignoutMethod", forControlEvents: UIControlEvents.TouchUpInside)
        var rightBarButtonItemSignout: UIBarButtonItem = UIBarButtonItem(customView: buttonSignout)
        self.navigationItem.setRightBarButtonItems([rightBarButtonItemSignout], animated: true)
        
        self.navigationItem.hidesBackButton = true
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func SignoutMethod(){
        print("Sing Out Method")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
