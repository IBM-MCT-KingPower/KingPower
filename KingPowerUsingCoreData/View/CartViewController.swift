//
//  CartViewController.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/5/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit
import Foundation


class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var constat = Constants()
    var customer:CustomerModel = CustomerModel()
    var cartPickNowArray:[CartModel] = []
    var cartPickLaterArray:[CartModel] = []
    var grandTotal:NSDecimalNumber = 0.0
    var percentDiscount:NSDecimalNumber = 0.0
    var discount:NSDecimalNumber = 0.0
    var netTotal:NSDecimalNumber = 0.0
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var allPopupView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var btnContinueShopping: UIButton!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var btnContinueShoppingPopup: UIButton!
    @IBOutlet weak var btnCheckoutPopup: UIButton!
    @IBOutlet weak var imgPromotion: UIImageView!
    @IBOutlet weak var txtvPromotionDetail: UITextView!
    @IBOutlet weak var lblPercentDiscount:UILabel!
    @IBOutlet weak var lblDiscount:UILabel!
    @IBOutlet weak var lblNetTotal:UILabel!
    var setupNav = KPNavigationBar()
    var btnRelatedProduct = UIButton()
    var btnRecommendedProduct = UIButton()
    var isRelated = true
    
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    
    var cartController = CartController()
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    var isCalledFromMenu = false
    
     let detailTransitioningDelegate: PresentationManager = PresentationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialValue()
        
        //self.title  = self.constat.customLocalizedString("cartTitle", comment: "this is comment")as String
        self.cartTableView.backgroundColor = UIColor.whiteColor()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let custId: Int32 = Int32(prefs.integerForKey(gv.getConfigValue("currentCustomerId") as! String))
        customer = CustomerController().getCustomerByCustId(custId)!
        percentDiscount = NSDecimalNumber(int : customer.cust_card_discount)
        self.lblPercentDiscount.text = "\(percentDiscount) %"
        cartPickNowArray = CartController().getCartPickTypeByCustomerId(custId,cart_pickup_now: gv.getConfigValue("flagYes") as! String)!
        cartPickLaterArray = CartController().getCartPickTypeByCustomerId(custId, cart_pickup_now: gv.getConfigValue("flagNo") as! String)!

        // Do any additional setup after loading the view.
        self.cartTableView.delegate = self
