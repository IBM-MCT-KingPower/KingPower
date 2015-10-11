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
    
    @IBOutlet weak var customerNameLabel : UILabel!
    @IBOutlet weak var memberIdLabel : UILabel!
//    @IBOutlet weak var cardIdLabel: UILabel!
    @IBOutlet weak var cardExpireDateLabel : UILabel!
    @IBOutlet weak var customerPointLabel : UILabel!
    @IBOutlet weak var customerPointExpireDateLabel : UILabel!
    
    @IBOutlet weak var departAirlineTextField: UITextField!
    @IBOutlet weak var returnAirlineTextField: UITextField!

    @IBOutlet weak var departDateTextField: UITextField!
    @IBOutlet weak var returnDateTextField: UITextField!
    
    var departAirlinePickerOption = ["ANA", "Cathay Pacific", "Emirates", "Qatar Airways", "Singapore Airlines", "Thai Airways"]
   
    var returnAirlinePickerOption = ["ANA", "Cathay Pacific", "Emirates", "Qatar Airways", "Singapore Airlines", "Thai Airways"]
    
    override func viewDidLoad() {
        print("LoginDetailViewController")
        super.viewDidLoad()
        setupNav.setupNavigationBar(self)
        
        print("Customer Model FirstName : \(self.customer.cust_first_name)")
        
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        self.customerNameLabel.text = self.customer.cust_title+" "+self.customer.cust_first_name+" "+self.customer.cust_last_name
        self.memberIdLabel.text = self.customer.cust_member_id
//        self.cardIdLabel.text = String(self.customer.cust_card_id)
        print("CARD EXPIRE DATE: \(self.customer.cust_card_exp_date)")
        self.cardExpireDateLabel.text = dateFormatter.stringFromDate(self.customer.cust_card_exp_date)
        self.customerPointLabel.text = String(self.customer.cust_point)
        self.customerPointExpireDateLabel.text = dateFormatter.stringFromDate(self.customer.cust_point_exp_date)
        
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
        
        //Check require
        
        
        //Insert Flight Information
        
        
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
