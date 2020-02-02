//
//  CollectionViewCell.swift
//  Totality_Corp_Test
//
//  Created by shashank atray on 02/02/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation
import UIKit
import AVKit
class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var ivPlayerImage: UIImageView!
    @IBOutlet weak var avPlayerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivPlayerImage.layer.cornerRadius = ivPlayerImage.frame.size.width/2
    }
    
    func setupDataValue(feedData: FeedData) {
        lblPlayerName.text = feedData.name
        
        let name = NSMutableAttributedString(string:"\(feedData.name)  ", attributes:
        [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        let hours = NSMutableAttributedString(string:feedData.time, attributes:
        [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        name.append(hours)
        
        lblPlayerName.attributedText = name
        ivPlayerImage.DownloadImageForCollectionView(from: feedData.imageUrl) { (err) in
            
            if err != nil {
                
            }
        }
    }
   
}

class ProfileCollectionViewCell: UICollectionViewCell {

   @IBOutlet weak var ivPlayerImage: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
       }
    
    func setupWithPhoto(profileValues: profileData) {
        ivPlayerImage.DownloadImageForCollectionView(from: profileValues.imageUrl) { (err) in
            
            if err != nil {
                
            }
        }
    }
}





