//
//  AddNewFlightViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 10/18/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
protocol thankyouDelegate{
    func forwardToThankyou(insertedOrderMain: OrderMainModel)
}

class AddNewFlightViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate  {
    var delegate:thankyouDelegate?
    @IBOutlet weak var btnDone:UIButton!
    @IBOutlet weak var btnCancel:UIButton!
    @IBOutlet weak var departAirlineTextField: UITextField!
    @IBOutlet weak var returnAirlineTextField: UITextField!
    @IBOutlet weak var departFlightNoTextField: UITextField!
    @IBOutlet weak var returnFlightNoTextField: UITextField!
    
    @IBOutlet weak var departDateTextField: UITextField!
    @IBOutlet weak var returnDateTextField: UITextField!
    
    @IBOutlet weak var lblRequiredDepart: UILabel!
    @IBOutlet weak var lblRequiredReturn: UILabel!
    
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
    
    var gv = GlobalVariable()
    var commonViewController = CommonViewController()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    let currentDate = CommonViewController().castDateFromDate(NSDate())
    let yFlag = GlobalVariable().getConfigValue("flagYes") as! String
    let nFlag = GlobalVariable().getConfigValue("flagNo") as! String
    
    var orderMain:OrderMainModel!
    var cartPickNowArray:[CartModel]!
    var cartPickLaterArray:[CartModel]!
    var departFlightArray:[FlightInfoModel]!
    var returnFlightArray:[FlightInfoModel]!
    
    var selectedDepartAirline = ""
    var selectedDepartFlightNo = ""
    var selectedDepartDate = ""
    var selectedDepartDateFormat:NSDate!
    var selectedReturnAirline = ""
    var selectedReturnFlightNo = ""
    var selectedReturnDate = ""
    var selectedReturnDateFormat:NSDate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init button style
        self.btnCancel.layer.cornerRadius = 5
        self.btnCancel.layer.borderWidth = 2.0
        self.btnCancel.layer.borderColor = UIColor.blackColor().CGColor
        self.btnDone.layer.cornerRadius = 5
        // set which one are required field
        lblRequiredDepart.hidden = true
        lblRequiredReturn.hidden = true
        if cartPickNowArray.count > 0 {
            lblRequiredDepart.hidden = false
        }
        if cartPickLaterArray.count > 0 {
            lblRequiredReturn.hidden = false
        }
        // setup toolbar and all picker view
        let pickerViewDepart = UIPickerView()
        let pickerViewReturn = UIPickerView()
        let pickerViewDepartFlight = UIPickerView()
        let pickerViewReturnFlight = UIPickerView()
        let pickerViewDepartDate = UIDatePicker()
        let pickerViewReturnDate = UIDatePicker()
        
        pickerViewDepart.delegate = self
        pickerViewReturn.delegate = self
        pickerViewDepartFlight.delegate = self
        pickerViewReturnFlight.delegate = self
        pickerViewDepartDate.datePickerMode = UIDatePickerMode.Date
        pickerViewReturnDate.datePickerMode = UIDatePickerMode.Date
        
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
        
        let flexibleItemSpaceWidth = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([cancelButton, flexibleItemSpaceWidth, doneButton], animated: false)
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
        departAirlineTextField.autocapitalizationType = UITextAutocapitalizationType.None
        
        returnAirlineTextField.inputView = pickerViewReturn
        returnAirlineTextField.inputAccessoryView = toolBar
        
        departDateTextField.inputView = pickerViewDepartDate
        departDateTextField.inputAccessoryView = toolBar
        
        returnDateTextField.inputView = pickerViewReturnDate
        returnDateTextField.inputAccessoryView = toolBar
        
        departFlightNoTextField.inputView = pickerViewDepartFlight
        departFlightNoTextField.inputAccessoryView = toolBar
        
        returnFlightNoTextField.inputView = pickerViewReturnFlight
        returnFlightNoTextField.inputAccessoryView = toolBar
        
        // Set default information from FlightInfoViewController into textfield and picker view
        departAirlineTextField.text = selectedDepartAirline
        departFlightNoTextField.text = selectedDepartFlightNo
        departDateTextField.text = selectedDepartDate
        returnAirlineTextField.text = selectedReturnAirline
        returnFlightNoTextField.text = selectedReturnFlightNo
        returnDateTextField.text = selectedReturnDate
        
        if selectedDepartAirline != "" {
            var index = departAirlinePickerOption.indexOf(selectedDepartAirline)
            if let ind = index {
                pickerViewDepart.selectRow(ind, inComponent: 0, animated: true)
            }
            departFlightPickerOption = KPVariable.getFlightNoByAirline(selectedDepartAirline)
            index = departFlightPickerOption.indexOf(selectedDepartFlightNo)
            if let ind = index {
                pickerViewDepartFlight.selectRow(ind, inComponent: 0, animated: true)
            }
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.dateFromString(selectedDepartDate)
            pickerViewDepartDate.setDate(date!, animated: false)
            
        }else{
            departAirlineTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
            departFlightNoTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
            departDateTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        }
        if selectedReturnAirline != "" {
            var index = returnAirlinePickerOption.indexOf(selectedReturnAirline)
            if let ind = index {
                pickerViewReturn.selectRow(ind, inComponent: 0, animated: true)
            }
            returnFlightPickerOption = KPVariable.getFlightNoByAirline(selectedReturnAirline)
            index = returnFlightPickerOption.indexOf(selectedReturnFlightNo)
            if let ind = index {
                pickerViewReturnFlight.selectRow(ind, inComponent: 0, animated: true)
            }
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.dateFromString(selectedReturnDate)
            pickerViewReturnDate.setDate(date!, animated: false)
        }else{
            returnAirlineTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
            returnFlightNoTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
            returnDateTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        }
        
