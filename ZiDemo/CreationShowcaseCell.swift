//
//  CreationShowcaseCell.swift
//  ZiDemo
//
//  Created by Binboy on 2016/11/6.
//  Copyright © 2016年 Binboy. All rights reserved.
//

import UIKit
import Kingfisher

class CreationShowcaseCell: UITableViewCell {
    
    @IBOutlet weak var showcaseCollectionView: UICollectionView!
    
    var templetes: [Templete] = [] {
        didSet {
            showcaseCollectionView.reloadData()
        }
    }
    
    var clickedAt: ((_ index:Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(CreationShowcaseCell.moveItem(gesture:)))
        addGestureRecognizer(longPress)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func moveItem(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = showcaseCollectionView.indexPathForItem(at: gesture.location(in: showcaseCollectionView)) else {
                break
            }
            showcaseCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            showcaseCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            showcaseCollectionView.endInteractiveMovement()
        case .cancelled, .failed, .possible:
            showcaseCollectionView.cancelInteractiveMovement()
        }
    }

}

extension CreationShowcaseCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return templetes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TempleteCollectionCell", for: indexPath) as! TempleteCollectionViewCell
        let url = URL(string: templetes[indexPath.item].thumbnail)
        cell.imageView.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let clicked = clickedAt {
            clicked(indexPath.item)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
}
