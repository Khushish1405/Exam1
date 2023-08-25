//
//  TableVc.swift
//  Exam1
//
//  Created by APPLE on 15/02/23.
//

import UIKit

class TableVc: UITableViewController, CatManagerDelegate {
    
    @IBOutlet var tableview: UITableView!
    
    func didUpdatecat(_ catManager: CatManager, cat: CatData) {
        
        catNames = cat.data
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func didFailWithErrors(error: Error) {
        
        print(error)
    }
    
    var catNames:[deetail] = []
    
    var catManager = CatManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        catManager.delegate = self
        catManager.getJok()
        
    }

    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return 1
        }else if(section == 2){
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
            cell.nameLbl.text = catNames[indexPath.row].breed
            cell.layer.borderWidth = 1
            return cell
        }else {
            
        }
        return UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}
