//
//  NoteCell.swift
//  CloudNote
//
//  Created by Nick Chen on 8/8/15.
//  Copyright © 2015 TalentSpark. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    
    @IBOutlet weak var notePhoto: UIImageView!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteBody: UILabel!
    
    var note: PFObject? {
        didSet {
            if let setNote = note {
                noteTitle.text = setNote["Title"] as? String
                noteBody.text = setNote["Body"] as? String
                let image = setNote["Photo"] as? PFFile
                image?.getDataInBackgroundWithBlock {(imageData, error) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            self.notePhoto.image = UIImage(data:imageData)
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
