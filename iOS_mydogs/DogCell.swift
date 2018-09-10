//
//  DogCell.swift
//  iOS_mydogs
//
//  Created by Quang Nguyen on 9/10/18.
//  Copyright © 2018 Quang Nguyen. All rights reserved.
//

import UIKit

class DogCell: UICollectionViewCell {
    
    var dog: Dog?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func renderWithData(from dog: Dog) {
      
        if let imageData = dog.image {
            imageView.image = UIImage(data: imageData)
        }
        nameLabel.text = dog.name
    }
    
}

