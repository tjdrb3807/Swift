//
//  Credit.swift
//  CreditCardList
//
//  Created by 전성규 on 2022/05/20.
//

import Foundation

struct CreditCard: Codable {
    let id: Int
    let rank: Int
    let name: String
    let cardImageURL: String
    let promotionDetail: PromotionDetail
    let isSelected: Bool?
}

struct PromotionDetail: Codable {
    let compayName: String
    let amount: Int
    let period: String
    let condition: String
    let benefitCondition: String
    let benefitDetail: String
    let benefitDate: String
}
