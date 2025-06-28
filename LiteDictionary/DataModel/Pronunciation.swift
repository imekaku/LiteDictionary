//
//  Pronunciation.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation

struct Pronunciation: Codable, Hashable {
    
    let pronunciationType: String
    let PronunciationValue: String
        
    init(pronunciationType: String, PronunciationValue: String) {
        self.pronunciationType = pronunciationType
        self.PronunciationValue = PronunciationValue
    }
}
