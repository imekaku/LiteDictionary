//
//  HttpUtils.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation

class HttpUtils {
    
    private static let UTILS_DOMAIN = "HttpUtils"
    
    public static let HEADERS = ["Content-Type": "text/html"]
    
    public static let GET = "GET"
    
    public static let OK = 200
    
    public static func fetchHTMLViaGet(url: URL,
                                       headers: [String: String]? = nil,
                                       queryParams: [String: Any]? = nil,
                                       completion: @escaping (Result<String, Error>) -> Void) {
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryParams = queryParams, !queryParams.isEmpty {
            urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let finalURL = urlComponents?.url else {
            completion(.failure(NSError(domain: UTILS_DOMAIN, code: URLError.badURL.rawValue, userInfo: [NSLocalizedDescriptionKey: "Construct URL Failed"])))
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = GET
        request.allHTTPHeaderFields = [
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15",
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
        ].merging(headers ?? [:]) { (_, new) in new }
        
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: UTILS_DOMAIN, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
                completion(.failure(error))
                return
            }
            
            if httpResponse.statusCode != HttpUtils.OK {
                let error = NSError(domain: UTILS_DOMAIN, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Invalid status code"])
                completion(.failure(error))
                return
            }
            
            guard let data = data, let htmlString = String(data: data, encoding: .utf8) else {
                let error = NSError(domain: UTILS_DOMAIN, code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse HTML"])
                completion(.failure(error))
                return
            }
            
            completion(.success(htmlString))
        }
        
        task.resume()
    }
}
