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
    let detailTransitioningDelegate: PresentationManager = PresentationManager()
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
    
    func viewFlightMethod(uiView: UIViewController, flight: FlightViewController){
        print("CommonViewController: ViewFlight Method")
        flight.showInView(uiView.view, animated: true)
        
    }
    
    func viewCartMethod(uiView: UIViewController){
        print("CommonViewController: ViewCart Method")
        let cartViewController = uiView.storyboard?.instantiateViewControllerWithIdentifier("CartViewController") as? CartViewController
        uiView.navigationController?.pushViewController(cartViewController!, animated: true)
    }
    
    func callAssistMethod(uiView: UIViewController, call: CallAssistanceViewController){
        print("CommonViewController: CallAssist Method")
        call.showInView(uiView.view, animated: true)
    }
    
    func searchMethod(uiView: UIViewController){
        print("CommonViewController: Search Method")
        let searchViewController = uiView.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
        //let modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.FormSheet
        //searchViewController?.modalPresentationStyle = modalStyle
        detailTransitioningDelegate.height = 600
        detailTransitioningDelegate.width = 500
        searchViewController?.transitioningDelegate = detailTransitioningDelegate
        searchViewController?.modalPresentationStyle = .Custom
        searchViewController?.uiView = uiView
        uiView.presentViewController(searchViewController!, animated: true, completion: nil)
    }
    
    func alertView(uiView: UIViewController, title: String, message: String){
        
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        uiView.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func castDateFromString(oriDate: String, dateOnly: Bool) -> String {
        print("FLIGHT DATE: \(oriDate) ")
        var format : String = "yyyy-MM-dd"
        var amPm : String = ""
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        if(!dateOnly){
            
            //Validate AM or PM?
            let rangeOfAmPm = Range(start: oriDate.endIndex.advancedBy(-2), end: oriDate.endIndex)
            amPm = oriDate.substringWithRange(rangeOfAmPm)
            
            dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
            format = "yyyy-MM-dd hh:mm:ss"
            
        }
        
        var dateObj = dateFormatter.dateFromString(oriDate)!
        dateFormatter.dateFormat = format
        
        
        var tmp = dateFormatter.stringFromDate(dateObj)
        if(!dateOnly){
            //Cast AM/PM to 24 hours
            let rangeOfHours = Range(start: oriDate.startIndex.advancedBy(11), end: oriDate.startIndex.advancedBy(13))
            var hourString : String = tmp.substringWithRange(rangeOfHours)
            var hourInt : Int = Int(hourString)!
            
            if(amPm == "AM"){
                //AM
                //if time == 12 (12:30 AM) --> -12
                //00:30 (at night)
                //other (10:30 AM) --> do nothing
                if(hourInt == 12){
                    //replace with 00
                    tmp.replaceRange(rangeOfHours, with: "00")
                    
                }
                
            }else {
                //PM
                //if time == 12 (12:30 PM) --> do nothing
                //12:30 (at noon)
                //other (3:30 PM) --> +12
                //15:30
                if(hourInt < 12){
                    //Add 12
                    hourInt = hourInt + 12
                    tmp.replaceRange(rangeOfHours, with: String(hourInt))
                }
                
            }
            
        }
        
        print("Date Format 24 hours: \(tmp)")
        
        return tmp
    }
    
    func castDateFromDate(oriDate: NSDate) -> String {
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss a"
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
    
    func kpDateTimeDBFormat(oriString: String, dateOnly: Bool) -> String{
        var stringArray : [String] = ["","","",""]
        
        let rangeOfYear = Range(start: oriString.startIndex.advancedBy(6), end: oriString.startIndex.advancedBy(10))
        let rangeOfMonth = Range(start: oriString.startIndex.advancedBy(3), end: oriString.startIndex.advancedBy(5))
        let rangeOfDate = Range(start: oriString.startIndex, end: oriString.startIndex.advancedBy(2))
        
        
        stringArray[0] = oriString.substringWithRange(rangeOfYear)
        stringArray[1] = oriString.substringWithRange(rangeOfMonth)
        stringArray[2] = oriString.substringWithRange(rangeOfDate)
        if(dateOnly){
            //Date Format (Cast from 23/10/2016 to 2016-10-23 10:47:10 AM)
            return stringArray[0]+"-"+stringArray[1]+"-"+stringArray[2]+" 00:00:00"
        }else{
            //Date Time Format (Cast from 23/10/2016 10:30:22 to 2016-10-10 10:30:22)
            let rangeOfTime = Range(start: oriString.endIndex.advancedBy(-8), end: oriString.endIndex)
            stringArray[3] = oriString.substringWithRange(rangeOfTime)
            return stringArray[1]+"-"+stringArray[1]+"-"+stringArray[2]+" "+stringArray[3]
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
