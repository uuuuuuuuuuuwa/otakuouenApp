//
//  ViewController2.swift
//  character_kojinnsakusei
//
//  Created by cl_umeda_004 on 2022/05/24.
//

import UIKit
import AVFoundation



class ViewController2: UIViewController,UITableViewDelegate {
    
    //StoryBoardで扱う TableViewを宣言
    
    @IBOutlet var table: UITableView!
    
    
    var NameArray = [String]()
    var selectedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //テーブルビューのデータソースメソッドはviewcontrollerクラスに書くよ、と言う設定
        table.dataSource = self
        table.delegate = self
        
        
        
        NameArray = ["a","b","c","d","e"]
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
extension ViewController2: UITableViewDataSource{
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






// Do any additional setup after loading the view.



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


