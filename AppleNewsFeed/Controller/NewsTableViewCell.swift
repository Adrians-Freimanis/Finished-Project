//
//  NewsTableViewCell.swift
//  AppleNewsFeed
//
//  Created by adrians.freimanis on 19/05/2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {


    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTextView: UITextView!
    
    
    
    @IBOutlet weak var searchImageView: UIImageView!
    
    @IBOutlet weak var searchTitleLabel: UILabel!
    
    
    @IBOutlet weak var searchTextView: UITextView!
    
    
    
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    
    
    @IBOutlet weak var newsPublishedAtLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
}
