//
//  ParseUtils.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation
import SwiftSoup

public class ParseUtils {
    
    public static func parseDictHtml(input:String, _ html: String) -> DictResponse {
        if let document: Document = try? SwiftSoup.parse(html) {
            let words = self.parseWords(document)
            let pronunciations = self.parsePronunciations(document)
            let sentences = self.parseExampleSentences(document)
            return DictResponse(intput: input, pronunciation: pronunciations, words: words, sentences: sentences, code: 200)
        } else {
            return DictResponse(intput: "", pronunciation: [], words: [], sentences: [], code: 500)
        }
    }
    
    private static func parsePronunciations(_ document: Document) -> [Pronunciation] {
        do {
            guard let pnBar = try document.select("div#client_def_hd_pn_bar").first() else {
                return []
            }
            
            let pronunciationsFromHtml = try pnBar.select("div.client_def_hd_pn")
            var pronunciations: [Pronunciation] = []
            
            for pronunciation in pronunciationsFromHtml {
                let text = try pronunciation.text()
                if let res = parsePronunciationText(text) {
                    pronunciations.append(res)
                }
            }
            return pronunciations
        } catch {
            return []
        }
    }
    
    private static func parseWords(_ document: Document) -> [Word] {
        do {
            guard let firstContainer = try document.select("div.client_def_container").first() else {
                return []
            }
            let bars = try firstContainer.select("div.client_def_bar")
            var words: [Word] = []
            for bar in bars {
                let titleElement = try bar.select("div.client_def_title_bar > span").first()
                let title = try titleElement?.text() ?? ""

                guard let contentElement = try bar.select("div.client_def_list_word_content").first() else {
                    continue
                }

                // 遍历所有子节点，拼接文本
                let meaning = contentElement.getChildNodes().compactMap { node in
                    if let element = node as? Element {
                        return try? element.text()
                    } else if let textNode = node as? TextNode {
                        return textNode.text()
                    } else {
                        return nil
                    }
                }.joined()

                words.append(Word(wordType: title, wordExplanation: meaning))
            }
            return words
        } catch {
            return []
        }
    }
    
    private static func parseExampleSentences(_ document: Document) -> [Sentence] {
        do {
            let sentencesFromHtml = try document.select("div.client_sentence_list")
            var sentences: [Sentence] = []
            for sentenceFromHtml in sentencesFromHtml {
                let enContainer = try sentenceFromHtml.select("div.client_sen_en").first()
                let enText = try enContainer?.text() ?? ""
                let cnContainer = try sentenceFromHtml.select("div.client_sen_cn").first()
                let cnText = try cnContainer?.text() ?? ""
                if let linkElement = try sentenceFromHtml.select("div.client_sentence_list_link a").first() {
                    let linkText = try linkElement.text()
                    let linkHref = try linkElement.attr("href")
                    sentences.append(Sentence(englishSentence: enText, chineseSentence: cnText, sentenceLinkText: linkText, sentenceLinkHref: linkHref))
                }
            }
            return sentences
        } catch {
            return []
        }
    }

    private static func parsePronunciationText(_ input: String) -> Pronunciation? {
        guard input.contains(":") else {
            return nil
        }
        
        let parts = input.components(separatedBy: ":")
        guard parts.count == 2 else {
            return nil
        }
        
        let type = parts[0].trimmingCharacters(in: .whitespaces)
        let value = parts[1].trimmingCharacters(in: .whitespaces)
        
        guard !type.isEmpty, !value.isEmpty else {
            return nil
        }
        return Pronunciation(pronunciationType: type, PronunciationValue: value)
    }
}
