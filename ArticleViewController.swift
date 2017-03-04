//
//  ArticleViewController.swift
//  Hotnews
//
//  Created by Eddey on 2016/11/3.
//  Copyright © 2016年 EDP. All rights reserved.
//

import UIKit
import SafariServices


class ArticleViewController: UIViewController {

    @IBOutlet weak var converImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var article = [String: Any]()
    var testAS = [URL: Any]()
    let shareLine = [String: Any]()
    
    func shareButton(){
        print("dd")
        
        //let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //self.present(actionSheet, animated: true, completion: nil)
        
        if let url = article["url"] as? String{
            
            //let urlToShare = [ url ]
            
            let alert = UIAlertController(title: "Share", message: nil, preferredStyle: .actionSheet)
        
            alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (UIAlertAction) in
            
                UIPasteboard.general.string = url
                print(url)
            
            }))
            
            
            alert.addAction(UIAlertAction(title: "Open in Safari", style: .default, handler: { (UIAlertAction) in
               
                let url = URL(string: url)!
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
                
            }))
            
            alert.addAction(UIAlertAction(title: "於LINE分享網址", style: .default, handler: { (UIAlertAction) in
                
                let url = URL(string: "line://msg/text\(url)")!
                
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            }))
        
        
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        
            self.present(alert, animated: true, completion: nil)
        
        
        }
        
        
        
//        if let url = article["url"] as? String{
//            
//            let urlToShare = [ url ]
//            
//            let activityViewController = UIActivityViewController(activityItems: urlToShare, applicationActivities: nil)
//        
//         
//            // present the view controller
//            self.present(activityViewController, animated: true, completion: nil)
//        
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(ArticleViewController.shareButton))
        navigationItem.rightBarButtonItem = shareButton
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        print("\(article)")
        
        headingLabel.text = article["heading"] as? String
        contentLabel.text = article["content"] as? String
        
        downloadImage()
        
    }
    
    func downloadImage(){
        
        
        if let imageURLString = article["imageUrl"] as? String, let imageURL = URL(string: imageURLString){
        
            //data,response,error皆為optional, 條件：沒有error,data,responeru就不是nil, 所以只要確定有data就沒有error
            let task = URLSession.shared.dataTask(with: imageURL) {data, response, error in
                
                if let imageData = data{
                
                    // 主線道 避免文字出現圖片還沒出現
                    DispatchQueue.main.async {
                        self.converImageView.image = UIImage(data: imageData)

                    }
                    
                }
            }
            
            task.resume()
            
        }
    }
    
    
    
}
