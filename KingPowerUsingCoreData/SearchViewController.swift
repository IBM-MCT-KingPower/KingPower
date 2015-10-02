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
    
    var searchActive : Bool = false
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var filtered:[String] = []
    
    let beautyList = ["SALVATORE FERRAGAMO Acqua","SALVATORE FERRAGAMO Signorina","NARS NIAGARA LIPSTICK","NARS SCHIAP LIPSTICK","NARS VANILLA CREAMY CONCEALER"]
    let fashionList = ["Wallet","Ruler","Pencil", "Ice Green Tea"]
    let electronicList = ["Fuji Camera X-A2", "Fuji Camera X-T10", "Macbook Air", "Macbook Pro", "Apple Watch"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
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
        
        filtered = data.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(searchActive) {
            return filtered.count
        } else {
            if section == 0 {
                return beautyList.count
            }else if section == 1 {
                return fashionList.count
            } else {
                return electronicList.count
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.font = UIFont(name: "Century Gothic", size: 15)
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
        } else {
            switch indexPath.section {
            case 0 :
                cell.textLabel!.text = beautyList[indexPath.row]
            case 1 :
                cell.textLabel!.text = fashionList[indexPath.row]
            case 2 :
                cell.textLabel!.text = electronicList[indexPath.row]
            default :
                break
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let hView = UIView(frame: CGRectMake(0, 0, tableView.frame.width, 35))
        hView.backgroundColor = Constants.Color.LinkColor
        let hLabel = UILabel(frame: CGRectMake(10, 0, tableView.frame.width, 35))
        hLabel.font = UIFont(name: "Century Gothic", size: 18)
        hLabel.textColor = Constants.Color.WhiteColor
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
