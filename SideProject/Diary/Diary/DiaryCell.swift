//
//  DiaryCell.swift
//  Diary
//
//  Created by 전성규 on 2022/05/09.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // 작업: Cell의 테두리 설정
    // 이 생성자는 UIView가 생성될 떄 이 생성자를 통해 객체가 생성된다.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // Cell의 테두리를 그려주는 Code 작성
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
        // 다음 작업: 일기장 목록에서 일기 선택시 일기 상헤화면 내용 표시 기능 구현 -> DiaryDetailViewController에서 구현
    }
}
