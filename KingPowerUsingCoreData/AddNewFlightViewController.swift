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
        if cartPickNowArray.count > 0 {
            lblRequiredDepart.hidden = false
        }
        if cartPickLaterArray.count > 0 {
            lblRequiredReturn.hidden = false
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
        
        //Prepare the customer information
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Do any additional setup after loading the view.
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([cancelButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        pickerViewDepart.tag = 0
        pickerViewReturn.tag = 1
        pickerViewDepartDate.tag = 2
        pickerViewReturnDate.tag = 3
        pickerViewDepartFlight.tag = 4
        pickerViewReturnFlight.tag = 5
        
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
        
        // Set default information from FlightInfoViewController
        departAirlineTextField.text = selectedDepartAirline
        departFlightNoTextField.text = selectedDepartFlightNo
        departDateTextField.text = selectedDepartDate
        returnAirlineTextField.text = selectedReturnAirline
        returnFlightNoTextField.text = selectedReturnFlightNo
        returnDateTextField.text = selectedReturnDate
        
        if selectedDepartAirline != "" {
            var index = departAirlinePickerOption.indexOf(selectedDepartAirline)
            pickerViewDepart.selectRow(index!, inComponent: 0, animated: true)
            departFlightPickerOption = KPVariable.getFlightNoByAirline(selectedDepartAirline)
            print("departFlightPickerOption : \(departFlightPickerOption.count)")
            index = departFlightPickerOption.indexOf(selectedDepartFlightNo)
            print("index : \(index)")
            pickerViewDepartFlight.selectRow(index!, inComponent: 0, animated: true)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.dateFromString(selectedDepartDate)
            pickerViewDepartDate.setDate(date!, animated: false)
            
        }
        if selectedReturnAirline != "" {
            var index = returnAirlinePickerOption.indexOf(selectedReturnAirline)
            pickerViewReturn.selectRow(index!, inComponent: 0, animated: true)
            returnFlightPickerOption = KPVariable.getFlightNoByAirline(selectedReturnAirline)
            index = returnFlightPickerOption.indexOf(selectedReturnFlightNo)
            pickerViewReturnFlight.selectRow(index!, inComponent: 0, animated: true)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.dateFromString(selectedReturnDate)
            pickerViewReturnDate.setDate(date!, animated: false)
        }
        
        pickerViewDepartDate.addTarget(self, action: Selector("departDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        pickerViewReturnDate.addTarget(self, action: Selector("returnDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        initButtonStyle()
        
    }
    override func viewDidAppear(animated: Bool) {
        print("View Did Appear")
    }
    override func viewWillAppear(animated: Bool) {
        print("View Will Appear")
        
    }
    func initButtonStyle(){
        self.btnCancel.layer.cornerRadius = 5
        self.btnCancel.layer.borderWidth = 2.0
        self.btnCancel.layer.borderColor = UIColor.blackColor().CGColor
        self.btnDone.layer.cornerRadius = 5
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
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView.tag == 0){
            return departAirlinePickerOption[row]
            
        }else if(pickerView.tag == 1){
            return returnAirlinePickerOption[row]
            
        }else if(pickerView.tag == 4){
            return departFlightPickerOption[row]
            
        }else if(pickerView.tag == 5){
            return returnFlightPickerOption[row]
            
        }else{
            return ""
        }
        
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
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        print(dateFormatter.stringFromDate(sender.date))
        let oriDate = dateFormatter.stringFromDate(sender.date)
        let date = commonViewController.castDateFromString(oriDate, dateOnly:true)
        departDateTextField.text = commonViewController.kpDateTimeFormat(date, dateOnly:true)
    }
    
    func returnDatePickerValueChanged(sender:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        let oriDate = dateFormatter.stringFromDate(sender.date)
        let date = commonViewController.castDateFromString(oriDate, dateOnly:true)
        returnDateTextField.text = commonViewController.kpDateTimeFormat(date, dateOnly:true)
    }
    
    @IBAction func btnScanBarcodeTapped(sender: AnyObject){
        commonViewController.alertView(self, title:  gv.getConfigValue("messageScanBoardingPassTitle") as! String, message:  gv.getConfigValue("messageUnderImplementation") as! String)
        
    }
    
    @IBAction func btnCancelTapped(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnAddTapped(sender: AnyObject){
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let currentLocation = prefs.objectForKey(gv.getConfigValue("currentLocation") as! String) as! String
        let suvarnabhumi = gv.getConfigValue("locationSuvarnabhumiAirport") as! String
        let passport = orderMain.ordm_passport_no
        let departAirline = self.departAirlineTextField!.text!
        let returnAirline = self.returnAirlineTextField!.text!
        let departFlightNo = self.departFlightNoTextField!.text!
        let returnFlightNo = self.returnFlightNoTextField!.text!
        let departDate = self.departDateTextField!.text!
        let returnDate = self.returnDateTextField!.text!
        print("passport \(passport)")
        print("departAirline \(departAirline)")
        print("returnAirline \(returnAirline)")
        print("departFlightNo \(departFlightNo)")
        print("returnFlightNo \(returnFlightNo)")
        print("departDate \(departDate)")
        print("returnDate \(returnDate)")
        let bool1 = cartPickNowArray.count > 0 && departAirline != "" && departFlightNo != "" && departDate != ""
        print("pick now > 0 \(bool1)")
        let bool2 = cartPickNowArray.count == 0
        print("pick now == 0 \(bool2)")
        let bool3 = cartPickLaterArray.count > 0 && returnAirline != "" && returnFlightNo != "" && returnDate != ""
        print("pick later > 0 \(bool3)")
        let bool4 = cartPickLaterArray.count == 0
        print("pick later == 0 \(bool4)")
        
        
        if currentLocation == suvarnabhumi && passport != "" && ((cartPickNowArray.count > 0 && departAirline != "" && departFlightNo != "" && departDate != "") || cartPickNowArray.count == 0) && ((cartPickLaterArray.count > 0 && returnAirline != "" && returnFlightNo != "" && returnDate != "") || cartPickLaterArray.count == 0){
            
            var hasDepartInfo = false
            var hasReturnInfo = false
            let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
            let userId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentUserId") as! String))
            
            // OrderDetailController().getOrderDetailByOrderId(<#T##ordd_ordm_id: Int32##Int32#>)
            
            if(self.departAirlineTextField!.text != "" || self.departFlightNoTextField!.text != "" || self.departDateTextField!.text != ""){
                
                //If one of these fields has value --> Need to check required for other 2 fields
                if(self.departAirlineTextField!.text == "" || self.departFlightNoTextField!.text == "" || self.departDateTextField!.text == ""){
                    // commonViewController.alertView(self, title: gv.getConfigValue("messageFlightFailTitle") as! String, message: gv.getConfigValue("messageFlightRequiredField") as! String)
                    
                }else{
                    hasDepartInfo = true
                    if(self.returnAirlineTextField!.text != "" || self.returnFlightNoTextField!.text != "" || self.returnDateTextField!.text != ""){
                        //If one of these fields has value --> Need to check required for other 2 fields
                        if(self.returnAirlineTextField!.text == "" || self.returnFlightNoTextField!.text == "" || self.returnDateTextField!.text == ""){
                            //commonViewController.alertView(self, title: gv.getConfigValue("messageFlightFailTitle") as! String, message: gv.getConfigValue("messageReturnRequiredField") as! String)
                        }else{
                            //Validate Pass
                            hasReturnInfo = true
                        }
                        
                    }
                    
                }
                
            }
            
            let flightInfoController = FlightInfoController()
            
            if(hasDepartInfo){
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
            
            if(hasReturnInfo){
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
            /*
            // Add new Order main and detail
            let flightList:[FlightInfoModel]? = FlightInfoController().getFlightByCustomerIdOnly(custId)
            for flight in flightList! {
            
            print("\(flight.flii_id) \(flight.flii_flight_no) \(flight.flii_airline) \(flight.flii_flight_date) \(flight.flii_return_flag) \(flight.flii_create_date)")
            }
            */
            
            //        time.in
            let insertedOrderMain = OrderMainController().insert(orderMain.ordm_ords_id, ordm_user_id: orderMain.ordm_user_id, ordm_cust_id: orderMain.ordm_cust_id, ordm_passport_no: orderMain.ordm_passport_no, ordm_total_price: orderMain.ordm_total_price, ordm_flight_departure: orderMain.ordm_flight_departure, ordm_picknow_flag: orderMain.ordm_picknow_flag, ordm_current_location: orderMain.ordm_current_location, ordm_flight_arrival: orderMain.ordm_flight_arrival, ordm_picklater_flag: orderMain.ordm_picklater_flag, ordm_pickup_location: orderMain.ordm_pickup_location, ordm_net_total_price: orderMain.ordm_net_total_price, ordm_card_discount: orderMain.ordm_card_discount, cartPickNowArray: cartPickNowArray, cartPickLaterArray: cartPickLaterArray)
            //self.addOrderDetail(insertedOrderMain)
            //performSegueWithIdentifier("submitOrderSegue", sender: insertedOrderMain)
             delegate?.forwardToThankyou(insertedOrderMain)
        }else{
            commonViewController.alertView(self, title: gv.getConfigValue("messageFlightInfoRequiredTitle") as! String, message: gv.getConfigValue("messageFlightInfoRequiredField") as! String)
        }
        
    }
    
    
    
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "submitOrderSegue" {
            let navThankyouVC = segue.destinationViewController as! UINavigationController
            let thankyouVC = navThankyouVC.topViewController as! ThankyouViewController
            let insertedOrderMain = sender as! OrderMainModel
            thankyouVC.orderNo = insertedOrderMain.ordm_no
            
        }
    }*/
    
    
}
