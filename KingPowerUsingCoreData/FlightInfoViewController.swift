//
//  FlightInfoViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 10/18/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
import Foundation

class FlightInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, thankyouDelegate {

    var orderMain: OrderMainModel!
    var cartPickNowArray:[CartModel] = []
    var cartPickLaterArray:[CartModel] = []
    var departFlightArray:[FlightInfoModel] = []
    var returnFlightArray:[FlightInfoModel] = []
    var gv = GlobalVariable()
    var setupNav = KPNavigationBar()
    var commonViewController = CommonViewController()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    @IBOutlet weak var lblRequiredDepart: UILabel!
    @IBOutlet weak var lblRequiredReturn: UILabel!
    @IBOutlet weak var btnDone:UIButton!
    @IBOutlet weak var departAirlineTextField: UITextField!
    @IBOutlet weak var returnAirlineTextField: UITextField!
    @IBOutlet weak var PassportNoTextField: UITextField!
    
    let currentDate = CommonViewController().castDateFromDate(NSDate())
    let yFlag = GlobalVariable().getConfigValue("flagYes") as! String
    let nFlag = GlobalVariable().getConfigValue("flagNo") as! String
    
    
    var departFlight : FlightInfoModel? = FlightInfoModel()
    var returnFlight : FlightInfoModel? = FlightInfoModel()
    
