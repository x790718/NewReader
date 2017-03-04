//
//  ArticleListViewController.swift
//  Hotnews
//
//  Created by Eddey on 2016/11/3.
//  Copyright © 2016年 EDP. All rights reserved.
//

import UIKit

class ArticleListViewController: UITableViewController {
    
    let latestURL = URL(string: "https://hpd-iosdev.firebaseio.com/news/latest.json")!
    let dateFormatter = DateFormatter()
    
    var articles = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        downloadLatestNews()
        
        print("viewdidload")
        
    }

    
    
    
    func downloadLatestNews(){
    
        let sharedSession = URLSession.shared
        
        let task = sharedSession.dataTask(with: latestURL) { data, response, error in
            
            if let data = data{
            
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), let articles = jsonObject as? [[String: Any]]{
                    
                    print("新聞下載完")
                    
                    self.articles = articles
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    /*print("\(articles)")
                
                    for article in articles{
                    
                        print(article["heading"] as? String)
                    
                    
                    }*/
                }
            }
        }
        task.resume()   //開始下載
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        
        let article = articles[indexPath.row]
        
        let publishedDateMS = article["publishedDate"] as! Int
        
        let publishedDate = NSDate(timeIntervalSince1970: Double(publishedDateMS) / 1000.0)
        
        let publishedDateString = dateFormatter.string(from: publishedDate as Date)
        

        
        cell.textLabel?.text = article["heading"] as? String
        cell.detailTextLabel?.text = publishedDateString

        
        return cell
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {       //sender:是誰轉過來的
        if segue.identifier == "showArticle"{
        
        
            print("顯示新聞內容")
            
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!  //一定有資料所以可以直接用"！"硬拆
            let article = articles[indexPath.row]
            
            //print("\(article["heading"])")
            
            
            //連接轉到下個頁面
            let articleVC = segue.destination as! ArticleViewController
            
            articleVC.article = article
            
            
            
        }
    }
    
    
    
    
    
    
    
    

}