        pickerViewDepartDate.addTarget(self, action: Selector("departDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        pickerViewReturnDate.addTarget(self, action: Selector("returnDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // Keyboard Notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
        
    }

    // MARK: - Keyboard Toggle
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Picker View
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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedAirline : String = ""
        
        if(pickerView.tag == 0){
            selectedAirline = departAirlinePickerOption[row]
            departAirlineTextField.text = selectedAirline
            departFlightNoTextField.text = ""
            departDateTextField.text = ""
            departFlightPickerOption = KPVariable.getFlightNoByAirline(selectedAirline)
            
        }else if(pickerView.tag == 1){
            selectedAirline = returnAirlinePickerOption[row]
            returnAirlineTextField.text = selectedAirline
            returnFlightNoTextField.text = ""
            returnDateTextField.text = ""
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
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        print(dateFormatter.stringFromDate(sender.date))
        let oriDate = dateFormatter.stringFromDate(sender.date)
        let date = commonViewController.castDateFromString(oriDate, dateOnly:true)
        departDateTextField.text = commonViewController.kpDateTimeFormat(date, dateOnly:true)
    }
    
    func returnDatePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        let oriDate = dateFormatter.stringFromDate(sender.date)
        let date = commonViewController.castDateFromString(oriDate, dateOnly:true)
        returnDateTextField.text = commonViewController.kpDateTimeFormat(date, dateOnly:true)
    }
    func setDefaultValue(sender: UITextField){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        let textFont = UIFont(name: "Century Gothic", size: 17.0)!
        if(sender.tag == 6){
            //Depart Airline
            self.departAirlineTextField!.text = self.departAirlinePickerOption[0]
            self.departFlightPickerOption = KPVariable.getFlightNoByAirline(self.departAirlinePickerOption[0])
            self.departAirlineTextField!.font = textFont
            self.departAirlineTextField!.textColor = textColor
        }else if(sender.tag == 7){
            //Depart Flight
            self.departFlightNoTextField!.text = self.departFlightPickerOption[0]
            self.departFlightNoTextField!.font = textFont
            self.departFlightNoTextField!.textColor = textColor
            
        }else if(sender.tag == 8){
            //Depart Date
            let date = commonViewController.castDateFromString(dateFormatter.stringFromDate(NSDate()), dateOnly:true)
            self.departDateTextField!.text = commonViewController.kpDateTimeFormat(date, dateOnly:true)
            self.departDateTextField!.font = textFont
            self.departDateTextField!.textColor = textColor
        }else if(sender.tag == 9){
            //Return Airline
            self.returnAirlineTextField!.text = self.returnAirlinePickerOption[0]
            self.returnFlightPickerOption = KPVariable.getFlightNoByAirline(self.returnAirlinePickerOption[0])
            self.returnAirlineTextField!.font = textFont
            self.returnAirlineTextField!.textColor = textColor
        }else if(sender.tag == 10){
            //Return Flight
            self.returnFlightNoTextField!.text = self.returnFlightPickerOption[0]
            self.returnFlightNoTextField!.font = textFont
            self.returnFlightNoTextField!.textColor = textColor
        }else if(sender.tag == 11){
            //Return Date
            let date = commonViewController.castDateFromString(dateFormatter.stringFromDate(NSDate()), dateOnly:true)
            self.returnDateTextField!.text = commonViewController.kpDateTimeFormat(date, dateOnly:true)
            self.returnDateTextField!.font = textFont
            self.returnDateTextField!.textColor = textColor
        }
        
    }
    
    
    // MARK: - IB Action
    @IBAction func btnScanBarcodeTapped(sender: AnyObject){
        commonViewController.alertView(self, title:  gv.getConfigValue("messageScanBoardingPassTitle") as! String, message:  gv.getConfigValue("messageUnderImplementation") as! String)
        
    }
    
