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
    var callAssistanceViewController : CallAssistanceViewController!
    var dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signoutMethod(uiView: UIViewController){
        print("CommonViewController: Signout Method")
        let home = uiView.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as? LoginViewController
        uiView.navigationController?.pushViewController(home!, animated: true)
        
        
    }
    
    func viewFlightMethod(uiView: UIViewController){
        print("CommonViewController: ViewFlight Method")
        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
        flightViewController.showInView(uiView.view, animated: true)
        
    }
    
    func viewCartMethod(uiView: UIViewController){
        print("CommonViewController: ViewCart Method")
        let cartViewController = uiView.storyboard?.instantiateViewControllerWithIdentifier("CartViewController") as? CartViewController
        uiView.navigationController?.pushViewController(cartViewController!, animated: true)
    }
    
    func callAssistMethod(uiView: UIViewController){
        print("CommonViewController: CallAssist Method")
        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
        callAssistanceViewController.showInView(uiView.view, animated: true)    }
    
    func searchMethod(uiView: UIViewController){
        print("CommonViewController: Search Method")
        let searchViewController = uiView.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
        let modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.FormSheet
        searchViewController?.modalPresentationStyle = modalStyle
        searchViewController?.uiView = uiView
        uiView.presentViewController(searchViewController!, animated: true, completion: nil)
    }
    
    func alertView(uiView: UIViewController, title: String, message: String){
        
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        uiView.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func castDateFromString(oriDate: String) -> String {
        print("FLIGHT DATE: \(oriDate) ")
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        var dateObj = dateFormatter.dateFromString(oriDate)!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.stringFromDate(dateObj)
    }
    
    func castDateFromDate(oriDate: NSDate) -> String {
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(oriDate)
        
    }
    
    
    func kpDateTimeFormat(oriString: String, dateOnly: Bool) -> String{
        print("")
        var stringArray : [String] = ["","","",""]
        
        let rangeOfYear = Range(start: oriString.startIndex, end: oriString.startIndex.advancedBy(4))
        let rangeOfMonth = Range(start: oriString.startIndex.advancedBy(5), end: oriString.startIndex.advancedBy(7))
        let rangeOfDate = Range(start: oriString.startIndex.advancedBy(8), end: oriString.startIndex.advancedBy(10))
        
        
        stringArray[0] = oriString.substringWithRange(rangeOfYear)
        stringArray[1] = oriString.substringWithRange(rangeOfMonth)
        stringArray[2] = oriString.substringWithRange(rangeOfDate)
        if(dateOnly){
            //Date Format (Cast from 2016-10-23 to 23/10/2016)
            return stringArray[2]+"/"+stringArray[1]+"/"+stringArray[0]
        }else{
            //Date Time Format (Cast from 2016-10-23 10:30:22 to 23/10/2016 10:30:22)
            let rangeOfTime = Range(start: oriString.endIndex.advancedBy(-8), end: oriString.endIndex)
            stringArray[3] = oriString.substringWithRange(rangeOfTime)
            return stringArray[2]+"/"+stringArray[1]+"/"+stringArray[0]+" "+stringArray[3]
        }
        return ""
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
