//
//  NoteViewController.swift
//  CloudNote
//
//  Created by Nick Chen on 8/9/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextView!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var note: PFObject?
    var didSelectImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTitle.delegate = self
        
        if let note = note {
            noteTitle.text   = note["Title"] as? String
            noteBody.text = note["Body"] as? String
            
            let image = note["Photo"] as? PFFile
            image?.getDataInBackgroundWithBlock {(imageData, error) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        self.noteImage.image = UIImage(data:imageData)
                    }
                }
            }
        }
        
        // Don't allow saving without title
        if noteTitle.text!.isEmpty {
            saveButton.enabled = false
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
        if saveButton === sender {
            if note == nil {
                let newNote = PFObject(className:"Note")
                note = newNote
            }
            
            if let note = note {
                note["Title"] = noteTitle.text
                note["Body"] = noteBody.text
                if didSelectImage {
                    if let image = noteImage.image  {
                        let imageData = UIImageJPEGRepresentation(image, 0.8)
                        let filename = String(format:"%@.jpeg", noteTitle.text!)
                        let imageFile = PFFile(name:filename, data:imageData!)
                        note["Photo"] = imageFile
                    }
                }
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidTitle()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidTitle() {
        // Disable the Save button if the text field is empty.
        let text = noteTitle.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        noteImage.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        didSelectImage = true
        
        // Hide the keyboard.
        noteTitle.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
