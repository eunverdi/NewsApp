//
//  APICaller.swift
//  NewsAppp
//
//  Created by Ensar Batuhan Ünverdi on 17.05.2022.
//

import Foundation

struct Constants {
    static let baseURL = "https://newsapi.org"
    static let APIKey = "bd78b9dc5e2346f7843938f6e73e53ad"
}

class APICaller {
    static let shared = APICaller()
    
    func topHeadlines(completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/v2/top-headlines?country=us&apiKey=\(Constants.APIKey)") else
        {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            if let error = error {
                
                completion(.failure(error))
    
            }else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func searchNews(query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return}
        guard let url = URL(string: "\(Constants.baseURL)/v2/everything?q=\(query)&apiKey=\(Constants.APIKey)") else
        {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
            }else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
}
