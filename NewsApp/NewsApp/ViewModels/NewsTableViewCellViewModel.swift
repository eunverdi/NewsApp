//
//  NewsTableViewCellViewModel.swift
//  NewsAppp
//
//  Created by Ensar Batuhan Ünverdi on 17.05.2022.
//

import Foundation

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(titleInıt: String, subtitleInıt: String, imageURlInıt: URL?) {
        self.title = titleInıt
        self.subtitle = subtitleInıt
        self.imageURL = imageURlInıt
    }
}
