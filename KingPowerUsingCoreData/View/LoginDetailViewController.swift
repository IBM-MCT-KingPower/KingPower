//
//  LoginDetailViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/18/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class LoginDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    var gv = GlobalVariable()
    var setupNav = KPNavigationBar()
    var commonViewController = CommonViewController()
    
    var customer : CustomerModel = CustomerModel()
    
    @IBOutlet weak var customerCardImage : UIImageView!
    @IBOutlet weak var customerNameLabel : UILabel!
    @IBOutlet weak var customerBirthdateLabel : UILabel!
    @IBOutlet weak var cardIdLabel: UILabel!
    @IBOutlet weak var cardExpireDateLabel : UILabel!
    @IBOutlet weak var customerPointLabel : UILabel!
    @IBOutlet weak var customerPointExpireDateLabel : UILabel!
    
    @IBOutlet weak var departAirlineTextField: UITextField!
    @IBOutlet weak var returnAirlineTextField: UITextField!
    @IBOutlet weak var departFlightNoTextField: UITextField!
    @IBOutlet weak var returnFlightNoTextField: UITextField!
    
    @IBOutlet weak var departDateTextField: UITextField!
    @IBOutlet weak var returnDateTextField: UITextField!
    
    
    var dateFormatter = NSDateFormatter()
    
    var departFlight : FlightInfoModel? = FlightInfoModel()
    var returnFlight : FlightInfoModel? = FlightInfoModel()
    
    
    var departAirlinePickerOption = ["ANA", "Cathay Pacific", "Emirates", "Qatar Airways", "Singapore Airlines", "Thai Airways"]
    
    var returnAirlinePickerOption = ["ANA", "Cathay Pacific", "Emirates", "Qatar Airways", "Singapore Airlines", "Thai Airways"]
    
    override func viewDidLoad() {
        print("LoginDetailViewController")
        super.viewDidLoad()
        setupNav.setupNavigationBar(self)
        
        print("Customer Model FirstName : \(self.customer.cust_first_name)")
        
        //Prepare the customer information
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.customerNameLabel.text = self.customer.cust_title+". "+self.customer.cust_first_name+" "+self.customer.cust_last_name
        self.customerBirthdateLabel.text = dateFormatter.stringFromDate(self.customer.cust_birthdate)
        self.cardIdLabel.text = String(self.customer.cust_card_id)
        print("CARD EXPIRE DATE: \(self.customer.cust_card_exp_date)")
        self.cardExpireDateLabel.text = dateFormatter.stringFromDate(self.customer.cust_card_exp_date)
        self.customerPointLabel.text = String(self.customer.cust_point)
        self.customerPointExpireDateLabel.text = dateFormatter.stringFromDate(self.customer.cust_point_exp_date)
        
        var cardImage = UIImage(named: self.customer.cust_card_level+".png")
        self.customerCardImage.image = cardImage
        
        var pickerViewDepart = UIPickerView()
        var pickerViewReturn = UIPickerView()
        var pickerViewDepartDate = UIDatePicker()
        var pickerViewReturnDate = UIDatePicker()
        
        pickerViewDepart.delegate = self
        pickerViewReturn.delegate = self
        pickerViewDepartDate.datePickerMode = UIDatePickerMode.Date
        pickerViewReturnDate.datePickerMode = UIDatePickerMode.Date
        
        pickerViewDepart.tag = 0
        pickerViewReturn.tag = 1
        pickerViewDepartDate.tag = 2
        pickerViewReturnDate.tag = 3
        
        departAirlineTextField.inputView = pickerViewDepart
        returnAirlineTextField.inputView = pickerViewReturn
        departDateTextField.inputView = pickerViewDepartDate
        returnDateTextField.inputView = pickerViewReturnDate
        
        pickerViewDepartDate.addTarget(self, action: Selector("departDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        pickerViewReturnDate.addTarget(self, action: Selector("returnDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
    }
    
    func SignoutMethod(){
        commonViewController.signoutMethod(self)
        
        
    }
    
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView.tag == 0){
            return departAirlinePickerOption.count
        }else{
            return returnAirlinePickerOption.count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView.tag == 0){
            return departAirlinePickerOption[row]
        }else{
            return returnAirlinePickerOption[row]
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 0){
            departAirlineTextField.text = departAirlinePickerOption[row]
        }else if(pickerView.tag == 1){
            returnAirlineTextField.text = returnAirlinePickerOption[row]
        }
        self.view.endEditing(true)
    }
    
    func departDatePickerValueChanged(sender:UIDatePicker) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        departDateTextField.text = dateFormatter.stringFromDate(sender.date)
        departDateTextField.resignFirstResponder()
    }
    
    func returnDatePickerValueChanged(sender:UIDatePicker) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        returnDateTextField.text = dateFormatter.stringFromDate(sender.date)
        returnDateTextField.resignFirstResponder()
        
    }
    
    @IBAction func btnScanBarcodeTapped(sender: AnyObject){
        commonViewController.alertView(self, title:  gv.getConfigValue("messageScanBoardingPassTitle") as! String, message:  gv.getConfigValue("messageUnderImplementation") as! String)
        
    }
    
    @IBAction func btnContinueTapped(sender: AnyObject){
        
        print("Tapped Continue Button")
        
        //Validate Flight Information
        var hasDepartInfo = false
        var hasReturnInfo = false
        if(self.departAirlineTextField!.text != "" || self.departFlightNoTextField!.text != "" || self.departDateTextField!.text != ""){
            
            //If one of these fields has value --> Need to check required for other 2 fields
            if(self.departAirlineTextField!.text == "" || self.departFlightNoTextField!.text == "" || self.departDateTextField!.text == ""){
                commonViewController.alertView(self, title: gv.getConfigValue("messageFlightFailTitle") as! String, message: gv.getConfigValue("messageFlightRequiredField") as! String)
                
            }else{
                hasDepartInfo = true
                if(self.returnAirlineTextField!.text != "" || self.returnFlightNoTextField!.text != "" || self.returnDateTextField!.text != ""){
                    //If one of these fields has value --> Need to check required for other 2 fields
                    if(self.returnAirlineTextField!.text == "" || self.returnFlightNoTextField!.text == "" || self.returnDateTextField!.text == ""){
                        commonViewController.alertView(self, title: gv.getConfigValue("messageFlightFailTitle") as! String, message: gv.getConfigValue("messageReturnRequiredField") as! String)
                    }else{
                        //Validate Pass
                        hasReturnInfo = true
                    }
                    
                }
                
            }
            
        }
        
        var flightInfoController = FlightInfoController()
        
        if(hasDepartInfo){
            //Insert into FlightInfo Table
            
            var flightDateAsString = commonViewController.castDateFromString(self.departDateTextField!.text!)
            var currentDate = commonViewController.castDateFromDate(NSDate())
            
            self.departFlight = flightInfoController.insertFlight(self.customer.cust_id, flii_airline: self.departAirlineTextField!.text!, flii_flight_no: self.departFlightNoTextField!.text!, flii_flight_date: flightDateAsString, flii_return_flag: gv.getConfigValue("flagNo") as! String, flii_create_date: currentDate)
        }
        
        if(hasReturnInfo){
            //Insert into FlightInfo Table
            
            var flightDateAsString = commonViewController.castDateFromString(self.returnDateTextField!.text!)
            var currentDate = commonViewController.castDateFromDate(NSDate())
            
            self.returnFlight = flightInfoController.insertFlight(self.customer.cust_id, flii_airline: self.returnAirlineTextField!.text!, flii_flight_no: self.returnFlightNoTextField!.text!, flii_flight_date: flightDateAsString, flii_return_flag: gv.getConfigValue("flagYes") as! String, flii_create_date: currentDate)
            
        }
        
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("CUSTOMER ID :      \(self.customer.cust_id)")
        print("DEPART FLIGHT ID : \(self.departFlight?.flii_id)")
        print("RETURN FLIGHT ID : \(self.returnFlight?.flii_id)")
        (segue.destinationViewController as! WelcomeViewController).customer = self.customer
        (segue.destinationViewController as! WelcomeViewController).departFlight = self.departFlight
        (segue.destinationViewController as! WelcomeViewController).returnFlight = self.returnFlight
        
    }
    
    
}
