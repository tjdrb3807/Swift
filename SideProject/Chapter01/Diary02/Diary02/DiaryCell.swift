//
//  DiaryCell.swift
//  Diary02
//
//  Created by 전성규 on 2022/05/13.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Cell 테두리 구현
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.cornerRadius = 3.0
    }
}
