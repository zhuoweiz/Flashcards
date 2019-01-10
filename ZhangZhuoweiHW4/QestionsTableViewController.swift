//
//  QestionsTableViewController.swift
//  ZhangZhuoweiHW5
//
//  Created by Joey on 11/5/18.
//  Copyright © 2018 Joey. All rights reserved.
//

import UIKit

class QestionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    var sharedModel = FlashcardsModel.shared

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sharedModel.numberOfFlashcards();
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Either reuse or create a new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
        
        // get object for each row
        let card = sharedModel.flashcard(atIndex: indexPath.row)
        
        // Modify cell
        cell.textLabel?.text = card?.getQuestion();
        
        return cell;
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 1) Delete the data from model
            sharedModel.removeFlashcard(atIndex: indexPath.row);
            
            // 2) Delete the cell (UI)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "AddQASegue", let addViewController = segue.destination as? AddViewController{
            
            addViewController.completionHandler = { question, answer  in
                
            if let q = question, let a = answer {
                // Add card to singleton model
                self.sharedModel.insert(question: q, answer: a, favorite: false)
                
                // 3) Refresh the tableview UI
                self.tableView.reloadData()
            }
            self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    

}
