//
//  ContentModel.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation
import SwiftSoup

class ContentModel: ObservableObject {
    
    private var bingSearchUrl = "https://cn.bing.com/dict/clientsearch?mkt=zh-CN&setLang=zh&form=BDVEHC&ClientVer=BDDTV3.5.1.4320&q="
    private var htmlResult: String = ""
    
    @Published var dictResponse: DictResponse?
    
    @MainActor
    public func fetchHTMLPage(searchText: String) {
        
        if searchText.isEmpty {
            return
        }
        let url = URL(string: "\(bingSearchUrl)\(searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        htmlResult = ""
        HttpUtils.fetchHTMLViaGet(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let html):
                    self.dictResponse = ParseUtils.parseDictHtml(input: searchText, html)
                case .failure(_):
                    self.dictResponse = DictResponse(intput: searchText, pronunciation: [], words: [], sentences: [], code: 500)
                }
            }
        }
    }
}
