//
//  PostCell.swift
//  instaclone
//
//  Created by Zachary West Guo on 10/5/16.
//  Copyright © 2016 zechariah. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let rect = self.imageView?.frame {
            var newRect = rect
//            newRect.origin = CGPointMake((rect.size.width)/2, (rect.size.height)/2)
//            self.imageView!.frame = newRect
            //newRect.origin.x = ((self.imageView?.bounds.size.width)!-self.imageView!.frame.size.width)/2.0
            newRect.origin.x = 35;
            newRect.origin.y = 75;
            self.imageView!.frame = newRect
        }
    }

    @IBAction func likePressed(sender: AnyObject) {
    }
}
