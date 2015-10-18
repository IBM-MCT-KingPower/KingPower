//
//  WelcomeViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/4/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
import APAvatarImageView
import DynamicColor

class WelcomeViewController: UIViewController {
    
    var gv = GlobalVariable()
    var setupNav = KPNavigationBar()
    
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var birthdateLabel : UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var pointExpireDateLabel: UILabel!
    @IBOutlet weak var cardIdLabel: UILabel!
    @IBOutlet weak var cardLevelLabel: UILabel!
    @IBOutlet weak var cardExpireDateLabel: UILabel!
    @IBOutlet weak var departFlightNoLable: UILabel!
    @IBOutlet weak var departDateLabel: UILabel!
    @IBOutlet weak var returnFlightNoLable: UILabel!
    @IBOutlet weak var returnDateLabel: UILabel!
    
    
    @IBOutlet weak var btnStart: UIButton!
    
    var customer = CustomerModel()
    var dateFormatter = NSDateFormatter()
    var departFlight : FlightInfoModel? = FlightInfoModel()
    var returnFlight : FlightInfoModel? = FlightInfoModel()
    var commonViewController = CommonViewController()
    
    var constat = Constants()
    var lol = Locale()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("WelcomeViewController")
        print("CUST ID : \(self.customer.cust_id)")
        print("CUST FIST NAME : \(self.customer.cust_first_name)")
        print("CUST LAST NAME : \(self.customer.cust_last_name)")
        //        print("CUST ID : \(self.customer.cust)")
        
        
        setupNav.setupNavigationBar(self)
        
        
        //Prepare the customer information
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.customerNameLabel.text = self.customer.cust_title+". "+self.customer.cust_first_name+" "+self.customer.cust_last_name
        self.birthdateLabel.text = commonViewController.kpDateTimeFormat(self.customer.cust_birthdate, dateOnly: true)
        self.pointLabel.text = String(self.customer.cust_point)
        self.pointExpireDateLabel.text = commonViewController.kpDateTimeFormat(self.customer.cust_point_exp_date, dateOnly: true)
        self.cardIdLabel.text = String(self.customer.cust_card_id)
        self.cardLevelLabel.text = self.customer.cust_card_level
        self.cardExpireDateLabel.text = commonViewController.kpDateTimeFormat(self.customer.cust_card_exp_date, dateOnly: true)
        if(self.departFlight!.flii_id == 0){
            self.departFlightNoLable.text = "-"
        }else{
            self.departFlightNoLable.text = self.departFlight!.flii_flight_no
            self.departDateLabel.text = commonViewController.kpDateTimeFormat(self.departFlight!.flii_flight_date, dateOnly: true)
        }
        if(self.returnFlight!.flii_id == 0){
            self.returnFlightNoLable.text = "-"
        }else{
            self.returnFlightNoLable.text = self.returnFlight!.flii_flight_no
            self.returnDateLabel.text = commonViewController.kpDateTimeFormat(self.returnFlight!.flii_flight_date, dateOnly: true)
        }
        
        // Do any additional setup after loading the view.
        self.decorate()
        
    }
    
    
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func decorate() {
        //        self.imgCustomer.borderColor = UIColor(hex: 0x425F9C)
        //        self.imgCustomer.image = UIImage(named: "IMG_8040.PNG")
        //        self.lblCustomerName.text = "Mrs. Duangkamol Chewchan"
        //        self.btnStart.setTitle(self.constat.customLocalizedString("welcomeStart", comment: "this is comment")as String, forState: .Normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        prefs.setInteger(0, forKey: gv.getConfigValue("currentAmountInCart") as! String)
        prefs.synchronize()
    }
    
    
}
