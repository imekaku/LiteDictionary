//
//  DictContentView.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation
import SwiftUI

struct DictContentView: View {
    
    let dictResponse: DictResponse
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    getPronunciationView(pronunciations: dictResponse.pronunciation)
                    ViewUtils.divider
                    getWordView(words: dictResponse.words)
                    ViewUtils.divider
                    getSentenceView(sentences: dictResponse.sentences)
                }
            }
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 15)
    }
    
    private func getPronunciationView(pronunciations: [Pronunciation]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("发音:").bold()
                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
                ForEach(pronunciations, id: \.self) { pronunciation in
                    HStack(spacing: 6) {
                        Image(systemName: "waveform")
                            .foregroundColor(.gray)

                        Text(pronunciation.pronunciationType)
                            .italic()
                            .foregroundColor(.gray)

                        Text(pronunciation.PronunciationValue)
                            .font(.body)
                            .foregroundColor(.black)

                        Spacer()
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
    }

    
    private func getWordView(words: [Word]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("释意:").bold()
                Spacer()
            }

            ForEach(words, id: \.self) { word in
                HStack(alignment: .top, spacing: 4) {
                    Text(word.wordType)
                        .italic()
                        .foregroundColor(.gray)
                        .frame(width: 50, alignment: .leading)
                    Text(word.wordExplanation)
                        .font(.body)
                    Spacer()
                }
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
        }
    }
    
    private func getSentenceView(sentences: [Sentence]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("例句:").bold()
                Spacer()
            }

            ForEach(sentences, id: \.self) { sentence in
                VStack(alignment: .leading, spacing: 4) {
                    Text(sentence.englishSentence)
                        .font(.headline)

                    Text(sentence.chineseSentence)
                        .font(.body)

                    Link(sentence.sentenceLinkText, destination: URL(string: sentence.sentenceLinkHref)!)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .underline()
                }
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
        }
    }

}
