//
//  DictResponse.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation
public struct DictResponse: Codable {
    
    let intput: String
    let pronunciation: [Pronunciation]
    let words: [Word]
    let sentences: [Sentence]
    let code: Int
    
    init(intput: String, pronunciation: [Pronunciation], words: [Word], sentences: [Sentence], code: Int) {
        self.intput = intput
        self.pronunciation = pronunciation
        self.words = words
        self.sentences = sentences
        self.code = code
    }
}
