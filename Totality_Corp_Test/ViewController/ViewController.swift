//
//  ViewController.swift
//  Totality_Corp_Test
//
//  Created by shashank atray on 02/02/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var feedData: [FeedData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetUp()
        getJson()
        // Do any additional setup after loading the view.
    }
    
    
    func getJson() {
        guard let json = defractorJson(text: "feed")?.first else {
            print("Could not find json file:")
            return
        }
        
        self.feedData = self.feedDataGetter(feedData: json.value as! [AnyObject])
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func feedDataGetter(feedData: [AnyObject]) -> [FeedData] {
          
          let feedDataValues: [FeedData] = feedData.map { photoDictionary in
              
              let photoId = photoDictionary["id"] as? String ?? ""
              let time = photoDictionary["time"] as? String ?? ""
              let vUrl = photoDictionary["vUrl"] as? String ?? ""
              let userImageUrl = photoDictionary["userImageUrl"] as? String ?? ""
              let userName = photoDictionary["userName"] as? String ?? ""
              
              let feedData = FeedData(id: photoId, time: time, videoUrl: vUrl, imageUrl: userImageUrl, name: userName)
                return feedData
          }
          return feedDataValues
      }
    
    
    func collectionViewSetUp() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.reloadData()
        collectionView!.collectionViewLayout = layout
    }
    
}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bodyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell",for: indexPath) as! CollectionViewCell
        
        if let url = URL(string: self.feedData[indexPath.row].videoUrl) {
            let player = AVPlayer(url: url)
            let playerController = AVPlayerViewController()
            playerController.player = player
            self.addChild(playerController)
            playerController.showsPlaybackControls = false
            bodyCell.avPlayerView.addSubview(playerController.view)
            playerController.view.frame = CGRect(x: 0, y: 0, width: bodyCell.frame.size.width,  height: bodyCell.frame.size.height)
            playerController.videoGravity = AVLayerVideoGravity.resizeAspectFill
            playerController.view.sizeToFit()
            player.play()
        }
        bodyCell.setupDataValue(feedData: self.feedData[indexPath.row] )
        
        // bodyCell.setupWithPhoto(flickrPhoto: self.photos[indexPath.row] as! FlickrPhoto)
        return bodyCell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        guard collectionView.cellForItem(at: indexPath) != nil else { return false }

             let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileDataViewController") as! ProfileDataViewController
             self.present(vc, animated: true, completion: nil)
        
        return true
        
    }
}



