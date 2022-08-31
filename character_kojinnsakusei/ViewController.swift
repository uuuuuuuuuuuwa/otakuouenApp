//
//  ViewController.swift
//  techpod
//
//  Created by cl_umeda_004 on 2021/09/09.
//

import UIKit
import AVFoundation
import RealmSwift


class ViewController: UIViewController,UITableViewDelegate, UITextFieldDelegate {
    
    //StoryBoardで扱う TableViewを宣言
  //  var addButtonItem: UIBarButtonItem!
    
    @IBOutlet var table: UITableView!
    
    var name: String!
    var image: String!
    
    var NameArray = [String]()
    var selectedIndex = 0
    var array = [Int](0..<10)
    var itemName: String!
    
    let realm = try! Realm()
    var items: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
//        addButtonItem = UIBarButtonItem(barButtonSystemItem:  .add, target: self, action: #selector(addBarbuttonTapped(_:)))
       // self.navigationItem.rightBarButtonItems = [addButtonItem]
        //テーブルビューのデータソースメソッドはviewcontrollerクラスに書くよ、と言う設定
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView(frame: .zero)
        
        let result = realm.objects(Item.self)
        items = result
        NameArray = ["食べ物","ファッション","あ"]
        self.table.reloadData()
    }
    
    // プラスボタンの処理

    //extension ViewController {
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

                    // self.NameArray.append(alert.textFields?.first?.text ?? "")
                    // self.table.reloadData()

                    //Reaim 追加

                    let item = Item()

                    try! self.realm.write(){
                        if self.items == nil {
                            let favorite = Favorite()
                            favorite.items.append(item)
                            self.realm.add(favorite)
                            self.items = self.realm.objects(Item.self)
                            print(self.items!)

                        } else {
//                            self.items.append(item)
                        }
                    }
                }
            )
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    //セルの数を設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //セルの数をsongNameArrayの数にする
        return realm.objects(Item.self).count
    }
    
    //ID付きのセルを取得して、セル付属textLabelに「テスト」と表示させてみる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath)  {
        print("\(items[indexPath.row])が選ばれました！")
        selectedIndex = indexPath.row
        itemName = items[indexPath.row].name
        
        performSegue(withIdentifier: "toContents", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contentVC = segue.destination as? ContentsViewController
        contentVC?.selectedlndex = selectedIndex
        contentVC?.itemTitle = itemName
    }
}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "削除") { (action, view, completionHandler) in
            self.showAlert(deleteIndexPath: indexPath)
            completionHandler(true)
        }
        action.backgroundColor = .orange
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    func showAlert(deleteIndexPath indexPath: IndexPath) {
        let dialog = UIAlertController(title: "削除",
                                       message: "本当に削除しますか？",
                                       preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "削除", style: .default, handler: { (_) in
            // 後で書き換える
//            self.items.remove(at: indexPath.row)
            // tableView.beginUpdates()
            self.table.deleteRows(at: [indexPath], with: .automatic)
            self.table.reloadData()
            //tableView.endUpdates()
        }))
        dialog.addAction(UIAlertAction(title: "戻る", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    
    
    
}


