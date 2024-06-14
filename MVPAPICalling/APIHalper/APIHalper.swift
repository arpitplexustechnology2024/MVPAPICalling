//
//  APIHalper.swift
//  MVPAPICalling
//
//  Created by Arpit iOS Dev. on 13/06/24.
//

import Foundation
import Alamofire

class APIHalper {
    func getWordsPracticeList(keyName: String, completion: @escaping (Result<Welcome, Error>) -> Void) {
        let url = "http://stenoapp.gautamsteno.com/api/get_words_practise_list"
        let parameters: Parameters = [
            "key-name": keyName
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let welcome = try decoder.decode(Welcome.self, from: data)
                    completion(.success(welcome))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
