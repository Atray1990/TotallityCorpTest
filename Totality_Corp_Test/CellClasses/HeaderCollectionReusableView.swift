//
//  HeaderCollectionReusableView.swift
//  Totality_Corp_Test
//
//  Created by shashank atray on 02/02/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var ivima: UIImageView!

    
    var stringValue: String! {
        didSet {
            decriptionLabel.text = stringValue
        }
    }
}
