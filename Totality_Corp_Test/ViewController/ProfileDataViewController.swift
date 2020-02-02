//
//  ProfileDataViewController.swift
//  Totality_Corp_Test
//
//  Created by shashank atray on 02/02/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import UIKit

class ProfileDataViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileDataCollectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton!
    
    var postData: [profileData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        setUp()
        getJson()
    }
    
    func uiSetUp() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        closeButton.layer.cornerRadius = closeButton.frame.size.width/2
    }
    
    // json changes to wrap the value
    func getJson() {
        guard let json = defractorJson(text: "userprofile") else {
            print("Could not find json file:")
            return
        }
        print(json)
        
        self.nameLabel.text = (json["userName"] as! String)
        profileImageView.DownloadImageForCollectionView(from: json["userImageUrl"] as! String) { (err) in
            if err != nil {
                
            }
        }
        
        self.postData = self.profileDataGetter(feedData: json["posts"] as! [AnyObject])
        
        DispatchQueue.main.async {
            self.profileDataCollectionView.reloadData()
        }
    }
    
    func profileDataGetter(feedData: [AnyObject]) -> [profileData] {
        let postDataValues: [profileData] = feedData.map { photoDictionary in
            let photoId = photoDictionary["id"] as? String ?? ""
            let userImageUrl = photoDictionary["userImageUrl"] as? String ?? ""
            let feedData = profileData(id: photoId, imageUrl: userImageUrl)
            return feedData
        }
        return postDataValues
    }
    
    func setUp() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: (self.view.frame.width - 15)/2, height: (self.view.frame.width - 15)/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.profileDataCollectionView.reloadData()
        
        profileDataCollectionView!.collectionViewLayout = layout
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        closeButton.layer.cornerRadius = closeButton.frame.size.width/2
    }
    
    @IBAction func closeButtonCalled(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ProfileDataViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
 // was using this to add the subsection but seems like there is an generic error that doesnt allow these function to be called as per now. https://bugs.swift.org/browse/SR-2817
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        headerView.stringValue = "anything for testing right now"
            return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let bodyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell",for: indexPath) as! ProfileCollectionViewCell
        bodyCell.setupWithPhoto(profileValues: self.postData[indexPath.row] )
        return bodyCell
    }
    
}

extension ProfileDataViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        print("anything")
        return CGSize(width: collectionView.frame.size.width , height: 70)
    }

}

