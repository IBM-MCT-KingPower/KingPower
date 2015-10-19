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
            self.departDateLabel.text = CommonViewController().kpDateTimeFormat(self.departFlight!.flii_flight_date, dateOnly: true)
        }
        if(self.returnFlight!.flii_id == 0){
            self.returnFlightNoLable.text = "-"
        }else{
            self.returnFlightNoLable.text = self.returnFlight!.flii_flight_no
            self.returnDateLabel.text = CommonViewController().kpDateTimeFormat(self.returnFlight!.flii_flight_date, dateOnly: true)
        }
        
        
        
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
