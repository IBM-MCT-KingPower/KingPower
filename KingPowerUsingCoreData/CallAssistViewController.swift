//
//  CallAssistViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/28/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class CallAssistViewController: UIViewController {

    @IBOutlet var vMain: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.frame.size.width = 1024

        self.view.frame.size.height = 200
        
        //vMain.frame = CGRectMake(0, 0, 1024, 200)
        self.view.alpha = 0.5
    }
    @IBAction func exitViewTapped(sender: AnyObject) {
        var test = CGRectMake( 100, 200, 1024, 500 ); // set new position exactly
        vMain.frame = test
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showInView(aView: UIView!, animated: Bool)
    {
        aView.addSubview(self.view)
        if animated
        {
            //self.showAnimate()
        }
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
