//
//  ViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/23/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate, sortDataDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var productArray:[Products] = []
    var database:FMDatabase!
    var popViewController : popupViewController!
    let detailTransitioningDelegate: PresentationManager = PresentationManager()
    var sortingIndex:Int = 0
    
    var navBar:UINavigationBar=UINavigationBar()
    var gv = GlobalVariable()
    
    var callAssistanceViewController : CallAssistanceViewController!
    var flightViewController : FlightViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.openDB()
        self.query()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("viewcell",
            forIndexPath: indexPath) as! ProductCollectionViewCell
        cell.productName.text = (self.productArray[indexPath.row]).product_name
        cell.productDescription.text = (self.productArray[indexPath.row]).product_description
        /*
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.currencyCode = "THB"
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.negativeFormat = "-¤#,##0.00"
        
        cell.productPrice.text = currencyFormatter.stringFromNumber(self.productArray[indexPath.row].product_price)
*/
        cell.productPrice.text = NSNumber(double: self.productArray[indexPath.row].product_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
        cell.backgroundColor = UIColor.whiteColor()
        cell.productImage.image = UIImage(named: self.productArray[indexPath.row].product_image1)
        cell.productImage.layer.borderWidth = 1.0
        cell.productImage.layer.borderColor = UIColor(hexString: String(gv.getConfigValue("borderCollectionColor"))).CGColor
        return cell
    }
    
    func openDB(){
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsFolder.stringByAppendingPathComponent("kpdata")
        //print("db path: \(path)")
        
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
    
    func backToPreviousPage(sender: AnyObject) {
        print("backtopreviouspage")
        self.navigationController?.popViewControllerAnimated(true)
    }
    func query(){
        self.productArray.removeAll(keepCapacity: true)
        if let rs = database.executeQuery("SELECT product_id, product_name, product_description, product_price,product_image1,product_image2,product_image3,product_image4,product_image5,product_rating FROM kp_product;", withArgumentsInArray: nil) {
            
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
    
    func setSorting(sortIndex : Int){
      self.sortingIndex = sortIndex
      self.collectionView.reloadData()
      self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
          if (segue.identifier == "segueDetail") {
            if let indexPath = self.collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
              (segue.destinationViewController as! ProductDetailViewController).productDetail = productArray[indexPath.row]
            }
          }
          else if (segue.identifier == "popSegue") {
            let detailViewController = segue.destinationViewController as! popupViewController
            //detailViewController.transitioningDelegate = detailTransitioningDelegate
            //detailViewController.modalPresentationStyle = .Custom
            (segue.destinationViewController as! popupViewController).sortingIndex = self.sortingIndex
            (segue.destinationViewController as! popupViewController).segment = 0
            (segue.destinationViewController as! popupViewController).delegate = self
          }
          else if (segue.identifier == "filterpopSegue") {
            let detailViewController = segue.destinationViewController as! popupViewController
            //detailViewController.transitioningDelegate = detailTransitioningDelegate
            //detailViewController.modalPresentationStyle = .Custom
            (segue.destinationViewController as! popupViewController).sortingIndex = self.sortingIndex
            (segue.destinationViewController as! popupViewController).segment = 1
            (segue.destinationViewController as! popupViewController).delegate = self
        }
        
    }
    

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
    func navItemFlightClick(sender:UIButton!)
    {
        self.removeNavigateView()
        flightViewController = FlightViewController(nibName: "FlightViewController", bundle: nil)
        flightViewController.showInView(self.view, animated: true)
    }
    
    func navItemCallClick(sender:UIButton!)
    {
        self.removeNavigateView()
        callAssistanceViewController = CallAssistanceViewController(nibName: "CallAssistanceViewController", bundle: nil)
        callAssistanceViewController.showInView(self.view, animated: true)
        
    }
    
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
}

