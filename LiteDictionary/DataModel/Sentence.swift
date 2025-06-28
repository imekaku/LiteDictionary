//
//  Sentence.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation

struct Sentence: Codable, Hashable {
    
    let englishSentence: String
    let chineseSentence: String
    let sentenceLinkText: String
    let sentenceLinkHref: String
        
    init(englishSentence: String, chineseSentence: String, sentenceLinkText: String, sentenceLinkHref: String) {
        self.englishSentence = englishSentence
        self.chineseSentence = chineseSentence
        self.sentenceLinkText = sentenceLinkText
        self.sentenceLinkHref = sentenceLinkHref
    }
}
