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
    @IBOutlet weak var PassportNoTextField: UITextField!
    
    let currentDate = CommonViewController().castDateFromDate(NSDate())
    var dateFormatter = NSDateFormatter()
    let yFlag = GlobalVariable().getConfigValue("flagYes") as! String
    let nFlag = GlobalVariable().getConfigValue("flagNo") as! String
    
    
    var departFlight : FlightInfoModel? = FlightInfoModel()
    var returnFlight : FlightInfoModel? = FlightInfoModel()
    
    var textFont = UIFont(name: "Century Gothic", size: 15.0)!
    var textColor = UIColor(red: 0/255, green: 110/255, blue: 204/255, alpha: 1)
    var pickerBgColor = UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha:1)
    var toolBarBgColor = UIColor(red: 204/255, green: 226/255, blue: 245/255, alpha: 0.65)
    
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
        departFlightArray = flightArray!.filter({$0.flii_return_flag == nFlag})
        returnFlightArray = flightArray!.filter({$0.flii_return_flag == yFlag})
        let countDepart = departFlightArray.count
        let countReturn = returnFlightArray.count
        
        // default selected row
        if countDepart >= 1 {
            selectedDepartAirline = departFlightArray[countDepart-1].flii_airline
            selectedDepartFlightNo = departFlightArray[countDepart-1].flii_flight_no
            selectedDepartDate = commonViewController.kpDateTimeFormat(departFlightArray[countDepart-1].flii_flight_date, dateOnly:true)
            departAirlineTextField.text = selectedDepartFlightNo + " (" + selectedDepartAirline + ") " + selectedDepartDate
            self.pickerViewDepart.selectRow(countDepart-1, inComponent: 0, animated: true)

            orderMain.ordm_flight_departure = departFlightArray[countDepart-1].flii_id
            
        }
        if countReturn >= 1 {
            selectedReturnAirline = returnFlightArray[countDepart-1].flii_airline
            selectedReturnFlightNo = returnFlightArray[countDepart-1].flii_flight_no
            selectedReturnDate = commonViewController.kpDateTimeFormat(returnFlightArray[countDepart-1].flii_flight_date, dateOnly:true)
            returnAirlineTextField.text = selectedReturnFlightNo + " (" + selectedReturnAirline + ") " + selectedReturnDate
            self.pickerViewReturn.selectRow(countReturn-1, inComponent: 0, animated: true)
            orderMain.ordm_flight_arrival = returnFlightArray[countDepart-1].flii_id
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            titleData = departFlightArray[row].flii_flight_no + " (" + departFlightArray[row].flii_airline + ") " + commonViewController.kpDateTimeFormat(departFlightArray[row].flii_flight_date, dateOnly:true)
            
        }else if(pickerView.tag == 1){
            titleData = returnFlightArray[row].flii_flight_no + " (" + returnFlightArray[row].flii_airline + ") " + commonViewController.kpDateTimeFormat(returnFlightArray[row].flii_flight_date, dateOnly : true)
        }
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:self.textFont,NSForegroundColorAttributeName:self.textColor])
        return myTitle
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("titleForRow tag : \(pickerView.tag)")
        if(pickerView.tag == 0){
            
            return departFlightArray[row].flii_flight_no + " (" + departFlightArray[row].flii_airline + ") " + commonViewController.kpDateTimeFormat(departFlightArray[row].flii_flight_date, dateOnly: true)
            
        }else if(pickerView.tag == 1){
            return returnFlightArray[row].flii_flight_no + " (" + returnFlightArray[row].flii_airline + ") " + commonViewController.kpDateTimeFormat(returnFlightArray[row].flii_flight_date, dateOnly : true)
            
        }else{
            return ""
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var selectedAirline : String = ""
        print("didSelectRow tag : \(pickerView.tag)")
        if(pickerView.tag == 0){
            selectedAirline = departFlightArray[row].flii_flight_no + " (" + departFlightArray[row].flii_airline + ") " + commonViewController.kpDateTimeFormat(departFlightArray[row].flii_flight_date, dateOnly:true)
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

    @IBAction func btnScanBarcodeTapped(sender: AnyObject){
        commonViewController.alertView(self, title:  gv.getConfigValue("messageScanBoardingPassTitle") as! String, message:  gv.getConfigValue("messageUnderImplementation") as! String)
        
    }

    @IBAction func addNewFlightTapped(sender:AnyObject){
        orderMain.ordm_passport_no = self.PassportNoTextField!.text!
        performSegueWithIdentifier("addNewFlightSegue", sender: nil)
    }
    
    @IBAction func submitOrderTapped(sender:AnyObject){
        // Add new ordermain and detail
        let orderMainController = OrderMainController()

        if self.PassportNoTextField!.text! != "" || (cartPickNowArray.count > 0 && self.departAirlineTextField!.text! == "" || (cartPickLaterArray.count > 0 && self.returnAirlineTextField!.text! == "")){
        orderMain.ordm_passport_no = self.PassportNoTextField!.text!
            
            let insertedOrderMain = orderMainController.insert(orderMain.ordm_ords_id, ordm_user_id: orderMain.ordm_user_id, ordm_cust_id: orderMain.ordm_cust_id, ordm_passport_no: orderMain.ordm_passport_no, ordm_total_price: orderMain.ordm_total_price, ordm_flight_departure: orderMain.ordm_flight_departure, ordm_picknow_flag: orderMain.ordm_picknow_flag, ordm_current_location: orderMain.ordm_current_location, ordm_flight_arrival: orderMain.ordm_flight_arrival, ordm_picklater_flag: orderMain.ordm_picklater_flag, ordm_pickup_location: orderMain.ordm_pickup_location, ordm_net_total_price: orderMain.ordm_net_total_price, ordm_card_discount: orderMain.ordm_card_discount, cartPickNowArray: cartPickNowArray, cartPickLaterArray: cartPickLaterArray)
            
            //self.addOrderDetail(insertedOrderMain)
            performSegueWithIdentifier("submitOrderSegue", sender: insertedOrderMain)
        }
        let orderlist = orderMainController.getOrderByCustomerId(1)
        for order in orderlist! {
            print("order \(order.ordm_id) \(order.ordm_no) \(order.ordm_running_no)")
        }
    }
    /*
    func addOrderDetail(insertOrderMain:OrderMainModel!){
         print("Order Main Insert \(insertOrderMain.ordm_no) id \(insertOrderMain.ordm_id)" )
        
        

    }*/
    
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
            
        }else if segue.identifier == "submitOrderSegue" {
            let insertedOrderMain = sender as! OrderMainModel
            let thankyouVC = segue.destinationViewController as! ThankyouViewController
            thankyouVC.orderNo = insertedOrderMain.ordm_no
            
        }
    }


}
