//
//  LoginByCameraViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/18/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class LoginByCameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageTitleItem : UIImage = UIImage(named: "KP_Logo_Title_Bar.png")!
        let imageTitleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageTitleView.contentMode = .ScaleAspectFit
        imageTitleView.image = imageTitleItem
        self.navigationItem.titleView = imageTitleView
        self.navigationController?.navigationBar.backgroundColor = UIColor.redColor()
        
        
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (0/255.0), green: (110/255.0), blue: (204/255.0), alpha: 1.0)
        
        let buttonSignout: UIButton = UIButton(type: UIButtonType.Custom)
        buttonSignout.frame = CGRectMake(0, 0, 30, 30)
        buttonSignout.setImage(UIImage(named:"btnLogOut.png"), forState: UIControlState.Normal)
        buttonSignout.addTarget(self, action: "SignoutMethod", forControlEvents: UIControlEvents.TouchUpInside)
        var rightBarButtonItemSignout: UIBarButtonItem = UIBarButtonItem(customView: buttonSignout)
        self.navigationItem.setRightBarButtonItems([rightBarButtonItemSignout], animated: true)
        

        
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
