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
        navigationController!.popViewControllerAnimated(true)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let note = note {
            note["Title"] = noteTitle.text
            note["Body"] = noteBody.text
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
