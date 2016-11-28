//
//  TempleteCollectionViewCell.swift
//  ZiDemo
//
//  Created by Binboy on 2016/11/7.
//  Copyright © 2016年 Binboy. All rights reserved.
//

import UIKit

class TempleteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 6
        clipsToBounds = true
    }
    
}
