//
//  NewsFeedViewController.swift
//  AppleNewsFeed
//
//  Created by Arkadijs Makarenko on 10/05/2023.
//

import UIKit
import SDWebImage
import CoreData

class NewsFeedViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    private var newsItems: [Article] = []
    private var sourceItems: [Source] = []
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var authorString: String = String()
    var titleString: String = String()
    var webString: String = String()
    var imageString: String = String()
    var descString: String = String()
    
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    
    
    
    //Journals
    
    static var initAPI = ""
    
    let apiWSJ = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=f9eafead63904cf0800dc486449dc939"
    let apiTechCrunch = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=f9eafead63904cf0800dc486449dc939"
    let apiTesla = "https://newsapi.org/v2/everything?q=tesla&from=2023-05-24&to=2023-05-24&sortBy=popularity&apiKey=f9eafead63904cf0800dc486449dc939"
    
//    let apiUSHeadlines = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f9eafead63904cf0800dc486449dc939"
//    let apiApple = "https://newsapi.org/v2/everything?q=apple&from=2023-05-24&to=2023-05-24&sortBy=popularity&apiKey=f9eafead63904cf0800dc486449dc939"
//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Code from diffrent aproach
        
        // Create a UIButton with a custom title for the left button
        
        
//            let leftButton = UIButton(type: .system)
//            leftButton.setTitle("Tesla", for: .normal)
//        // Set button leftbutton font to bold
//        leftButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
//            leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
            
        
        
            // Create a UIButton with a custom title for the right button
        
        
//            let rightButton = UIButton(type: .system)
//            rightButton.setTitle("TechC", for: .normal)
//        rightButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
//            rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        
            
            // Create a UIBarButtonItem with the left button as a custom view
//            let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
            
            // Create a UIBarButtonItem with the right button as a custom view
        
//            let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
            
            // Set the left and right buttons as the navigation items
//            navigationItem.leftBarButtonItem = leftBarButtonItem
        
//            navigationItem.rightBarButtonItem = rightBarButtonItem
          
       
        // Create a UIButton with a custom title
//        let titleButton = UIButton(type: .system)
//        titleButton.setTitle("News", for: .normal)
//
//        // Set button title color to black
//           titleButton.setTitleColor(.black, for: .normal)
//
//           // Set button title font to bold
//           titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
//
//
//        titleButton.addTarget(self, action: #selector(titleButtonTapped), for: .touchUpInside)
//
//
//
//        // Set the button as the custom view for the title
//        navigationItem.titleView = titleButton
        
        
        NewsFeedViewController.initAPI = apiWSJ
        
        title = "News Feed"
        getNewsData(initAPI: NewsFeedViewController.initAPI)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
//        updateDetails()
    }
    
    

    @IBAction func JournalButtonTapped(_ sender: Any) {
        
        basicActionSheet(title: "We provide these news publishers", message: "Choose one: ")
        
    }
    
    
    
    
    
    
    
    
    
    
//    Diffrent aproach for switching newspapers
    
//
//    @objc func titleButtonTapped() {
//        // Set initAPI to apiWSJ
//        NewsFeedViewController.initAPI = apiWSJ
//        reloadData()
//    }
//
//
//    @objc func leftButtonTapped() {
//        // Set initAPI to apiTesla
//        NewsFeedViewController.initAPI = apiTesla
//            reloadData()
//    }
//
//    @objc func rightButtonTapped() {
//        // Set initAPI to apiTechCrunch
//        NewsFeedViewController.initAPI = apiTechCrunch
//           reloadData()
//    }
//
    
    
    func reloadData() {
        // Call the method to fetch news data using the updated initAPI value
        getNewsData(initAPI: NewsFeedViewController.initAPI)
    }
    
    
    
    
    


//For future upgrades
    
    
//    func saveData(){
////#warning("save into core data")
//        do {
//            try context?.save()
//            basicAlert(title: "Saved!", message: "\(titleString) has been saved. Go to Saved Tab Tar Setcion to open it.")
//        }catch {
//            print(error)
//        }
//    }
    
    
    
//    func updateDetails(){
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
//               return UITableViewCell()
//           }
//
//
//        newsTitleLabel.text = titleString
//        newsImageView.sd_setImage(with: URL(string: imageString))
//        descTextView.text = descString
//    }
    
    
//    @IBAction func saveButtonPressed(_ sender: Any) {
//
//        let newItem = Items(context: self.context!)
//        newItem.newsAuthor = authorString
//        newItem.newsContent = descString
//        newItem.newsTitle = titleString
//        newItem.url = webString
//        if !imageString.isEmpty {
//            newItem.image = imageString
//        }
//
//        self.savedItems.append(newItem)
//
//        saveData()
//
//    }
    
    private func activityIndicator(animated: Bool) {
        DispatchQueue.main.async{
            if animated {
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.startAnimating()
            }else{
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    private func getNewsData(initAPI: String){
        
        activityIndicator(animated: true)
        
        NetworkManager.fetchData(url: initAPI) { newsItems in
            self.newsItems = newsItems.articles ?? []
            dump(self.newsItems)
            DispatchQueue.main.async{
                self.tblView.reloadData()
                self.activityIndicator(animated: false)
            }
        }
    }

}//class

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        
        let item = newsItems[indexPath.row]
        
        cell.newsTitleLabel.text = item.title ?? ""
        cell.newsTitleLabel.numberOfLines = 0
        cell.newsTextView.text = item.description ?? ""
        cell.newsImageView.sd_setImage(with: URL(string: item.urlToImage ?? ""))
        cell.newsSourceLabel.text = item.source?.name
        cell.newsPublishedAtLabel.text = item.publishedAt
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 383
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DeatilViewController") as? DeatilViewController else { return }
       
        let item = newsItems[indexPath.row]
        vc.titleString = item.title ?? "Title"
        vc.webString = item.url ?? ""
        vc.authorString = item.author ?? "WSJ"
        vc.descString = item.content ?? "Desc"
        vc.imageString = item.urlToImage ?? ""
        
//#warning("item passed")
        
//        present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension NewsFeedViewController {

    private func basicActionSheet(title: String?, message: String?) {
        DispatchQueue.main.async {
            let actionSheet: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let action1: UIAlertAction = UIAlertAction(title: "WSJ", style: .default) { _ in
                self.handleWSJSelection()
            }
            let action2: UIAlertAction = UIAlertAction(title: "Tesla News", style: .default) { _ in
                self.handleTeslaSelection()
            }
            let action3: UIAlertAction = UIAlertAction(title: "Tech Crunch", style: .default) { _ in
                self.handleTechCrunchSelection()
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.overrideUserInterfaceStyle = .dark
            
            actionSheet.addAction(cancelAction)
            actionSheet.addAction(action1)
            actionSheet.addAction(action2)
            actionSheet.addAction(action3)
            
            self.present(actionSheet, animated: true)
        }
    }
    
    private func handleWSJSelection() {
        NewsFeedViewController.initAPI = apiWSJ
        reloadData()
    }
    
    private func handleTeslaSelection() {
        NewsFeedViewController.initAPI = apiTesla
        reloadData()
    }
    
    private func handleTechCrunchSelection() {
        NewsFeedViewController.initAPI = apiTechCrunch
        reloadData()
    }
}
