//
//  Model.swift
//  NewsAppp
//
//  Created by Ensar Batuhan Ünverdi on 17.05.2022.
//

import Foundation

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let url: String
    let urlToImage: String?
    let description: String?
    }

