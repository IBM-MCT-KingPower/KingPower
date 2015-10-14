//
//  SearchViewController.swift
//  KingPowerPromotion
//
//  Created by Suchart Jaturasathienchai on 9/27/15.
//  Copyright © 2015 IBMSD Mobile Core Team. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var productArray:[ProductModel] = []
    var filterProductArray:[ProductModel] = []
    var searchTextFilter = ""
    var searchActive : Bool = false
    //var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    //var filtered:[String] = []
    
    //let beautyList = ["SALVATORE FERRAGAMO Acqua","SALVATORE FERRAGAMO Signorina","NARS NIAGARA LIPSTICK","NARS SCHIAP LIPSTICK","NARS VANILLA CREAMY CONCEALER"]
    //let fashionList = ["Wallet","Ruler","Pencil", "Ice Green Tea"]
    //let electronicList = ["Fuji Camera X-A2", "Fuji Camera X-T10", "Macbook Air", "Macbook Pro", "Apple Watch"]
    
    var gv = GlobalVariable()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
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
        print("Type")
        if searchText.characters.count > 2 {
            searchTextFilter = searchText
            productArray = ProductController().getAllProduct()
            self.filterProductArray = self.productArray.filter({( prod: ProductModel) -> Bool in
                let prodName = prod.prod_name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                let branName = prod.prod_bran.bran_name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                let prodCatName = prod.prod_prc.prc_name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                let prodGrpName = prod.prod_prc.prc_prog.prog_name.lowercaseString.rangeOfString(searchText.lowercaseString) != nil
                return prodName || branName || prodCatName || prodGrpName
            })
            if(self.filterProductArray.count == 0){
                searchActive = false;
            } else {
                searchActive = true;
            }
        }else{
            self.filterProductArray.removeAll()
        }
        
        self.tableView.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(searchActive) {
            return self.filterProductArray.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.font = UIFont(name: "Century Gothic", size: 15)
        if(searchActive){
            if filterProductArray[indexPath.row].prod_name.lowercaseString.rangeOfString(searchTextFilter.lowercaseString) != nil {
                cell.textLabel?.text = filterProductArray[indexPath.row].prod_name
            }else if filterProductArray[indexPath.row].prod_bran.bran_name.lowercaseString.rangeOfString(searchTextFilter.lowercaseString) != nil {
                cell.textLabel?.text = filterProductArray[indexPath.row].prod_name + " ("+filterProductArray[indexPath.row].prod_bran.bran_name+")"
            }else if filterProductArray[indexPath.row].prod_prc.prc_name.lowercaseString.rangeOfString(searchTextFilter.lowercaseString) != nil {
                cell.textLabel?.text = filterProductArray[indexPath.row].prod_name + " ("+filterProductArray[indexPath.row].prod_prc.prc_name + ")"
            }else if filterProductArray[indexPath.row].prod_prc.prc_prog.prog_name.lowercaseString.rangeOfString(searchTextFilter.lowercaseString) != nil {
                cell.textLabel?.text = filterProductArray[indexPath.row].prod_name + " ("+filterProductArray[indexPath.row].prod_prc.prc_prog.prog_name + ")"
            }
            
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
