//
//  AddNewFlightViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 10/18/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class AddNewFlightViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate  {
    @IBOutlet weak var btnDone:UIButton!
    @IBOutlet weak var btnCancel:UIButton!
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
    
    var gv = GlobalVariable()
    var commonViewController = CommonViewController()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        pickerViewDepartDate.addTarget(self, action: Selector("departDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        pickerViewReturnDate.addTarget(self, action: Selector("returnDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        initButtonStyle()
    }
    func initButtonStyle(){
        self.btnCancel.layer.cornerRadius = 5
        self.btnCancel.layer.borderWidth = 2.0
        self.btnCancel.layer.borderColor = UIColor.blackColor().CGColor
        self.btnDone.layer.cornerRadius = 5
    }

    func keyboardWillShow(sender: NSNotification) {
        //        self.view.frame.origin.y -= gv.getConfigValue("keyboardHeight") as! CGFloat
        self.view.frame.origin.y -= 205
    }
    
    func keyboardWillHide(sender: NSNotification) {
        //        self.view.frame.origin.y += gv.getConfigValue("keyboardHeight") as! CGFloat
        self.view.frame.origin.y += 205
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
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        departDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func returnDatePickerValueChanged(sender:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        returnDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func btnScanBarcodeTapped(sender: AnyObject){
        commonViewController.alertView(self, title:  gv.getConfigValue("messageScanBoardingPassTitle") as! String, message:  gv.getConfigValue("messageUnderImplementation") as! String)
        
    }
    
    @IBAction func btnCancelTapped(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnAddTapped(sender: AnyObject){
        //self.dismissViewControllerAnimated(false, completion: nil)
        self.performSegueWithIdentifier("addFlightSegue", sender: nil)
        
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
