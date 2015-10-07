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
        print("Sing Out Method")
    }
    
    func BackMethod(){
        print("Back Method")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