    var textFont = UIFont(name: "Century Gothic", size: 15.0)!
    var textColor = UIColor(red: 0/255, green: 110/255, blue: 204/255, alpha: 1)
    var pickerBgColor = UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha:1)
    var toolBarBgColor = UIColor(red: 204/255, green: 226/255, blue: 245/255, alpha: 0.65)
    var originY : CGFloat = 0.0
    
    let pickerViewDepart = UIPickerView()
    let pickerViewReturn = UIPickerView()
    
    var selectedDepartAirline = ""
    var selectedDepartFlightNo = ""
    var selectedDepartDate = ""
    var selectedReturnAirline = ""
    var selectedReturnFlightNo = ""
    var selectedReturnDate = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav.setupNavigationBar(self)
        self.btnDone.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        self.pickerViewDepart.tag = 0
        self.pickerViewReturn.tag = 1
        self.PassportNoTextField.tag = 2
        self.departAirlineTextField.tag = 3
        self.returnAirlineTextField.tag = 4
        
        self.PassportNoTextField.addTarget(self, action: "showhide:", forControlEvents: UIControlEvents.EditingDidBegin)
        self.departAirlineTextField.addTarget(self, action: "showhide:", forControlEvents: UIControlEvents.EditingDidBegin)
        self.departAirlineTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        self.returnAirlineTextField.addTarget(self, action: "setDefaultValue:", forControlEvents: UIControlEvents.EditingDidBegin)
        self.departAirlineTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        self.returnAirlineTextField.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        pickerViewDepart.delegate = self
        pickerViewReturn.delegate = self
        
        pickerViewDepart.backgroundColor = self.pickerBgColor
        pickerViewDepart.backgroundColor = self.pickerBgColor
        
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
        

        
        departAirlineTextField.inputView = pickerViewDepart
        departAirlineTextField.inputAccessoryView = toolBar
        departAirlineTextField.autocapitalizationType = UITextAutocapitalizationType.None
        
        returnAirlineTextField.inputView = pickerViewReturn
        returnAirlineTextField.inputAccessoryView = toolBar
        
        //pickerViewDepartDate.addTarget(self, action: Selector("departDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        //pickerViewReturnDate.addTarget(self, action: Selector("returnDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
        setupFlightList()
    }
    
    func setupFlightList(){
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        
        lblRequiredDepart.hidden = true
        lblRequiredReturn.hidden = true
        
        if cartPickNowArray.count > 0 {
            lblRequiredDepart.hidden = false
        }
        if cartPickLaterArray.count > 0 {
            lblRequiredReturn.hidden = false
        }
        for cart in cartPickNowArray {
            print("Pick now \(cart.cart_id)")
        }
        for cart in cartPickLaterArray {
            print("Pick later \(cart.cart_id)")
        }
        
        let flightArray = FlightInfoController().getFlightByCustomerId(custId)
        departFlightArray = flightArray!.filter({$0.flii_return_flag == nFlag})
        returnFlightArray = flightArray!.filter({$0.flii_return_flag == yFlag})
        let countDepart = departFlightArray.count
        let countReturn = returnFlightArray.count
        
        // default selected row
        if countDepart > 0 {
            selectedDepartAirline = departFlightArray[countDepart-1].flii_airline
            selectedDepartFlightNo = departFlightArray[countDepart-1].flii_flight_no
            selectedDepartDate = commonViewController.kpDateTimeFormat(departFlightArray[countDepart-1].flii_flight_date, dateOnly:true)
            if cartPickNowArray.count > 0 {
                departAirlineTextField.text = selectedDepartFlightNo + " (" + selectedDepartAirline + ") " + selectedDepartDate
                self.pickerViewDepart.selectRow(countDepart-1, inComponent: 0, animated: true)
                orderMain.ordm_flight_departure = departFlightArray[countDepart-1].flii_id
            }else{
                departAirlineTextField.text = ""
            }
            print("selectedDepart \(selectedDepartAirline) \(selectedDepartFlightNo) \(selectedDepartDate)")
        }
        if countReturn > 0 {
            selectedReturnAirline = returnFlightArray[countReturn-1].flii_airline
            selectedReturnFlightNo = returnFlightArray[countReturn-1].flii_flight_no
            selectedReturnDate = commonViewController.kpDateTimeFormat(returnFlightArray[countReturn-1].flii_flight_date, dateOnly:true)
            if cartPickLaterArray.count > 0 {
                returnAirlineTextField.text = selectedReturnFlightNo + " (" + selectedReturnAirline + ") " + selectedReturnDate
                self.pickerViewReturn.selectRow(countReturn-1, inComponent: 0, animated: true)
                orderMain.ordm_flight_arrival = returnFlightArray[countReturn-1].flii_id
            }else{
                returnAirlineTextField.text = ""
            }
            print("selectedReturn \(selectedReturnAirline) \(selectedReturnFlightNo) \(selectedReturnDate)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Keyboard Toggle
    func keyboardWillShow(sender: NSNotification) {
        originY = (gv.getConfigValue("keyboardHeight") as! CGFloat)*(-1)
        
        if(self.view.frame.origin.y >= originY){
            self.view.frame.origin.y -= 205
        }
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0.0
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func showhide(sender: AnyObject){
        let castSender = sender as! UITextField
        
        print("sender tag : \(castSender.tag)")
        
        if(castSender.tag == 2){
            //Do Nothing
            print("DO NOTHING")
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }else if(castSender.tag == 3){
            print("PREPARE TO SHOW HIDE KEYBOARD")
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
        }
    }
    
    // MARK: - Picker View
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView.tag == 0){
            return departFlightArray.count
        }else if(pickerView.tag == 1){
            return returnFlightArray.count
        }else{
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData = ""
        if(pickerView.tag == 0){
            titleData = departFlightArray[row].flii_flight_no + " (" + departFlightArray[row].flii_airline + ") " + commonViewController.kpDateTimeFormat(departFlightArray[row].flii_flight_date, dateOnly:true)
            
        }else if(pickerView.tag == 1){
            titleData = returnFlightArray[row].flii_flight_no + " (" + returnFlightArray[row].flii_airline + ") " + commonViewController.kpDateTimeFormat(returnFlightArray[row].flii_flight_date, dateOnly : true)
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:self.textColor])
        return myTitle
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedAirline : String = ""
        print("didSelectRow tag : \(pickerView.tag)")
        if(pickerView.tag == 0){
            selectedDepartAirline = departFlightArray[row].flii_airline
            selectedDepartFlightNo = departFlightArray[row].flii_flight_no
            selectedDepartDate = commonViewController.kpDateTimeFormat(departFlightArray[row].flii_flight_date, dateOnly:true)
            selectedAirline = selectedDepartFlightNo + " (" + selectedDepartAirline + ") " + selectedDepartDate
            departAirlineTextField.text = selectedAirline
            orderMain.ordm_flight_departure = departFlightArray[row].flii_id
            
        }else if(pickerView.tag == 1){
            selectedReturnAirline = returnFlightArray[row].flii_airline
            selectedReturnFlightNo = returnFlightArray[row].flii_flight_no
            selectedReturnDate = commonViewController.kpDateTimeFormat(returnFlightArray[row].flii_flight_date, dateOnly:true)
            selectedAirline = selectedReturnFlightNo + " (" + selectedReturnAirline + ") " + selectedReturnDate
            returnAirlineTextField.text = selectedAirline
            orderMain.ordm_flight_arrival = returnFlightArray[row].flii_id
            
        }
    }
    func setDefaultValue(sender: UITextField){
        let textFont = UIFont(name: "Century Gothic", size: 16.0)!
        if(sender.tag == 3){
            if departFlightArray.count > 0 {
                self.departAirlineTextField.text = selectedDepartFlightNo + " (" + selectedDepartAirline + ") " + selectedDepartDate
                self.departAirlineTextField.font = textFont
                self.departAirlineTextField.textColor = textColor
            }
        }else if(sender.tag == 4){
            if returnFlightArray.count > 0 {
                self.returnAirlineTextField.text = selectedReturnFlightNo + " (" + selectedReturnAirline + ") " + selectedReturnDate
                self.returnAirlineTextField.font = textFont
                self.returnAirlineTextField.textColor = textColor
            }
        }
        
    }
    // MARK: - IB Action
    @IBAction func btnScanBarcodeTapped(sender: AnyObject){
        commonViewController.alertView(self, title:  gv.getConfigValue("messageScanBoardingPassTitle") as! String, message:  gv.getConfigValue("messageUnderImplementation") as! String)
        
    }
    
    @IBAction func addNewFlightTapped(sender:AnyObject){
        orderMain.ordm_passport_no = self.PassportNoTextField!.text!
        if departAirlineTextField.text == "" {
            selectedDepartAirline = ""
            selectedDepartFlightNo = ""
            selectedDepartDate = ""
        }else if returnAirlineTextField.text == "" {
            selectedReturnAirline = ""
            selectedReturnFlightNo = ""
            selectedReturnDate = ""
        }
        performSegueWithIdentifier("addNewFlightSegue", sender: nil)
    }
    
    @IBAction func submitOrderTapped(sender:AnyObject){
        // Add new ordermain and detail
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let currentLocation = prefs.objectForKey(gv.getConfigValue("currentLocation") as! String) as! String
        let suvarnabhumi = gv.getConfigValue("locationSuvarnabhumiAirport") as! String
        let passport = self.PassportNoTextField!.text!
        let departAirline = self.departAirlineTextField!.text!
        let returnAirline = self.returnAirlineTextField!.text!
        
        if currentLocation == suvarnabhumi && passport != "" && ((cartPickNowArray.count > 0 && departAirline != "") || cartPickNowArray.count == 0) && ((cartPickLaterArray.count > 0 && returnAirline != "") || cartPickLaterArray.count == 0){
            var isCorrect:Bool = true
            if selectedDepartDate != "" && selectedReturnDate != "" {
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let departDateWithFormat = dateFormatter.dateFromString(selectedDepartDate)!
                let returnDateWithFormat = dateFormatter.dateFromString(selectedReturnDate)!
                if (departDateWithFormat.isGreaterThanDate(returnDateWithFormat)){
                    isCorrect = false
                    commonViewController.alertView(self, title: gv.getConfigValue("messageDepartReturnDateTitle") as! String, message: gv.getConfigValue("messageDepartReturnDate") as! String)
                }
            }
            if isCorrect {
                orderMain.ordm_passport_no = passport
                let insertedOrderMain = OrderMainController().insert(orderMain.ordm_ords_id, ordm_user_id: orderMain.ordm_user_id, ordm_cust_id: orderMain.ordm_cust_id, ordm_passport_no: orderMain.ordm_passport_no, ordm_total_price: orderMain.ordm_total_price, ordm_flight_departure: orderMain.ordm_flight_departure, ordm_picknow_flag: orderMain.ordm_picknow_flag, ordm_current_location: orderMain.ordm_current_location, ordm_flight_arrival: orderMain.ordm_flight_arrival, ordm_picklater_flag: orderMain.ordm_picklater_flag, ordm_pickup_location: orderMain.ordm_pickup_location, ordm_net_total_price: orderMain.ordm_net_total_price, ordm_card_discount: orderMain.ordm_card_discount, cartPickNowArray: cartPickNowArray, cartPickLaterArray: cartPickLaterArray)
                //self.addOrderDetail(insertedOrderMain)
                performSegueWithIdentifier("submitOrderSegue", sender: insertedOrderMain)
            }
        }else{
            commonViewController.alertView(self, title: gv.getConfigValue("messageFlightInfoRequiredTitle") as! String, message: gv.getConfigValue("messageFlightInfoRequiredField") as! String)
        }
    }
    
    func donePicker() {
        self.view.endEditing(true)
        
    }
    // MARK: - Navigation bar
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
    }
    func viewFlightMethod(){
        self.removeNavigateView()
        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
        CommonViewController().viewFlightMethod(self, flight: flightViewController)
    }
    func callAssistMethod(){
        self.removeNavigateView()
        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
        CommonViewController().callAssistMethod(self, call: callAssistanceViewController)
    }
    func searchMethod(){
        CommonViewController().searchMethod(self)
    }
    func viewCartMethod(){
        CommonViewController().viewCartMethod(self)
    }
    func removeNavigateView(){
        if(flightViewController != nil && !flightViewController.view.hidden)
        {
            flightViewController.view.removeFromSuperview()
        }
        if(callAssistanceViewController != nil && !callAssistanceViewController.view.hidden)
        {
            callAssistanceViewController.view.removeFromSuperview()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addNewFlightSegue" {
            let addNewFlightVC  = segue.destinationViewController as! AddNewFlightViewController
            addNewFlightVC.orderMain = orderMain
            addNewFlightVC.cartPickNowArray = cartPickNowArray
            addNewFlightVC.cartPickLaterArray = cartPickLaterArray
            addNewFlightVC.selectedDepartAirline = selectedDepartAirline
            addNewFlightVC.selectedDepartFlightNo = selectedDepartFlightNo
            addNewFlightVC.selectedDepartDate = selectedDepartDate
            addNewFlightVC.selectedReturnAirline = selectedReturnAirline
            addNewFlightVC.selectedReturnFlightNo = selectedReturnFlightNo
            addNewFlightVC.selectedReturnDate = selectedReturnDate
            addNewFlightVC.departFlightArray = departFlightArray
            addNewFlightVC.returnFlightArray = returnFlightArray
            addNewFlightVC.delegate = self
            
        }else if segue.identifier == "submitOrderSegue" {
            let insertedOrderMain = sender as! OrderMainModel
            let thankyouVC = segue.destinationViewController as! ThankyouViewController
            thankyouVC.orderNo = insertedOrderMain.ordm_no
            
        }
    }
    
    // MARK: - thankyou delegate
    func forwardToThankyou(insertedOrderMain: OrderMainModel){
        print("dismissViewControllerAnimated")
        self.dismissViewControllerAnimated(false, completion: nil)
        performSegueWithIdentifier("submitOrderSegue", sender: insertedOrderMain)
    }
    
}
