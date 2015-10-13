//
//  filterViewController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/27/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit


class filterViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, filterDetailDelegate {
    
    @IBOutlet weak var filterTableView: UITableView!
    var filterDataArray:[String] = ["SUB CATEGORY","BRAND","GENDER","PRICE RANGE","COLOR"]
    var filterDataDetailArray:[String] = ["All", "All", "All", "All", "All"]
    var filterDetailSubCat:[ProductCategoryModel] = []  // select 1 subcat
    var filterDetailBrand:[BrandModel] = []             // select more than 1
    var filterDetailGender:[String] = KPVariable.genderList //Select 1 gender
    var filterDetailPriceRange:[String] = KPVariable.priceRangeList          // select 1 range
    var filterDetailColor:[String] = KPVariable.colorList                 // Select more than 1
    
    var delegate:filterDetailDelegate?
    //let detailTransitioningDelegate: filterdetailManager = filterdetailManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifierID = "filterCell"
        let cell = filterTableView.dequeueReusableCellWithIdentifier(cellIdentifierID) as UITableViewCell?
        
        cell?.textLabel!.text = self.filterDataArray[indexPath.row]
        //cell?.textLabel!.font = UIFont(name: "Century Gothic", size: 15)
        cell?.detailTextLabel!.text = self.filterDataDetailArray[indexPath.row]
        //cell?.textLabel!.font = UIFont(name: "Century Gothic", size: 15)
        return cell!
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "filterdetailCell") {
            let detailViewController = segue.destinationViewController as! detailFilterViewController
            let selectedIndex = filterTableView.indexPathForCell(sender as! UITableViewCell)
            let row = (selectedIndex?.row)!
            if row == 0 {
                filterDetailSubCat = ProductMainCategoryController().getAllProductMainCategory()
                detailViewController.filterDetailSubCat = filterDetailSubCat
            }else if row == 1 {
                filterDetailBrand =  BrandController().getAllBrand()
                detailViewController.filterDetailBrand = filterDetailBrand
            }         
            detailViewController.selectedIndexMain = (selectedIndex?.row)!
            detailViewController.delegate = self
            //detailViewController.transitioningDelegate = detailTransitioningDelegate
            //detailViewController.modalPresentationStyle = .Custom
        }
        
    }
    func addSubcat(prodCatIndex: Int) {
        print("FilterViewController : Add Subcat")
        self.filterDataDetailArray[0] = filterDetailSubCat[prodCatIndex].prc_name != "" ? filterDetailSubCat[prodCatIndex].prc_name : "All"
        
        //self.filterDataDetailArray[0] = prodCat.prc_name != "" ? prodCat.prc_name : "All"
        self.filterTableView.reloadData()
        //self.filterTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        delegate!.addSubcat(prodCatIndex)
    }
    func addBrandList (brandIndexList:NSMutableArray){
        if brandIndexList.count == 1 {
            self.filterDataDetailArray[1] = filterDetailBrand[(brandIndexList[0] as! Int)].bran_name
            //self.filterDataDetailArray[1] = (brandList[0] as! BrandModel).bran_name
        }else if brandIndexList.count > 1 {
            var str = filterDetailBrand[(brandIndexList[0] as! Int)].bran_name
            var i = 1;
            while ( i < brandIndexList.count ) {
                str += "," + filterDetailBrand[(brandIndexList[i] as! Int)].bran_name
                i++
            }
            self.filterDataDetailArray[1] = str
        }else{
            self.filterDataDetailArray[1] = "All"
        }
        self.filterTableView.reloadData()
        delegate!.addBrandList(brandIndexList)
        
    }
    func addGender (genderIndex:Int){
        self.filterDataDetailArray[2] = filterDetailGender[genderIndex] != "" ? filterDetailGender[genderIndex] : "All"
        self.filterTableView.reloadData()
        delegate!.addGender(genderIndex)
        
    }
    func addPriceRange (rangeIndex:Int){
        self.filterDataDetailArray[3] = filterDetailPriceRange[rangeIndex] != "" ? filterDetailPriceRange[rangeIndex] : "All"
        self.filterTableView.reloadData()
        delegate!.addPriceRange(rangeIndex)
    }
    func addColor (colorIndexList:NSMutableArray){
        if colorIndexList.count == 1 {
            self.filterDataDetailArray[4] = filterDetailColor[(colorIndexList[0] as! Int)]
        }else if colorIndexList.count > 1 {
            var str = filterDetailColor[(colorIndexList[0] as! Int)]
            var i = 1;
            while ( i < colorIndexList.count ) {
                str += "," + filterDetailColor[(colorIndexList[i] as! Int)]
                i++
            }
            self.filterDataDetailArray[4] = str
        }else{
            self.filterDataDetailArray[4] = "All"
        }
        self.filterTableView.reloadData()
        delegate!.addColor(colorIndexList)
        
    }
    
    @IBAction func applyFilter(sender:AnyObject?){
        self.dismissViewControllerAnimated(true, completion: nil)
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
