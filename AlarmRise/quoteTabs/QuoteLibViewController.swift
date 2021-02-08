//
//  SavedQuotesViewController.swift
//  RiseAlarm
//
//  Created by Tiffany Cai on 5/17/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import UIKit
import CoreData

class QuoteLibViewController: UIViewController {

    @IBOutlet weak var tableQuotes: UITableView!
    var quoteArray = [QuoteEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableQuotes.delegate = self
        tableQuotes.dataSource = self
        tableQuotes.rowHeight = UITableView.automaticDimension
       
        //check for quotes
        let temp = DB.getQuotes()
        //if there is some saved, quotearray is quotes, will show in table
        if temp != nil {
            quoteArray = temp!
        }
    }
    
    //this is loading the view again each time
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let temp = DB.getQuotes()
        if temp != nil {
            quoteArray = temp!
            
        }
        
        tableQuotes.reloadData()
        waterfall()
    }
    
    // MARK:animations
    
    //animates table cells
    func waterfall() {
        
        tableQuotes.reloadData()
        let cells = tableQuotes.visibleCells        
        let tableViewHeight = tableQuotes.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay:Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }

}

extension QuoteLibViewController: UITableViewDelegate, UITableViewDataSource  {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteArray.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellLibrary", for: indexPath) as! LibraryTableViewCell

         cell.authorLabel.text =  quoteArray[indexPath.row].author
         cell.quoteLabel.text  = quoteArray[indexPath.row].quote
         
         return cell
     }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            DB.context.delete(quoteArray[indexPath.row])
            quoteArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
}

