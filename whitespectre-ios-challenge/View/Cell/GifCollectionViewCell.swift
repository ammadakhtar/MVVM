//
//  GlyphCollectionViewCell.swift
//  whitespectre-ios-challenge
//
//  Created by Mac on 5/30/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var glphyImageView: UIImageView!
    @IBOutlet weak var glyphNameLabel: UILabel!

    // MARK: - Override Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // setting up a nice card look
        
        contentView.layer.cornerRadius = 6.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        
        // corner radius for imageView to give a nice rounded look
        
        glphyImageView.layer.cornerRadius = 5.0
    }

    // MARK: - Private Method
    
    class func cellForCollectionView(collectionView: UICollectionView, indexPath: IndexPath) -> GifCollectionViewCell {
        let kGifCollectionViewCellIdentifier = "kGifCollectionViewCellIdentifier"
        collectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: kGifCollectionViewCellIdentifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGifCollectionViewCellIdentifier, for: indexPath) as! GifCollectionViewCell
        return cell
    }
}
