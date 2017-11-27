//
//  ImageCell.swift
//  SocialNetworking
//
//  Created by Wyatt Allen on 11/27/17.
//  Copyright © 2017 Wyatt Allen. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var messageImageView: UIImageView!
    
    func configure(imgURL: URL?){
    NetworkConnectivity.imageForURL(url: imgURL) { (image, url) in
            self.messageImageView.image = image
        }
    
    
    }
    
}
