//
//  FlightViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 10/4/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class FlightViewController: UIViewController {

    
    @IBOutlet weak var vContainer: UIView!
    @IBOutlet weak var vMain: UIView!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var lblFlight: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    var gv = GlobalVariable()
    var flight : FlightInfoModel? = FlightInfoModel()
    
    override func viewWillAppear(animated: Bool) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        let flightArray = FlightInfoController().getFlightByCustomerId(custId)
        
        var hasMinFlight = Bool()
        var minFlightDate = NSDate()
        var message:String = "YOU DID NOT HAVE FLIGHT IN 2 DAYS"
        var messageTime:String = ""
        
        for i in flightArray! {
            let nowDate = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let customDate = dateFormatter.dateFromString(i.flii_flight_date)
            print("Date format :\(customDate!)")
            /*
            let elapsedTime = customDate!.timeIntervalSinceDate(nowDate)
            print("patis elapsedTime " +  String(elapsedTime));
            
            if elapsedTime < 172800 && elapsedTime > 0 { //172800 = 2 day
            }
            */
            let dayHourMinuteSecond: NSCalendarUnit = [.Day,
                .Hour,
                .Minute,
                .Second]
            let difference = NSCalendar.currentCalendar().components(
                dayHourMinuteSecond,
                fromDate: nowDate,
                toDate: customDate!,
                options: [])
            print("difference day : \(difference.day) min : \(difference.minute)")
            if difference.day > 2 || difference.day < 0 || difference.hour < 0 || difference.minute < 0 || difference.second < 0 {
                hasMinFlight = false
            }
            else{
                print("has in flight")
                var recordNew:Bool = false
                if hasMinFlight == false {
                    hasMinFlight = true
                    recordNew = true
                    minFlightDate = customDate!
                }
                else{
                    let elapsedTime = customDate!.timeIntervalSinceDate(minFlightDate)
                    
                    if elapsedTime < 0 {
                        minFlightDate = customDate!
                        recordNew = true
                    }
                }
                if recordNew == true{
                    message = "YOUR NEXT FLIGHT IS " + i.flii_flight_no + ". BOARDING GATE WILL CLOSE IN"
                    messageTime = ""
                    if difference.day > 0 {
                        messageTime += String(difference.day)
                        if difference.day > 1 {
                            messageTime += " Days "
                        }
                        else{
                            messageTime += " Day "
                        }
                    }
                    if difference.hour > 0 {
                        messageTime += String(difference.hour)
                        if difference.hour > 1 {
                            messageTime += " Hours "
                        }
                        else{
                            messageTime += " Hour "
                        }
                    }
                    if difference.minute > 0{
                        messageTime += String(difference.minute)
                        if difference.minute > 1 {
                            messageTime += " Minutes "
                        }
                        else{
                            messageTime += " Minute "
                        }
                    }
                }
            }
        }
        lblFlight.text = message
        lblTime.text = messageTime
        let flightArray1 = FlightInfoController().getFlightByCustomerIdOnly(custId)
        for flight in flightArray1! {
            print("All Flight date : \(flight.flii_flight_date)")
        }
        
        for flight in flightArray! {
            print("Flight date : \(flight.flii_flight_date)")
        }
    }
    override func viewDidAppear(animated: Bool) {
        //self.vMain.frame = CGRectMake(0, 80, 1024, 500)
        //self.vContainer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        let gesture1 = UITapGestureRecognizer(target: self, action: "tappedView:")
        self.vContainer.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action: "tappedView:")
        self.vMain.addGestureRecognizer(gesture2)
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
            self.showAnimate()
        }
    }
    func showAnimate()
    {
        self.vMain.alpha = 0.0;
        self.vContainer.alpha = 0.0;
        //self.vMain.frame = CGRectMake(0, -200, 1024, 200)
        UIView.animateWithDuration(0.5, animations: {
            self.vMain.alpha = 1.0
            self.vMain.center.y = 500
            self.vContainer.alpha = 0.5
            self.vContainer.center.y = 1000
        });
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        removeAnimate()
    }
    
    func removeAnimate()
    {
        
        UIView.animateWithDuration(0.5, animations: {
            self.vMain.alpha = 0.0
            self.vMain.center.y = -500
            self.vContainer.alpha = 0.0
            self.vContainer.center.y = -1000
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    func tappedView(sender:UITapGestureRecognizer){
        // do other task
        removeAnimate()
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
