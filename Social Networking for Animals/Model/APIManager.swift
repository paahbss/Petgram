//
//  APIManager.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 22/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    
    static func downloadImage(from urlSring: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        guard let url = URL(string: urlSring) else {return}
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                completion(nil, error)
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil, error)
                return
            }
            completion(image, nil)
            }.resume()
        
    }
    
    static func getRandonFox(urlString: String = "https://randomfox.ca/floof/", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                completion(error, nil)
            }
            guard let data = data else {
                completion(error, nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Fox.self, from:
                    data)
                guard let imageURL = model.image else {
                    completion(error, nil)
                    return
                    
                }
                downloadImage(from: imageURL, completion: { (image, error) in
                    if error != nil {
                        completion(error, nil)
                    }
                    guard let image = image else {
                        completion(error, nil)
                        return
                    }
                    completion(nil, image)
                    
                })
    
            } catch let err {
                completion(err, nil)
            }
            }.resume()
    }
    
    static func getRandonDog(urlString: String = "https://random.dog/woof.json", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                completion(error, nil)
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Dog.self, from:
                    data)
                guard let imageURL = model.url else {return}
                downloadImage(from: imageURL, completion: { (image, error) in
                    if error != nil {
                        completion(error, nil)
                    }
                    guard let image = image else {
                        completion(error, nil)
                        return
                    }
                    completion(nil, image)
                    
                })
            } catch let err {
                completion(err, nil)
            }
            }.resume()
    }
    
    static func getRandonCat(urlString: String = "https://aws.random.cat/meow", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                completion(error, nil)
            }
            guard let data = data else {
                print("invalid data")
                return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Cat.self, from:
                    data)
                guard let imageURL = model.file else {return}
                downloadImage(from: imageURL, completion: { (image, error) in
                    if error != nil {
                        completion(error, nil)
                    }
                    guard let image = image else {
                        completion(error, nil)
                        return
                    }
                    completion(nil, image)
                    
                })
            } catch let err {
                completion(err, nil)
            }
            }.resume()
    }


}