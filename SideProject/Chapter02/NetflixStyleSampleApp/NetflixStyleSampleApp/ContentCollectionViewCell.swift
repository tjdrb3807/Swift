//
//  ContentCollectionViewCell.swift
//  NetflixStyleSampleApp
//
//  Created by 전성규 on 2022/05/23.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)
        
        //imageView Auto Layout Setting -> SnapKit
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
