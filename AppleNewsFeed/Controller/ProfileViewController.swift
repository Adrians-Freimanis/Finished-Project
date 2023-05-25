//
//  ProfileViewController.swift
//  AppleNewsFeed
//
//  Created by adrians.freimanis on 25/05/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var articlesLabel: UILabel!
    
    @IBOutlet weak var activityLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        // Set up values
           nameLabel.text = "Adrians Freimanis"
           articlesLabel.text = "Following 3 articles!"
           activityLabel.text = "Currently: online"
           
        // Set the image of the imageView
           let image = UIImage(named: "profile_image")
           profileImageView.image = image
        
    }
    

}
