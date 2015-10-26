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
    
    var departAirlinePickerOption : [String] = KPVariable.airlinePickerOption
    var returnAirlinePickerOption : [String] = KPVariable.airlinePickerOption
    
    var departFlightPickerOption : [String] = []
    var returnFlightPickerOption : [String] = []
    
    var departFlight : FlightInfoModel? = FlightInfoModel()
    var returnFlight : FlightInfoModel? = FlightInfoModel()
    
    var textFont = UIFont(name: "Century Gothic", size: 15.0)!
    var textColor = UIColor(red: 0/255, green: 110/255, blue: 204/255, alpha: 1)
    var pickerBgColor = UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha:1)
    var toolBarBgColor = UIColor(red: 204/255, green: 226/255, blue: 245/255, alpha: 0.65)
    var originY : CGFloat = 0.0
    
    
    override func viewDidLoad() {
        print("LoginDetailViewController")
        super.viewDidLoad()
        setupNav.setupNavigationBar(self)
        
        print("Customer Model FirstName : \(self.customer.cust_first_name)")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
        
        //Prepare the customer information
        self.dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        self.dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        self.customerNameLabel.text = self.customer.cust_title+". "+self.customer.cust_first_name+" "+self.customer.cust_last_name
        self.customerBirthdateLabel.text = commonViewController.kpDateTimeFormat(self.customer.cust_birthdate, dateOnly: true)
        self.cardIdLabel.text = String(self.customer.cust_card_id)
        self.cardExpireDateLabel.text = commonViewController.kpDateTimeFormat(self.customer.cust_card_exp_date, dateOnly: true)
        self.customerPointLabel.text = String(self.customer.cust_point)
        self.customerPointExpireDateLabel.text = commonViewController.kpDateTimeFormat(self.customer.cust_point_exp_date, dateOnly: true)
        
        var cardImage = UIImage(named: self.customer.cust_card_level.uppercaseString+".png")
        self.customerCardImage.image = cardImage
        
        var pickerViewDepart = UIPickerView()
        var pickerViewReturn = UIPickerView()
        var pickerViewDepartFlight = UIPickerView()
        var pickerViewReturnFlight = UIPickerView()
        var pickerViewDepartDate = UIDatePicker()
        var pickerViewReturnDate = UIDatePicker()
        
        
        pickerViewDepart.delegate = self
        pickerViewReturn.delegate = self
        pickerViewDepartFlight.delegate = self
        pickerViewReturnFlight.delegate = self
        pickerViewDepartDate.datePickerMode = UIDatePickerMode.DateAndTime
        pickerViewReturnDate.datePickerMode = UIDatePickerMode.DateAndTime
        
        pickerViewDepart.backgroundColor = self.pickerBgColor
        pickerViewReturn.backgroundColor = self.pickerBgColor
        pickerViewDepartFlight.backgroundColor = self.pickerBgColor
        pickerViewReturnFlight.backgroundColor = self.pickerBgColor
        pickerViewDepartDate.backgroundColor = self.pickerBgColor
        pickerViewReturnDate.backgroundColor = self.pickerBgColor
        pickerViewDepartDate.setValue(self.textColor, forKeyPath: "textColor")
        pickerViewReturnDate.setValue(self.textColor, forKeyPath: "textColor")
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.frame = CGRectMake(20, 20, 20, 20)
        toolBar.translucent = true
        toolBar.tintColor = self.textColor
        toolBar.barTintColor = self.toolBarBgColor
        toolBar.sizeToFit()
        
        let fixedItemSpaceWidth = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        fixedItemSpaceWidth.width = 880
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([cancelButton, fixedItemSpaceWidth, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        pickerViewDepart.tag = 0
        pickerViewReturn.tag = 1
        pickerViewDepartDate.tag = 2
        pickerViewReturnDate.tag = 3
        pickerViewDepartFlight.tag = 4
        pickerViewReturnFlight.tag = 5
        
        departAirlineTextField.tag = 6
        departFlightNoTextField.tag = 7
        departDateTextField.tag = 8
        returnAirlineTextField.tag = 9
        returnFlightNoTextField.tag = 10
        returnDateTextField.tag = 11
        
        departAirlineTextField.inputView = pickerViewDepart
        departAirlineTextField.inputAccessoryView = toolBar
        departAirlineTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        
        returnAirlineTextField.inputView = pickerViewReturn
        returnAirlineTextField.inputAccessoryView = toolBar
        returnAirlineTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        
        departDateTextField.inputView = pickerViewDepartDate
        departDateTextField.inputAccessoryView = toolBar
        departDateTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        
        returnDateTextField.inputView = pickerViewReturnDate
        returnDateTextField.inputAccessoryView = toolBar
        returnDateTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        
        departFlightNoTextField.inputView = pickerViewDepartFlight
        departFlightNoTextField.inputAccessoryView = toolBar
        departFlightNoTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        
        returnFlightNoTextField.inputView = pickerViewReturnFlight
        returnFlightNoTextField.inputAccessoryView = toolBar
        returnFlightNoTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        
        pickerViewDepartDate.addTarget(self, action: Selector("departDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        pickerViewReturnDate.addTarget(self, action: Selector("returnDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(sender: NSNotification) {
        originY = (gv.getConfigValue("keyboardHeight") as! CGFloat)*(-1)
        
        if(self.view.frame.origin.y >= originY){
            self.view.frame.origin.y -= 205
        }
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        originY = (gv.getConfigValue("keyboardHeight") as! CGFloat)*(-1)
        if(self.view.frame.origin.y < originY){
            self.view.frame.origin.y = 0.0
        }else{
            self.view.frame.origin.y += 205
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
        }else if(pickerView.tag == 1){
            return returnAirlinePickerOption.count
        }else if(pickerView.tag == 4){
            return departFlightPickerOption.count
        }else if(pickerView.tag == 5){
            return returnFlightPickerOption.count
        }else{
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        var titleData = ""
        if(pickerView.tag == 0){
            titleData = departAirlinePickerOption[row]
            
        }else if(pickerView.tag == 1){
            titleData = returnAirlinePickerOption[row]
            
        }else if(pickerView.tag == 4){
            titleData = departFlightPickerOption[row]
            
        }else if(pickerView.tag == 5){
            titleData = returnFlightPickerOption[row]
            
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:self.textColor])
        return myTitle
    }
    
    func setDefaultValue(sender: UITextField){
        
        if(sender.tag == 6){
            //Depart Airline
            self.departAirlineTextField!.text = self.departAirlinePickerOption[0]
            self.departFlightPickerOption = KPVariable.getFlightNoByAirline(self.departAirlinePickerOption[0])
        }else if(sender.tag == 7){
            //Depart Flight
            self.departFlightNoTextField!.text = self.departFlightPickerOption[0]
            
        }else if(sender.tag == 8){
            //Depart Date
            self.departDateTextField.text = self.dateFormatter.stringFromDate(NSDate())
            
        }else if(sender.tag == 9){
            //Return Airline
            self.returnAirlineTextField!.text = self.returnAirlinePickerOption[0]
            self.returnFlightPickerOption = KPVariable.getFlightNoByAirline(self.returnAirlinePickerOption[0])
            
        }else if(sender.tag == 10){
            //Return Flight
            self.returnFlightNoTextField!.text = self.returnFlightPickerOption[0]
            
        }else if(sender.tag == 11){
            //Return Date
            self.returnDateTextField.text = self.dateFormatter.stringFromDate(NSDate())
            
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedAirline : String = ""
        if(pickerView.tag == 0){
            selectedAirline = departAirlinePickerOption[row]
            departAirlineTextField.text = selectedAirline
            departFlightPickerOption = KPVariable.getFlightNoByAirline(selectedAirline)
            
        }else if(pickerView.tag == 1){
            selectedAirline = returnAirlinePickerOption[row]
            returnAirlineTextField.text = selectedAirline
            returnFlightPickerOption = KPVariable.getFlightNoByAirline(selectedAirline)
            
        }else if(pickerView.tag == 4){
            departFlightNoTextField.text = departFlightPickerOption[row]
            
        }else if(pickerView.tag == 5){
            returnFlightNoTextField.text = returnFlightPickerOption[row]
            
        }
    }
    
    func donePicker() {
        self.view.endEditing(true)
        
    }
    
    func departDatePickerValueChanged(sender:UIDatePicker) {
        
        departDateTextField.text = self.dateFormatter.stringFromDate(sender.date)
    }
    
    func returnDatePickerValueChanged(sender:UIDatePicker) {
        
        returnDateTextField.text = self.dateFormatter.stringFromDate(sender.date)
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
            
            var flightDateAsString = commonViewController.castDateFromString(self.departDateTextField!.text!, dateOnly: false)
            var currentDate = commonViewController.castDateFromDate(NSDate())
            print("insert Flight")
            var departFlightId = flightInfoController.insertFlight(self.customer.cust_id, flii_airline: self.departAirlineTextField!.text!, flii_flight_no: self.departFlightNoTextField!.text!, flii_flight_date: flightDateAsString, flii_return_flag: gv.getConfigValue("flagNo") as! String)
            
            self.departFlight?.flii_airline = self.departAirlineTextField!.text!
            self.departFlight?.flii_flight_no = self.departFlightNoTextField!.text!
            self.departFlight?.flii_flight_date = flightDateAsString
            
        }
        
        if(hasReturnInfo){
            //Insert into FlightInfo Table
            
            var flightDateAsString = commonViewController.castDateFromString(self.returnDateTextField!.text!, dateOnly: false)
            var currentDate = commonViewController.castDateFromDate(NSDate())
            
            var returnFlightId = flightInfoController.insertFlight(self.customer.cust_id, flii_airline: self.returnAirlineTextField!.text!, flii_flight_no: self.returnFlightNoTextField!.text!, flii_flight_date: flightDateAsString, flii_return_flag: gv.getConfigValue("flagYes") as! String)
            
            
            
            self.returnFlight?.flii_airline = self.returnAirlineTextField!.text!
            self.returnFlight?.flii_flight_no = self.returnFlightNoTextField!.text!
            self.returnFlight?.flii_flight_date = flightDateAsString
            
        }
        
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        (segue.destinationViewController as! WelcomeViewController).customer = self.customer
        (segue.destinationViewController as! WelcomeViewController).departFlight = self.departFlight
        (segue.destinationViewController as! WelcomeViewController).returnFlight = self.returnFlight
        
    }
    
    
}
