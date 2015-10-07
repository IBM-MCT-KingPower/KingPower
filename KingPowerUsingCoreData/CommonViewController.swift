//
//  CommonViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/7/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    var flightViewController : FlightViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signoutMethod(){
        print("CommonViewController: Signout Method")
//        let home :UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
//        print("1")
//        
//        self.presentViewController(home, animated: false, completion: nil)
//        print("2")
        
    }
    
    func viewFlightMethod(uiView: UIViewController){
        print("CommonViewController: ViewFlight Method")
        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
        flightViewController.showInView(uiView.view, animated: true)
        print("2.1")
    }
    
    func viewCartMethod(){
        
    }
    
    func callAssistMethod(){
        
    }
    
    func searchMethod(){
        
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
