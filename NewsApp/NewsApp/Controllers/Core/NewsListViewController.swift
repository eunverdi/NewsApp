//
//  NewsListViewController.swift
//  NewsAppp
//
//  Created by Ensar Batuhan Ünverdi on 17.05.2022.
//

import UIKit


class NewsListViewController: UIViewController {
    
    private let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Search a news"
        search.searchBar.searchBarStyle = .minimal
        return search
    }()
    
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(newsTableView)
        
        title = "News"
        view.backgroundColor = .systemBackground
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self


        fetchData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.frame = view.bounds
    }
    
    func fetchData() {
        
        APICaller.shared.topHeadlines { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({ model in
                    NewsTableViewCellViewModel(
                        titleInıt: model.title ,
                        subtitleInıt: model.description ?? "Unknown",
                        imageURlInıt: URL(string: model.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }

    }

}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell()}
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ) else {
            return
        }
        
        let vc = WebViewController()
        vc.webView.load(URLRequest(url: url))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        APICaller.shared.searchNews(query: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({ models in
                    NewsTableViewCellViewModel(
                        titleInıt: models.title,
                        subtitleInıt: models.description ?? "",
                        imageURlInıt: URL(string: models.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.newsTableView.reloadData()
                    self?.searchController.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