    @IBAction func btnCancelTapped(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnAddTapped(sender: AnyObject){
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let currentLocation = prefs.objectForKey(gv.getConfigValue("currentLocation") as! String) as! String
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        let suvarnabhumi = gv.getConfigValue("locationSuvarnabhumiAirport") as! String
        let passport = orderMain.ordm_passport_no
        let departAirline = self.departAirlineTextField!.text!
        let returnAirline = self.returnAirlineTextField!.text!
        let departFlightNo = self.departFlightNoTextField!.text!
        let returnFlightNo = self.returnFlightNoTextField!.text!
        let departDate = self.departDateTextField!.text!
        let returnDate = self.returnDateTextField!.text!
        var hasDepartInfo:Bool = false
        var hasReturnInfo:Bool = false
        var isCorrect:Bool = true
        if currentLocation == suvarnabhumi && passport != "" {
            if (departAirline != "" && departFlightNo != "" && departDate != ""){
                hasDepartInfo = true
            }
            if (returnAirline != "" && returnFlightNo != "" && returnDate != "") {
                hasReturnInfo = true
            }
            
            if (!hasDepartInfo && cartPickNowArray.count > 0) || (!hasReturnInfo && cartPickLaterArray.count > 0) {
                isCorrect = false
                commonViewController.alertView(self, title: gv.getConfigValue("messageFlightInfoRequiredTitle") as! String, message: gv.getConfigValue("messageFlightInfoRequiredField") as! String)
            }else{
                if hasDepartInfo && hasReturnInfo  {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let departDateWithFormat = dateFormatter.dateFromString(departDate)
                    let returnDateWithFormat = dateFormatter.dateFromString(returnDate)
                    if (departDateWithFormat!.isGreaterThanDate((returnDateWithFormat)!)){
                        isCorrect = false
                        commonViewController.alertView(self, title: gv.getConfigValue("messageDepartReturnDateTitle") as! String, message: gv.getConfigValue("messageDepartReturnDate") as! String)
                    }
                }
            }
            
        }
        
        if isCorrect {
            let flightInfoController = FlightInfoController()
            
            if hasDepartInfo {
                //Insert into FlightInfo Table
                print("before : \(self.departDateTextField!.text!)")
                
                let flightDateAsString = commonViewController.kpDateTimeDBFormat(self.departDateTextField!.text!, dateOnly: true)
                
                print("after : \(flightDateAsString)")
                var departFlightId : Int32!
                let existDepartFlight = departFlightArray.filter({$0.flii_airline == self.departAirlineTextField!.text! && $0.flii_flight_no == self.departFlightNoTextField!.text! && $0.flii_flight_date.substringWithRange(Range(start: $0.flii_flight_date.startIndex, end:  $0.flii_flight_date.startIndex.advancedBy(11))) == flightDateAsString.substringWithRange(Range(start: flightDateAsString.startIndex, end:  flightDateAsString.startIndex.advancedBy(11)))})
                
                if existDepartFlight.count > 0 {
                    print("Depart : isExist")
                    departFlightId = existDepartFlight[0].flii_id
                }else{
                    departFlightId = flightInfoController.insertFlight(custId, flii_airline: self.departAirlineTextField!.text!, flii_flight_no: self.departFlightNoTextField!.text!, flii_flight_date: flightDateAsString, flii_return_flag: gv.getConfigValue("flagNo") as! String)
                }
                orderMain.ordm_flight_departure = departFlightId
                
            }
            
            if hasReturnInfo {
                //Insert into FlightInfo Table
                let flightDateAsString = commonViewController.kpDateTimeDBFormat(self.returnDateTextField!.text!, dateOnly: true)
                
                var returnFlightId : Int32!
                let existReturnFlight = returnFlightArray.filter({$0.flii_airline == self.returnAirlineTextField!.text! && $0.flii_flight_no == self.returnFlightNoTextField!.text! && $0.flii_flight_date.substringWithRange(Range(start: $0.flii_flight_date.startIndex, end:  $0.flii_flight_date.startIndex.advancedBy(11))) == flightDateAsString.substringWithRange(Range(start: flightDateAsString.startIndex, end:  flightDateAsString.startIndex.advancedBy(11)))})
                if existReturnFlight.count > 0 {
                    print("Return : isExist")
                    returnFlightId = existReturnFlight[0].flii_id
                }else{
                    returnFlightId = flightInfoController.insertFlight(custId, flii_airline: self.returnAirlineTextField!.text!, flii_flight_no: self.returnFlightNoTextField!.text!, flii_flight_date: flightDateAsString, flii_return_flag: gv.getConfigValue("flagYes") as! String)
                }
                orderMain.ordm_flight_arrival = returnFlightId
            }

            let insertedOrderMain = OrderMainController().insert(orderMain.ordm_ords_id, ordm_user_id: orderMain.ordm_user_id, ordm_cust_id: orderMain.ordm_cust_id, ordm_passport_no: orderMain.ordm_passport_no, ordm_total_price: orderMain.ordm_total_price, ordm_flight_departure: orderMain.ordm_flight_departure, ordm_picknow_flag: orderMain.ordm_picknow_flag, ordm_current_location: orderMain.ordm_current_location, ordm_flight_arrival: orderMain.ordm_flight_arrival, ordm_picklater_flag: orderMain.ordm_picklater_flag, ordm_pickup_location: orderMain.ordm_pickup_location, ordm_net_total_price: orderMain.ordm_net_total_price, ordm_card_discount: orderMain.ordm_card_discount, cartPickNowArray: cartPickNowArray, cartPickLaterArray: cartPickLaterArray)
            //performSegueWithIdentifier("submitOrderSegue", sender: insertedOrderMain)
             delegate?.forwardToThankyou(insertedOrderMain)
        }
        
    }
    
}
