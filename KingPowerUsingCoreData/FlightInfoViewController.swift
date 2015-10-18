//
//  FlightInfoViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 10/18/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class FlightInfoViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
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
    
    @IBOutlet weak var btnDone:UIButton!
    @IBOutlet weak var departAirlineTextField: UITextField!
    @IBOutlet weak var returnAirlineTextField: UITextField!
    
    var dateFormatter = NSDateFormatter()
    
    //var departAirlinePickerOption : [String] = KPVariable.airlinePickerOption
    //var returnAirlinePickerOption : [String] = KPVariable.airlinePickerOption
    
    
    var departFlight : FlightInfoModel? = FlightInfoModel()
    var returnFlight : FlightInfoModel? = FlightInfoModel()
    
    var textFont = UIFont(name: "Century Gothic", size: 15.0)!
    var textColor = UIColor(red: 0/255, green: 110/255, blue: 204/255, alpha: 1)
    var pickerBgColor = UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha:1)
    var toolBarBgColor = UIColor(red: 204/255, green: 226/255, blue: 245/255, alpha: 0.65)
    
    let pickerViewDepart = UIPickerView()
    let pickerViewReturn = UIPickerView()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav.setupNavigationBar(self)
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil);
        
        //Prepare the customer information
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
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
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        
        toolBar.setItems([cancelButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        pickerViewDepart.tag = 0
        pickerViewReturn.tag = 1
        
        departAirlineTextField.inputView = pickerViewDepart
        departAirlineTextField.inputAccessoryView = toolBar
        departAirlineTextField.autocapitalizationType = UITextAutocapitalizationType.None
        
        returnAirlineTextField.inputView = pickerViewReturn
        returnAirlineTextField.inputAccessoryView = toolBar
        
        //pickerViewDepartDate.addTarget(self, action: Selector("departDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        //pickerViewReturnDate.addTarget(self, action: Selector("returnDatePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
        initButtonStyle()
    }
    
    func initButtonStyle(){
        self.btnDone.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(animated: Bool) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        
        let flightArray = FlightInfoController().getFlightByCustomerId(custId)
        departFlightArray = flightArray!.filter({$0.flii_return_flag == "N"})
        returnFlightArray = flightArray!.filter({$0.flii_return_flag == "Y"})
        let countDepart = departFlightArray.count
        let countReturn = returnFlightArray.count
        
        if countDepart == 1 {
            departAirlineTextField.text = departFlightArray[0].flii_flight_no + "(" + departFlightArray[0].flii_airline + ") " + departFlightArray[0].flii_flight_date
        }else if countDepart > 1 {
            departAirlineTextField.text = departFlightArray[countDepart-1].flii_flight_no + " (" + departFlightArray[countDepart-1].flii_airline + ") " + departFlightArray[countDepart-1].flii_flight_date
            self.pickerViewDepart.selectRow(countDepart-1, inComponent: 0, animated: true)
            
        }
        if countReturn == 1 {
            returnAirlineTextField.text = returnFlightArray[0].flii_flight_no + "(" + returnFlightArray[0].flii_airline + ") " + returnFlightArray[0].flii_flight_date
        }else if countReturn > 1 {
            returnAirlineTextField.text = returnFlightArray[countDepart-1].flii_flight_no + " (" + returnFlightArray[countDepart-1].flii_airline + ") " + returnFlightArray[countDepart-1].flii_flight_date
            self.pickerViewReturn.selectRow(countDepart-1, inComponent: 0, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnScanBarcodeTapped(sender: AnyObject){
        commonViewController.alertView(self, title:  gv.getConfigValue("messageScanBoardingPassTitle") as! String, message:  gv.getConfigValue("messageUnderImplementation") as! String)
        
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
        print("attributedTitleForRow tag : \(pickerView.tag)")
        var titleData = ""
        if(pickerView.tag == 0){
            titleData = departFlightArray[row].flii_flight_no + " (" + departFlightArray[row].flii_airline + ") " + departFlightArray[row].flii_flight_date
            
        }else if(pickerView.tag == 1){
            titleData = returnFlightArray[row].flii_flight_no + " (" + returnFlightArray[row].flii_airline + ") " + returnFlightArray[row].flii_flight_date
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:self.textColor])
        return myTitle
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("titleForRow tag : \(pickerView.tag)")
        if(pickerView.tag == 0){
            
            return departFlightArray[row].flii_flight_no + " (" + departFlightArray[row].flii_airline + ") " + departFlightArray[row].flii_flight_date
            
        }else if(pickerView.tag == 1){
            return returnFlightArray[row].flii_flight_no + " (" + returnFlightArray[row].flii_airline + ") " + returnFlightArray[row].flii_flight_date
            
        }else{
            return ""
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedAirline : String = ""
        print("didSelectRow tag : \(pickerView.tag)")
        if(pickerView.tag == 0){
            selectedAirline = departFlightArray[row].flii_flight_no + " (" + departFlightArray[row].flii_airline + ") " + departFlightArray[row].flii_flight_date
            departAirlineTextField.text = selectedAirline
            //departFlightPickerOption = KPVariable.getFlightNoByAirline(selectedAirline)
            
        }else if(pickerView.tag == 1){
            selectedAirline = returnFlightArray[row].flii_flight_no + " (" + returnFlightArray[row].flii_airline + ") " + returnFlightArray[row].flii_flight_date
            returnAirlineTextField.text = selectedAirline
            //returnFlightPickerOption = KPVariable.getFlightNoByAirline(selectedAirline)
            
        }
    }
    
    func donePicker() {
        self.view.endEditing(true)
        
    }
    
    func BackMethod(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    func viewFlightMethod(){
        self.removeNavigateView()
        CommonViewController().viewFlightMethod(self)
    }
    func callAssistMethod(){
        self.removeNavigateView()
        CommonViewController().callAssistMethod(self)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