//        self.setupNavigationBar()
        
        self.setupNav.isCalledFromMenu = isCalledFromMenu
        self.setupNav.setupNavigationBar(self)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.customPromotionPopup()
        self.cartTableView.reloadData()
        
        print("Now List : \(cartPickNowArray.count)")
        print("Later List : \(cartPickLaterArray.count)")
        
    }
    
    override func viewDidAppear(animated: Bool) {

        self.reCalculate()
    }
    
    func initialValue(){
        self.allPopupView.hidden = true
        self.popupView.hidden = true
        self.btnContinueShopping.layer.cornerRadius = 5
        self.btnContinueShopping.layer.borderWidth = 2.0
        self.btnContinueShopping.layer.borderColor = UIColor.blackColor().CGColor
        self.btnCheckout.layer.cornerRadius = 5
        self.btnContinueShoppingPopup.layer.cornerRadius = 5
        self.btnContinueShoppingPopup.layer.borderWidth = 2.0
        self.btnContinueShoppingPopup.layer.borderColor = UIColor.blackColor().CGColor
        self.btnCheckoutPopup.layer.cornerRadius = 5
        self.cartTableView.registerNib(UINib(nibName: "NoItemFoundCell", bundle: nil), forCellReuseIdentifier: "noItemFoundCell")
    }
    
    
    
    func customPromotionPopup(){
        self.popupView.layer.cornerRadius = 20
        self.popupView.alpha = 0.0
        let lineView = UIView(frame: CGRectMake(0, 250, self.popupView.bounds.size.width, 1))
        lineView.backgroundColor = UIColor.lightGrayColor()
        self.popupView.addSubview(lineView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - TableView Datasource and Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == cartTableView {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // code
        if indexPath.section == 0 {
            if self.cartPickNowArray.count != 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("cartTableViewCell", forIndexPath: indexPath) as! CartTableViewCell
                cell.imgGoods.image = UIImage(named: self.cartPickNowArray[indexPath.row].cart_prod.prod_imageArray[0].proi_image_path)
                cell.lblGoods.text = self.cartPickNowArray[indexPath.row].cart_prod.prod_name
                cell.lblGoodsDetail.text = self.cartPickNowArray[indexPath.row].cart_prod.prod_description
                cell.lblGoodsDetail.font = UIFont(name: "Century Gothic", size: 12)
                let quantity = NSDecimalNumber(int: self.cartPickNowArray[indexPath.row].cart_quantity)
                cell.txtfQuantity.text = String(quantity)
                let pricePerProd = NSDecimalNumber(double: self.cartPickNowArray[indexPath.row].cart_prod.prod_price)
                let totalPrice = quantity.decimalNumberByMultiplyingBy(NSDecimalNumber(double: self.cartPickNowArray[indexPath.row].cart_prod.prod_price))
                cell.lblUnitPrice.text = pricePerProd.currency
                cell.lblTotalPrice.text = totalPrice.currency
                cell.swtPickupType.on = true
                /*
                self.grandTotal = self.grandTotal.decimalNumberByAdding(totalPrice)
                if indexPath.row == self.cartPickNowArray.count - 1 && self.cartPickLaterArray.count == 0 {
                    self.lblGrandTotal.text = self.grandTotal.currency
                }*/
                cell.stpQuantity.value = Double(cell.txtfQuantity.text!)!
                cell.swtPickupType.addTarget(self, action: Selector("checkSwitchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
                cell.stpQuantity.addTarget(self, action: Selector("checkQuantityChanged:"), forControlEvents: UIControlEvents.ValueChanged)
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("noItemFoundCell", forIndexPath: indexPath) as! NoItemFoundCell
                return cell
                
            }
        }else{
            if self.cartPickLaterArray.count != 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("cartTableViewCell", forIndexPath: indexPath) as! CartTableViewCell
                cell.imgGoods.image = UIImage(named: self.cartPickLaterArray[indexPath.row].cart_prod.prod_imageArray[0].proi_image_path)
                cell.lblGoods.text = self.cartPickLaterArray[indexPath.row].cart_prod.prod_name
                cell.lblGoodsDetail.text = self.cartPickLaterArray[indexPath.row].cart_prod.prod_description
                cell.lblGoodsDetail.font = UIFont(name: "Century Gothic", size: 12)
                let quantity = NSDecimalNumber(int: self.cartPickLaterArray[indexPath.row].cart_quantity)
                cell.txtfQuantity.text = String(quantity)
                let pricePerProd = NSDecimalNumber(double: self.cartPickLaterArray[indexPath.row].cart_prod.prod_price)
                let totalPrice = quantity.decimalNumberByMultiplyingBy(NSDecimalNumber(double: self.cartPickLaterArray[indexPath.row].cart_prod.prod_price))
                cell.lblUnitPrice.text = pricePerProd.currency
                cell.lblTotalPrice.text = totalPrice.currency
                cell.swtPickupType.on = false
                /*
                self.grandTotal = self.grandTotal.decimalNumberByAdding(totalPrice)
                if indexPath.row == self.cartPickLaterArray.count - 1 {
                    self.lblGrandTotal.text = self.grandTotal.currency
                }*/
                cell.stpQuantity.value = Double(cell.txtfQuantity.text!)!
                cell.swtPickupType.addTarget(self, action: Selector("checkSwitchChanged:"), forControlEvents: UIControlEvents.ValueChanged)
                cell.stpQuantity.addTarget(self, action: Selector("checkQuantityChanged:"), forControlEvents: UIControlEvents.ValueChanged)
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("noItemFoundCell", forIndexPath: indexPath) as! NoItemFoundCell
                return cell
            }

        }
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            if self.cartPickNowArray.count == 0 {
                return 1
            }else{
                return self.cartPickNowArray.count
            }
            
        case 1 :
            if self.cartPickLaterArray.count == 0 {
                return 1
            }else{
                return self.cartPickLaterArray.count
            }
        default :
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            switch section {
            case 0 :
                return "Pick Now"
            case 1 :
                return "Pick Later"
            default :
                return "Pick Now"
            }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let hView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 30))
            hView.backgroundColor = UIColor(hexString: String(gv.getConfigValue("sectionHeaderColor")))
            let hLabel = UILabel(frame: CGRectMake(10, 0, tableView.frame.width, 30))
            hLabel.font = UIFont(name: "Century Gothic", size: 18)
            hLabel.textColor = UIColor(hexString: String(gv.getConfigValue("whiteColor")))
            switch section {
            case 0 :
                hLabel.text =  "Pick Now"
            case 1 :
                hLabel.text =   "Pick Later"
            default :
                hLabel.text =   "Pick Now"
            }
            hView.addSubview(hLabel)
            return hView
        
    }

    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if (indexPath.section == 0 && self.cartPickNowArray.count == 0) || (indexPath.section == 1 && self.cartPickLaterArray.count == 0) {
            return false
        }
        return true

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            switch indexPath.section {
            case 0 :
               // oldPrice = NSDecimalNumber(double: self.cartPickNowArray[indexPath.row].cart_prod.prod_price)
               // oldQuantity = NSDecimalNumber(int: self.cartPickNowArray[indexPath.row].cart_quantity)
                //self.cartTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                let cart = self.cartPickNowArray[indexPath.row]
                CartController().deleteByCartId(cart.cart_id)
                self.cartPickNowArray.removeAtIndex(indexPath.row)
                self.setupNav.addAmountInCart(-cart.cart_quantity.hashValue)
                self.cartTableView.reloadData()
            case 1 :
               // oldPrice = NSDecimalNumber(double: self.cartPickLaterArray[indexPath.row].cart_prod.prod_price)
               // oldQuantity = NSDecimalNumber(int: self.cartPickLaterArray[indexPath.row].cart_quantity)
                //self.cartTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                let cart = self.cartPickLaterArray[indexPath.row]
                CartController().deleteByCartId(cart.cart_id)
                self.cartPickLaterArray.removeAtIndex(indexPath.row)
                self.setupNav.addAmountInCart(-cart.cart_quantity.hashValue)
                self.cartTableView.reloadData()
            default :
                print("default")
            }
        
            self.reCalculate()
        }
    }
    // MARK: - Action
    @IBAction func checkOutClicked(sender: AnyObject) {
        if cartPickNowArray.count == 0 && cartPickLaterArray.count == 0 {
            CommonViewController().alertView(self, title: gv.getConfigValue("messageCartTitle") as! String, message: gv.getConfigValue("messageCartRequireProduct") as! String)
        }else{
            let promotionList = PromotionController().getPromotionByTypeAndEffective("UPSALE", includeExpire: false)
            print("promotion list \(promotionList.count)")
            let promotion = promotionList[0]
            let promotionUpsaleArray = PromotionUpSaleLevelController().getPromotionUpSaleLevelByPromotionId(promotion.prom_id)
            print("promotion upsale list \(promotionUpsaleArray!.count)")
            let matchPromotion = promotionUpsaleArray!.filter({
                $0.prup_max_amount > netTotal.doubleValue
            })
            if matchPromotion.count != 0 {
                let promotionUpsale = matchPromotion[0]
                
                self.txtvPromotionDetail.text = "Special offers \(promotionUpsale.prup_max_content) when puschase more than \(NSDecimalNumber(double:promotionUpsale.prup_max_amount).currency) baht"
                self.allPopupView.hidden = false
                self.popupView.hidden = false
                UIView.animateWithDuration(0.5, animations: {
                    self.popupView.alpha = 1.0
                })
            }else{
                performSegueWithIdentifier("checkoutSegue", sender: nil)
            }
        }
        
    }
    
    
   
    @IBAction func continueShoppingClicked(sender: AnyObject) {
        self.allPopupView.hidden = true
    }
    
    @IBAction func checkoutWithPopupMethod(sender: AnyObject) {
    }
    
    
    @IBAction func checkSwitchChanged(sender: AnyObject) {
        let switch1 = sender as! UISwitch
        
        let clickedCell  = switch1.superview?.superview as! UITableViewCell
        let indexPath = self.cartTableView.indexPathForCell(clickedCell) as NSIndexPath?
        if switch1.on == true {
            let curGoods = self.cartPickLaterArray[indexPath!.row]
            self.cartPickLaterArray.removeAtIndex(indexPath!.row)
            self.cartPickNowArray.append(curGoods)
        }else{
            let curGoods = self.cartPickNowArray[indexPath!.row]
            self.cartPickNowArray.removeAtIndex(indexPath!.row)
            self.cartPickLaterArray.append(curGoods)
        }
        self.cartTableView.reloadData()
    }
    
    @IBAction func checkQuantityChanged(sender: AnyObject) {
        
        let stepper = sender as! UIStepper
        let quantity = NSDecimalNumber(double : stepper.value)
        let pricePerItem:NSDecimalNumber!
        
        let clickedCell  = stepper.superview?.superview as! CartTableViewCell
        let indexPath = self.cartTableView.indexPathForCell(clickedCell) as NSIndexPath?
        if indexPath!.section == 0 {
            self.cartPickNowArray[indexPath!.row].cart_quantity = Int32(stepper.value)
            pricePerItem = NSDecimalNumber(double: self.cartPickNowArray[indexPath!.row].cart_prod.prod_price)
        }else{
            self.cartPickLaterArray[indexPath!.row].cart_quantity = Int32(stepper.value)
            pricePerItem = NSDecimalNumber(double: self.cartPickLaterArray[indexPath!.row].cart_prod.prod_price)
        }
        clickedCell.txtfQuantity.text = String(Int(stepper.value))
        let newTotalPrice = quantity.decimalNumberByMultiplyingBy(pricePerItem)
        clickedCell.lblTotalPrice.text = newTotalPrice.currency
        //self.grandTotal = self.grandTotal.decimalNumberBySubtracting(oldTotalPrice).decimalNumberByAdding(newTotalPrice)
        //self.lblGrandTotal.text = self.grandTotal.currency
        self.reCalculate()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.allPopupView.hidden = true
        self.popupView.hidden = true
        if segue.identifier == "checkoutSegue" {
            let viewController:CheckoutViewController = segue.destinationViewController as! CheckoutViewController
            viewController.cartPickNowArray = cartPickNowArray
            viewController.cartPickLaterArray = cartPickLaterArray
            viewController.discount = discount
            viewController.percentDiscount = percentDiscount
            print("NETTOTAL1 : \(netTotal)")
            viewController.netTotal = netTotal
            print("GRANDTOTAL1 : \(grandTotal)")
            viewController.grandTotal = grandTotal
        }else if segue.identifier == "currencyConvertorSegue"{
            let viewController:CurrencyConvertorPopupViewController = segue.destinationViewController as! CurrencyConvertorPopupViewController
            detailTransitioningDelegate.height = 500
            detailTransitioningDelegate.width = 600
            viewController.transitioningDelegate = detailTransitioningDelegate
            viewController.modalPresentationStyle = .Custom
            viewController.netTotal = self.netTotal
            
        }
    }
    
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
    
    func reCalculate(){
        self.grandTotal = 0
        for cart in cartPickNowArray {
            let quantity = NSDecimalNumber(int: cart.cart_quantity)
            //let pricePerProd = NSDecimalNumber(double: cart.cart_prod.prod_price)
            let totalPrice = quantity.decimalNumberByMultiplyingBy(NSDecimalNumber(double: cart.cart_prod.prod_price))
            self.grandTotal = self.grandTotal.decimalNumberByAdding(totalPrice)
        }
        for cart in cartPickLaterArray {
            let quantity = NSDecimalNumber(int: cart.cart_quantity)
            //let pricePerProd = NSDecimalNumber(double: cart.cart_prod.prod_price)
            let totalPrice = quantity.decimalNumberByMultiplyingBy(NSDecimalNumber(double: cart.cart_prod.prod_price))
            self.grandTotal = self.grandTotal.decimalNumberByAdding(totalPrice)
        }
        self.lblGrandTotal.text = self.grandTotal.currency
        discount = grandTotal.decimalNumberByMultiplyingBy(percentDiscount).decimalNumberByDividingBy(100)
        self.lblDiscount.text = "-\(discount.currency)"
        //self.lblPercentDiscount.text = "-\(discount)"
        netTotal = grandTotal.decimalNumberBySubtracting(discount)
        self.lblNetTotal.text = "\(netTotal.currency)"
    }
    
    override func viewWillDisappear(animated: Bool) {
        let yFlag = gv.getConfigValue("flagYes") as! String
        let nFlag = gv.getConfigValue("flagNo") as! String
        let currentDate = CommonViewController().castDateFromDate(NSDate())
        var totalAmount:Int32 = 0
        for cart in cartPickNowArray {
            totalAmount += cart.cart_quantity
            cartController.updateById(cart.cart_id, cart_quantity: cart.cart_quantity, cart_pickup_now: yFlag)
        }
        for cart in cartPickLaterArray {
            totalAmount += cart.cart_quantity
            cartController.updateById(cart.cart_id, cart_quantity: cart.cart_quantity, cart_pickup_now: nFlag)
        }
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        prefs.setInteger(totalAmount.hashValue, forKey: gv.getConfigValue("currentAmountInCart") as! String)
        prefs.synchronize()
        
    }
    
}
