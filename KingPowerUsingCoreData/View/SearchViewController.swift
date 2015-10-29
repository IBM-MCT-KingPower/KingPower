//
//  SearchViewController.swift
//  KingPowerPromotion
//
//  Created by Suchart Jaturasathienchai on 9/27/15.
//  Copyright © 2015 IBMSD Mobile Core Team. All rights reserved.
//

import UIKit

protocol searchDelegate{
    func sendProductList(productArray:[ProductModel])
}

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    //var productArray:[ProductModel] = []
    //var filterProductArray:[ProductModel] = []
    var searchTextFilter = ""
    var searchActive : Bool = false
    var dataArray:[String] = []
    var dataFilterArray:[String] = []
    var gv = GlobalVariable()
    var uiView:UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let brandArray = BrandController().getAllBrand()
        let prodCatArray = ProductMainCategoryController().getAllProductMainCategory()
        let prodGrpArray = ProductGroupController().getAllProductGroup()
        
        for brand in brandArray {
            dataArray.append(brand.bran_name)
        }
        for prodCat in prodCatArray {
            dataArray.append(prodCat.prc_name)
        }
        for prodGrp in prodGrpArray {
            dataArray.append(prodGrp.prog_name)
        }
        
        print("data array \(dataArray.count)")
        
        // Do any additional setup after loading the view.
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.placeholder = gv.getConfigValue("searchPlaceholder") as? String
        
    }
    
    func handleTap(recognizer: UITapGestureRecognizer){
        print("Tap")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count > 1 {
            searchTextFilter = searchText
            /*
            productArray = ProductController().getAllProduct()
            self.filterProductArray = self.productArray.filter({( prod: ProductModel) -> Bool in
                let prodName = prod.prod_name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                let branName = prod.prod_bran.bran_name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                let prodCatName = prod.prod_prc.prc_name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                let prodGrpName = prod.prod_prc.prc_prog.prog_name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                return prodName || branName || prodCatName || prodGrpName
            })
*/
            self.dataFilterArray = self.dataArray.filter({$0.lowercaseString.rangeOfString(searchText.lowercaseString) != nil})
            
            if(self.dataFilterArray.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
        }else{
            self.dataFilterArray.removeAll()
        }
        
        self.tableView.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(searchActive) {
            return self.dataFilterArray.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.font = UIFont(name: "Century Gothic", size: 15)
        if(searchActive){
            cell.textLabel?.text = dataFilterArray[indexPath.row]
            /*
            if filterProductArray[indexPath.row].prod_name.lowercaseString.rangeOfString(searchTextFilter.lowercaseString) != nil {
                cell.textLabel?.text = filterProductArray[indexPath.row].prod_name
            }else if filterProductArray[indexPath.row].prod_bran.bran_name.lowercaseString.rangeOfString(searchTextFilter.lowercaseString) != nil {
                cell.textLabel?.text = filterProductArray[indexPath.row].prod_name + " ("+filterProductArray[indexPath.row].prod_bran.bran_name+")"
            }else if filterProductArray[indexPath.row].prod_prc.prc_name.lowercaseString.rangeOfString(searchTextFilter.lowercaseString) != nil {
                cell.textLabel?.text = filterProductArray[indexPath.row].prod_name + " ("+filterProductArray[indexPath.row].prod_prc.prc_name + ")"
            }else if filterProductArray[indexPath.row].prod_prc.prc_prog.prog_name.lowercaseString.rangeOfString(searchTextFilter.lowercaseString) != nil {
                cell.textLabel?.text = filterProductArray[indexPath.row].prod_name + " ("+filterProductArray[indexPath.row].prod_prc.prc_prog.prog_name + ")"
            }
            */
        }
        
        return cell;
    }
    /*
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Beauty"
        } else if section == 1 {
            return "Fashion"
        } else {
            return "Electronic"
        }
    }*/
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if uiView.isKindOfClass(ViewController){
            let delegate = uiView as! searchDelegate
            delegate.sendProductList(ProductController().getProductByGorupCatBranName(dataFilterArray[indexPath.row]))
        }else{
            let productListViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductListViewController") as? ViewController
            let productArray = ProductController().getProductByGorupCatBranName(dataFilterArray[indexPath.row])
            productListViewController?.productArray = productArray
            productListViewController?.searchResult = "Found  \(productArray.count)  items"
            uiView.navigationController?.pushViewController(productListViewController!, animated: true)
        }
    }
    /*
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let hView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 35))
        hView.backgroundColor = UIColor(hexString: String(gv.getConfigValue("sectionHeaderColor")))
        let hLabel = UILabel(frame: CGRectMake(10, 0, tableView.frame.width, 35))
        hLabel.font = UIFont(name: "Century Gothic", size: 18)
        hLabel.textColor = UIColor(hexString: String(gv.getConfigValue("whiteColor")))
        if section == 0 {
            hLabel.text = "Beauty"
        } else if section == 1 {
            hLabel.text = "Fashion"
        } else {
            hLabel.text = "Electronic"
        }

        hView.addSubview(hLabel)
        return hView
        
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
