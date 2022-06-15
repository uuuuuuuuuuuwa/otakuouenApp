//
//  ViewController.swift
//  techpod
//
//  Created by cl_umeda_004 on 2021/09/09.
//

import UIKit
import AVFoundation


class ViewController: UIViewController,UITableViewDelegate, UITextFieldDelegate {
    
    //StoryBoardで扱う TableViewを宣言
    var addButtonItem: UIBarButtonItem!
    
    @IBOutlet var table: UITableView!
    
    var NameArray = [String]()
    var selectedIndex = 0
    var array = [Int](0..<10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addButtonItem = UIBarButtonItem(barButtonSystemItem:  .add, target: self, action: #selector(addBarbuttonTapped(_:)))
        
        
        self.navigationItem.rightBarButtonItems = [addButtonItem]
        
        
        
        //テーブルビューのデータソースメソッドはviewcontrollerクラスに書くよ、と言う設定
        table.dataSource = self
        table.delegate = self
        table.tableFooterView = UIView(frame: .zero)
        
        
        //NameArray = []
        
        // ふやす
        //　プラスマークを押したときにコードが読まれる
        // NameArray.append("+")
        //table.reloadData()
    }
    
    
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
                    self.NameArray.append(alert.textFields?.first?.text ?? "")
                    self.table.reloadData()
                }
            )
            //            { _ in
            //                    if let text = alertTextField!.text {
            //                        self.NameArray.append(text)
            //                        self.table.reloadData()
            //                    }}
            
        )
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    //セルの数を設定
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        
        //セルの数をsongNameArrayの数にする
        return NameArray.count
    }
    
    //ID付きのセルを取得して、セル付属textLabelに「テスト」と表示させてみる
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        
        cell?.textLabel?.text = NameArray[indexPath.row]
        
        
        //     cell?.textLabel?.text = "tesuto"
        return cell!
        
        
        
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath:IndexPath)  {
        print("\(NameArray[indexPath.row])が選ばれました！")
        selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "toContents", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contentVC = segue.destination as? ContentsViewController
        contentVC?.selectedlndex = selectedIndex
        
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
            self.NameArray.remove(at: indexPath.row)
            // tableView.beginUpdates()
            self.table.deleteRows(at: [indexPath], with: .automatic)
            self.table.reloadData()
            //tableView.endUpdates()
        }))
        dialog.addAction(UIAlertAction(title: "戻る", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
}





