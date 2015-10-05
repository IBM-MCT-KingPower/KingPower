//
//  ProductDetailViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/23/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageLabel: UIImageView!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var pickNow: UISwitch!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var productDescript: UITextView!
    var productDetail:Products = Products()
    
    @IBOutlet weak var productButton1: UIButton!
    @IBOutlet weak var productButton2: UIButton!
    @IBOutlet weak var productButton3: UIButton!
    @IBOutlet weak var productButton4: UIButton!
    @IBOutlet weak var itemControl: UIStepper!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    var productArray:[Products] = []
    var database:FMDatabase!
    
    @IBOutlet weak var relatedProductTableView: UITableView!
    @IBOutlet weak var tabView: UIView!
    var btnRelatedProduct = UIButton()
    var btnRecommendedProduct = UIButton()
    var isRelated = true
    
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.openDB()
        self.query()
        self.initialTabView()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.setupNavigationBar()
        self.productIdLabel.text = self.productDetail.product_id
        self.productNameLabel.text = self.productDetail.product_name
        self.productImageLabel.image = UIImage(named: self.productDetail.product_image1)

        self.productButton1.setImage(UIImage(named: self.productDetail.product_image1), forState: UIControlState.Normal)
        self.productButton2.setImage(UIImage(named: self.productDetail.product_image2), forState: UIControlState.Normal)
        self.productButton3.setImage(UIImage(named: self.productDetail.product_image3), forState: UIControlState.Normal)
        self.productButton4.setImage(UIImage(named: self.productDetail.product_image4), forState: UIControlState.Normal)
        
        /*
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.currencyCode = "THB"
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.negativeFormat = "-¤#,##0.00"
        self.productPrice.text = currencyFormatter.stringFromNumber(self.productDetail.product_price)
*/
        self.productPrice.text = NSNumber(double: self.productDetail.product_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
        self.productDescript.text = self.productDetail.product_description
        self.productDescript.font = UIFont(name: "Century Gothic", size: 15)
        self.pickNow.on = self.productDetail.pickup_flag
        self.ratingControl.rating = Int(self.productDetail.product_rating)
    }
    
    func openDB(){
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsFolder.stringByAppendingPathComponent("kpdata")
        let fileManager = NSFileManager()
        if (!fileManager.fileExistsAtPath(path)){
            
            let dbFilePath = NSBundle.mainBundle().pathForResource("kpdata", ofType: "db")
            print(dbFilePath, terminator: "")
            do {
                try fileManager.copyItemAtPath(dbFilePath!, toPath: path)
            } catch _ {
            }
            
        }
        self.database = FMDatabase(path: path)
        
        if !self.database.open() {
            print("Unable to open database", terminator: "")
            return
        }else{
            print("database is opened", terminator: "")
        }
        
        
    }
    
    func query(){
        self.productArray.removeAll(keepCapacity: true)
        if let rs = database.executeQuery("SELECT product_id, product_name, product_description, product_price,product_image1,product_image2,product_image3,product_image4,product_image5,product_rating FROM kp_product where product_id not in ('"+self.productDetail.product_id+"');", withArgumentsInArray: nil) {
            
            while rs.next(){
                let prolist = Products()
                prolist.product_id = rs.stringForColumn("product_id")
                prolist.product_name = rs.stringForColumn("product_name")
                prolist.product_description = rs.stringForColumn("product_description")
                prolist.product_price = rs.doubleForColumn("product_price")
                prolist.product_image1 = rs.stringForColumn("product_image1")
                prolist.product_image2 = rs.stringForColumn("product_image2")
                prolist.product_image3 = rs.stringForColumn("product_image3")
                prolist.product_image4 = rs.stringForColumn("product_image4")
                prolist.product_image5 = rs.stringForColumn("product_image5")
                prolist.product_rating = rs.intForColumn("product_rating")
                self.productArray.append(prolist)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImage1(sender: AnyObject) {
        productImageLabel.image = UIImage(named: productDetail.product_image1)
    }
    
    @IBAction func selectImage2(sender: AnyObject) {
        productImageLabel.image = UIImage(named: productDetail.product_image2)
    }
    
    @IBAction func selectImage3(sender: AnyObject) {
        productImageLabel.image = UIImage(named: productDetail.product_image3)
    }
    
    @IBAction func selectImage4(sender: AnyObject) {
        productImageLabel.image = UIImage(named: productDetail.product_image4)
    }

    
    @IBAction func itemChange(sender: AnyObject) {
        self.amount.text = Int(self.itemControl.value).description
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("relatedCell",
            forIndexPath: indexPath) as! relatedCollectionViewCell
        cell.relateButton.setImage(UIImage(named: self.productArray[indexPath.row].product_image1), forState: UIControlState.Normal)
        cell.productRelate = self.productArray[indexPath.row]
        cell.mainView = self
        return cell
    }
    
    @IBAction func selectImage(sender: AnyObject) {
        
    }
    
    func initialTabView(){
        let imgRelatedProduct = UIImage(named: "tab-Related1.png")
        btnRelatedProduct.frame = CGRectMake(0, 0, (imgRelatedProduct?.size.width)!/2, (imgRelatedProduct?.size.height)!/2)
        btnRelatedProduct.setImage(imgRelatedProduct, forState: .Normal)
        btnRelatedProduct.addTarget(self, action: "tappedRelated:", forControlEvents: UIControlEvents.TouchUpInside)
        self.tabView.addSubview(btnRelatedProduct)
        
        let imgRecommendedProduct = UIImage(named: "tab-Recommend0.png")
        
        btnRecommendedProduct.frame = CGRectMake((imgRelatedProduct?.size.width)!/2, 0, (imgRecommendedProduct?.size.width)!/2, (imgRecommendedProduct?.size.height)!/2)
        btnRecommendedProduct.setImage(imgRecommendedProduct, forState: .Normal)
        btnRecommendedProduct.addTarget(self, action: "tappedRecommended:", forControlEvents: UIControlEvents.TouchUpInside)
        self.tabView.addSubview(btnRecommendedProduct)
        
    }
    
    func tappedRelated(sender:UIButton!){
        print("tab related product")
        btnRelatedProduct.setImage(UIImage(named: "tab-Related1.png"), forState: UIControlState.Normal)
        btnRecommendedProduct.setImage(UIImage(named: "tab-Recommend0.png"), forState: UIControlState.Normal)
        self.isRelated = true
        self.relatedProductTableView.reloadData()
    }
    
    func tappedRecommended(sender:UIButton!){
        print("tab recommended product")
        btnRelatedProduct.setImage(UIImage(named: "tab-Related0.png"), forState: UIControlState.Normal)
        btnRecommendedProduct.setImage(UIImage(named: "tab-Recommend1.png"), forState: UIControlState.Normal)
        self.isRelated = false
        self.relatedProductTableView.reloadData()
    }

    // MARK: - TableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CatagoryTableViewCell
        if isRelated {
            cell.clvRelated.hidden = false
            cell.clvRecommended.hidden = true
        } else {
            cell.clvRelated.hidden = true
            cell.clvRecommended.hidden = false
        }
        return cell

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupNavigationBar(){
        print("navigation frame: \(navigationController!.navigationBar.frame.width) x \(navigationController!.navigationBar.frame.height)")
        //Remove the shadow image altogether
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        //Container Layout
        navBar.frame=CGRectMake(0, 0, navigationController!.navigationBar.frame.width, navigationController!.navigationBar.frame.height)
        navBar.barTintColor = UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))//UIColor(hexString: "000000")
        self.view.addSubview(navBar)
        self.view.sendSubviewToBack(navBar)
        
        //Navigation Bar
        self.navigationController!.navigationBar.barTintColor =  UIColor(hexString: String(gv.getConfigValue("navigationBarColor")))
        
        let imageTitleItem : UIImage = UIImage(named: gv.getConfigValue("navigationBarImgName") as! String)!
        let imageTitleView = UIImageView(frame: CGRect(
            x: gv.getConfigValue("navigationBarImgPositionX") as! Int,
            y: gv.getConfigValue("navigationBarImgPositionY") as! Int,
            width: gv.getConfigValue("navigationBarImgWidth") as! Int,
            height: gv.getConfigValue("navigationBarImgHeight") as! Int))
        
        imageTitleView.contentMode = .ScaleAspectFit
        imageTitleView.image = imageTitleItem
        self.navigationItem.titleView = imageTitleView
        
        self.addRightNavItemOnView()
        self.addLeftNavItemOnView()
        
    }
    func addLeftNavItemOnView()
    {
        //Back
        let buttonMenu = UIButton(type: UIButtonType.Custom) as UIButton
        buttonMenu.frame = CGRectMake(
            gv.getConfigValue("navigationItemBackImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemBackImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemBackImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemBackImgHeight") as! CGFloat)
        
        buttonMenu.setImage(UIImage(named: gv.getConfigValue("navigationItemBackImgName") as! String), forState: UIControlState.Normal)
        buttonMenu.addTarget(self, action: "backToPreviousPage:", forControlEvents: UIControlEvents.TouchUpInside) //use thiss
        let leftBarButtonItemMenu = UIBarButtonItem(customView: buttonMenu)
        
        //Flight
        let buttonFlight = UIButton(type: UIButtonType.Custom) as UIButton
        buttonFlight.frame = CGRectMake(
            gv.getConfigValue("navigationItemAirplainImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemAirplainImgHeight") as! CGFloat)
        buttonFlight.setImage(UIImage(named: gv.getConfigValue("navigationItemAirplainImgName") as! String), forState: UIControlState.Normal)
        buttonFlight.addTarget(self, action: "navItemFlightClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let leftBarButtonItemFilght = UIBarButtonItem(customView: buttonFlight)
        
        
        // add multiple right bar button items
        self.navigationItem.setLeftBarButtonItems([leftBarButtonItemMenu,leftBarButtonItemFilght], animated: true)
        // uncomment to add single right bar button item
        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
        
    }
    func addRightNavItemOnView()
    {
        //Call
        let buttonCall = UIButton(type: UIButtonType.Custom) as UIButton
        buttonCall.frame = CGRectMake(
            gv.getConfigValue("navigationItemCallImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemCallImgHeight") as! CGFloat)
        
        buttonCall.setImage(UIImage(named: gv.getConfigValue("navigationItemCallImgName") as! String), forState: UIControlState.Normal)
        buttonCall.addTarget(self, action: "navItemCallClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemCall = UIBarButtonItem(customView: buttonCall)
        
        //Cart
        let buttonCart = UIButton(type: UIButtonType.Custom) as UIButton
        buttonCart.frame = CGRectMake(
            gv.getConfigValue("navigationItemCartImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemCartImgHeight") as! CGFloat)
        
        buttonCart.setImage(UIImage(named: gv.getConfigValue("navigationItemCartImgName") as! String), forState: UIControlState.Normal)
        buttonCart.addTarget(self, action: "navItemCartClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemCart = UIBarButtonItem(customView: buttonCart)
        
        //Search
        let buttonSearch = UIButton(type: UIButtonType.Custom) as UIButton
        buttonSearch.frame = CGRectMake(
            gv.getConfigValue("navigationItemSearchImgPositionX") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgPositionY") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgWidth") as! CGFloat,
            gv.getConfigValue("navigationItemSearchImgHeight") as! CGFloat)
        buttonSearch.setImage(UIImage(named: gv.getConfigValue("navigationItemSearchImgName") as! String), forState: UIControlState.Normal)
        buttonSearch.addTarget(self, action: "navItemSearchClick:", forControlEvents: UIControlEvents.TouchUpInside)
        let rightBarButtonItemSearch = UIBarButtonItem(customView: buttonSearch)
        
        
        
        // add multiple right bar button items
        self.navigationItem.setRightBarButtonItems([rightBarButtonItemSearch,rightBarButtonItemCart,rightBarButtonItemCall], animated: true)
        
        // uncomment to add single right bar button item
        //self.navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: false)
    }
    
    //Navigation Bar
    func backToPreviousPage(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func navItemFlightClick(sender:UIButton!)
    {
        print("navItemFlightClick")
    }
    /*
    func navItemCallClick(sender:UIButton!)
    {
        print("navItemCallClick")
        var callAssistViewController: CallAssistViewController!
        callAssistViewController = CallAssistViewController(nibName: "CallAssistViewController", bundle: nil)
        callAssistViewController.title = "This is a popup view"
        callAssistViewController.showInView(self.view, animated: true)
        
    }
    */
    func navItemCartClick(sender:UIButton!)
    {
        print("navItemCartClick")
        let cartViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CartViewController") as? CartViewController
        self.navigationController?.pushViewController(cartViewController!, animated: true)
        
    }
    
    func navItemSearchClick(sender:UIButton!)
    {
        print("navItemSearchClick")
        let searchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SearchViewController") as? SearchViewController
        let modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.FormSheet
        searchViewController?.modalPresentationStyle = modalStyle
        self.presentViewController(searchViewController!, animated: true, completion: nil)
    }
    


}
