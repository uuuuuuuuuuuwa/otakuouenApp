//
//  ContentsViewController.swift
//  character_kojinnsakusei
//
//  Created by cl_umeda_004 on 2021/11/17.
//

import UIKit
import AVFoundation
import RealmSwift

class ContentsViewController: UIViewController {
    
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var label:UILabel!
    
    
    var itemTitle: String!
    var itemImage: UIImage!
    var selectedlndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = itemTitle
        
        imageView.image = itemImage
        
    }
    
    
    
    func setupLabelFrame() {
        var fixedFrame = self.label.frame
        self.label.sizeToFit()
        fixedFrame.size.height = self.label.frame.size.height
        self.label.frame = fixedFrame
    }
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


