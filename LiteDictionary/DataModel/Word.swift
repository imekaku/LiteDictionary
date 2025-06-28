//
//  Word.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation

struct Word: Codable, Hashable {
    
    let wordType: String
    let wordExplanation: String
        
    init(wordType: String, wordExplanation: String) {
        self.wordType = wordType
        self.wordExplanation = wordExplanation
    }
}
