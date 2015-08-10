//
//  NoteTableViewController.swift
//  CloudNote
//
//  Created by Nick Chen on 8/8/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {

    var notes = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load data from Parse
        // https://www.parse.com/docs/ios/guide#queries-basic-queries
        let query = PFQuery(className:"Note")
        query.addDescendingOrder("updatedAt")
        query.findObjectsInBackgroundWithBlock {
            (notes: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                print("Successfully retrieved \(notes!.count) notes.")
                if let notes = notes as? [PFObject] {
                    self.notes = notes
                    self.tableView.reloadData()
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteCell
        
        let note = notes[indexPath.row]
        cell.noteTitle.text = note["Title"] as? String
        cell.noteBody.text = note["Body"] as? String
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let noteViewController = segue.destinationViewController as! NoteViewController
            
            // Get the cell that generated this segue.
            if let selectedNoteCell = sender as? NoteCell {
                let indexPath = tableView.indexPathForCell(selectedNoteCell)!
                let selectedNote = notes[indexPath.row]
                noteViewController.note = selectedNote
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new note.")
        }
    }
    
    @IBAction func unwindToNoteList(sender: UIStoryboardSegue) {
        if let noteViewController = sender.sourceViewController as? NoteViewController, note = noteViewController.note {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing note.
                notes[selectedIndexPath.row] = note
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
            }
            
            // Save the modified note
            // https://www.parse.com/docs/ios/guide#objects-saving-objects
            note.saveInBackgroundWithBlock {
                (success, error) -> Void in
                if (success) {
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
