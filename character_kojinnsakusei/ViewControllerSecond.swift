//
//  ContentsViewController.swift
//  character_kojinnsakusei
//
//  Created by cl_umeda_004 on 2021/11/17.
//

import UIKit
import AVFoundation


class ViewControllerSecond: UIViewController {
    
    @IBOutlet var imageView:UIImageView!
   @IBOutlet var label:UILabel!
    
    var imageArray = ["進撃の巨人.jpeg","小林さんちのメイドラゴンs  ２.jpeg","ポケモン.jpeg","七つの大罪.jpeg","斉木楠雄のΨ難.jpeg"]
   
    var contemtsArray = ["こんにちは","hello","yaaaa","waaaaa","booo!"]
    
    var selectedlndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = contemtsArray[selectedlndex]
        
        imageView.image = UIImage(named: imageArray[selectedlndex])
        
     
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
    

