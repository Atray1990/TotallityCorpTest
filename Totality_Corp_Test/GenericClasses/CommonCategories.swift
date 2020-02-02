//
//  CommonCategories.swift
//  Totality_Corp_Test
//
//  Created by shashank atray on 02/02/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation
import UIKit

extension NSObject{

    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        
        if let data = (text as AnyObject).data(using: String.Encoding.utf8.rawValue){
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                
                return json
                
            } catch {
                return nil
            }
        }
        return nil
    }
    
    
    func defractorJson(text: String) -> [String:AnyObject]? {
        
        if let path = Bundle.main.path(forResource: text, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                    return json
                    
                } catch {
                    return nil
                }
            }
            return nil
        }
        
}



// Uiimage view
extension UIImageView
{
    func DownloadImageForCollectionView (from url : String, completion: ((_ errorMessage: String?) -> Void)?){
        if url.count == 0
        {
            return
        }
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest){ (data,response,error) in
            
            if error != nil {
                completion?("error...")
            }
            
            DispatchQueue.main.async {
                if data != nil{
                    self.image = UIImage(data:data!)
                    
                }
                completion?(nil)
            }
        }
        
        task.resume()
    }
}

// value or states of string

extension String
{
    func trimmedString() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
}


