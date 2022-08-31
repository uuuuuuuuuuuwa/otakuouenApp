//
//  ViewController.swift
//  otakatu_1
//
//  Created by clark on 2022/05/10.
//

import UIKit
import SafariServices
import RealmSwift


class YahooViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, SFSafariViewControllerDelegate, UIViewControllerTransitioningDelegate {
   
    //StoryBoardで扱う TableViewを宣言
    var otakatuList : [ItemJson] = []
    var addButtonItem: UIBarButtonItem!
    let realm = try! Realm()
    var items: List<Item>!
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?{
        
        
        // 編集処理
        
        let editAction = UIContextualAction(style: .normal, title: "追加") { (action, view, completionHandler) in
            
            // 編集処理を記述
            print("追加がタップされた")
            
            
            
            
            // 実行結果に関わらず記述
            completionHandler(true)
            
            
            let item = Item()
            
            
            try! self.realm.write(){
                item.apitype = "Yahooo"
                item.id = ""
                item.name = self.otakatuList[indexPath.row].name
                
                self.realm.add(item)
                print(item)
                
           
                
                
//                if self.items == nil {
//                    let favorite = Favorite()
//                    favorite.Items.append(item)
//                    self.realm.add(favorite)
//                    self.items = self.realm.objects(Favorite.self).first?.Items
//                    print(self.items!)
//
//                } else {
//                    self.items.append(item)
//                }
            }
            
//            let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "items")
//            modalVC!.modalPresentationStyle = .fullScreen
//            modalVC!.transitioningDelegate = self
//            self.present(modalVC!, animated: true, completion: nil)
        }
        
        //Reaim 追加
        
//        let item = Item()
//
//        try! self.realm.write(){
//            if self.items == nil {
//                let favorite = Favorite()
//                favorite.Items.append(item)
//                self.realm.add(favorite)
//                self.items = self.realm.objects(Favorite.self).first?.Items
//                print(self.items!)
//
//            } else {
//                self.items.append(item)
//            }
//        }
            editAction.backgroundColor = UIColor.green
            // 定義したアクションをセット
            return UISwipeActionsConfiguration(actions: [editAction])
        
    }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            addButtonItem = UIBarButtonItem(barButtonSystemItem:  .add, target: self, action: #selector(addBarbuttonTapped(_:)))
            
            
            self.navigationItem.rightBarButtonItems = [addButtonItem]
            
            
            
            searchText.delegate = self
            
            searchText.placeholder = "お探しの商品名を入力してください"
            
            tableView.dataSource = self
            
            tableView.delegate = self
            
        }
        
        @IBOutlet weak var searchText: UISearchBar!
        
        @IBOutlet weak var tableView: UITableView!
        

        
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            view.endEditing(true)
            
            if let searchWord = searchBar.text {
                
                
                print(searchWord)
                
                searchOtakatu(keyword: searchWord)
            }
        }
        //test
        struct ItemJson: Codable {
            
            let name: String
            
            let price: Int
            
            let url: URL
            
            let image: Image
            
            let code: String
            
        }
        
        struct Image: Codable {
            
            let medium: URL?
            
        }
        
        struct ResultJson: Codable {
            
            let hits:[ItemJson]?
        }
        
        func searchOtakatu(keyword: String) {
            
            guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                return
            }
            
            guard let req_url = URL(string: "https://shopping.yahooapis.jp/ShoppingWebService/V3/itemSearch?appid=dj00aiZpPTFFaGZqMTROaFhweCZzPWNvbnN1bWVyc2VjcmV0Jng9MmQ-&query=\(keyword_encode)") else {
                
                return
            }
            
            print(req_url)
            
            
            let req = URLRequest(url: req_url)
            
            let session = URLSession(configuration: .default, delegate: nil,delegateQueue: OperationQueue.main)
            
            let task = session.dataTask(with: req, completionHandler: {
                (data , responese , error) in
                
                session.finishTasksAndInvalidate()
                
                do{
                    
                    let decoder = JSONDecoder()
                    
                    print(data)
                    
                    let str = String(decoding: data!, as: UTF8.self)
                    
                    print(str)
                    
                    let json = try decoder.decode(ResultJson.self, from: data!)
                    
                    print(json)
                    
                    if let items = json.hits {
                        
                        self.otakatuList.removeAll()
                        
                        self.otakatuList = items
                        dump(self.otakatuList)
                        
                        self.tableView.reloadData()
                        
                    }
                } catch(let error) {
                    
                    
                    
                    print(String(describing: error))
                    print("エラーが出ました")
                }
            })
            
            task.resume()
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return otakatuList.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "otakatuCell", for: indexPath)
            
            cell.textLabel?.text = otakatuList[indexPath.row].name
            
            if let imageURL = otakatuList[indexPath.row].image.medium {
                
                let data = try? Data(contentsOf: imageURL)
                
                if let image = data{
                    
                    cell.imageView?.image = UIImage(data: image)
                    
                }
                
                
            }
            
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            let safariViewController = SFSafariViewController(url: otakatuList[indexPath.row].url)
            
            safariViewController.delegate = self
            
            present(safariViewController, animated: true, completion: nil)
            
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            
            dismiss(animated: true, completion: nil)
            
        }
        
        //    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //        let swipeCellA = UITableViewRowAction(style: .default, title: "追加") { action, index in
        //            self.swipeContentsTap(content: "otakatuCell", index: index.row)
        //        }
        //
        //        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //            return true
        //        }
        //
        //    }
        @objc func addBarbuttonTapped(_ sender: UIBarButtonItem){
            print("プラスボタンが押された")
            var inputText: String!
            
            let alert = UIAlertController(
                title: "Edit Name",
                message: "Enter new name",
                preferredStyle: UIAlertController.Style.alert)
            
            alert.addTextField(
                configurationHandler: {(textField: UITextField!) in
                    inputText = textField.text
                    //                    alertTextField = textField
                    //                    self.NameArray.append("+")
                    //                    self.table.reloadData()
                    // textField.placeholder = "Mike"
                    // textField.isSecureTextEntry = true
                })
            alert.addAction(
                UIAlertAction(
                    title: "Cancel",
                    style: UIAlertAction.Style.cancel,
                    handler: nil))
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: {text -> Void in
                        print(inputText)
                        //  alert.textFields?.first.text
                        //                    self.NameArray.append(alert.textFields?.first?.text ?? "")
                        //                    self.table.reloadData()
                    }
                )
                
                
            )
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
