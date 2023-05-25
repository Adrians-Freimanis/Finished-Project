//
//  SearchViewController.swift
//  AppleNewsFeed
//
//  Created by adrians.freimanis on 24/05/2023.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    
    private var newsItems: [Article] = []
    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var data =  [Article]()
    
    var filtered = false
    
    
    var filteredData: [Article] = []
    var isFiltering = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        
        setupData()
        
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self
        
        searchBar.placeholder = "Search Articles"

    }
    
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterText(searchText)
    }

    
    private func filterText(_ searchText: String) {
        // Check if searchText is empty
        if searchText.isEmpty {
            isFiltering = false
        } else {
            isFiltering = true
            // Use Swift's `filter` method to filter `newsItems` by `title`
            filteredData = newsItems.filter { article in
                // Return `true` if `article.title` contains `searchText`, `false` otherwise
                // Here, I'm using `localizedCaseInsensitiveContains` to perform a case-insensitive search
                article.title?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
        // Reload the table data on the main thread
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }


    
    

    
    
    
    
    private func setupData(){
        
        NetworkManager.fetchData(url: NewsFeedViewController.initAPI) { newsItems in
            self.newsItems = newsItems.articles ?? []
            dump(self.newsItems)
            DispatchQueue.main.async{
                self.table.reloadData()
            }
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if isFiltering {
                   return filteredData.count
               } else {
                   return 0
               }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DeatilViewController") as? DeatilViewController else { return }
       
        let item = filteredData[indexPath.row]
        vc.titleString = item.title ?? "Title"
        vc.webString = item.url ?? ""
        vc.authorString = item.author ?? "WSJ"
        vc.descString = item.content ?? "Desc"
        vc.imageString = item.urlToImage ?? ""
       
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 383
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        let item = filteredData[indexPath.row]
        cell.searchTitleLabel.text = item.title ?? ""
        cell.searchTitleLabel.numberOfLines = 0
        cell.searchTextView.text = item.description ?? ""
        cell.searchImageView.sd_setImage(with: URL(string: item.urlToImage ?? ""))
        cell.publishedAtLabel.text = item.publishedAt
        cell.sourceLabel.text = item.source?.name
        cell.selectionStyle = .none

        return cell
       
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
