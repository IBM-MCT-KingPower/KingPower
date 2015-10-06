//
//  SelectLanguageViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 9/27/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class SelectLanguageViewController: UIViewController {
    
    var gv = GlobalVariable()
    var setupNav = KPNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        print("Sing Out Method")
    }
    
    func BackMethod(){
        print("Back Method")
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
