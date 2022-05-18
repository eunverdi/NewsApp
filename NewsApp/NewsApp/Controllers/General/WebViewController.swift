//
//  WebViewController.swift
//  NewsAppp
//
//  Created by Ensar Batuhan Ünverdi on 17.05.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
}
