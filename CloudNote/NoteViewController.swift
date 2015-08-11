//
//  NoteViewController.swift
//  CloudNote
//
//  Created by Nick Chen on 8/9/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextView!
    
    var note: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let note = note {
            noteTitle.text   = note["Title"] as? String
            noteBody.text = note["Body"] as? String
        }
    }

    // MARK: - Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let note = note {
            note["Title"] = noteTitle.text
            note["Body"] = noteBody.text
        } else {
            let newNote = PFObject(className:"Note")
            newNote["Title"] = noteTitle.text
            newNote["Body"] = noteBody.text
            note = newNote
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
