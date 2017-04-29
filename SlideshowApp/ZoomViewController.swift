//
//  ZoomViewController.swift
//  SlideshowApp
//
//  Created by Tatsunori Watabe on 2017/04/28.
//  Copyright © 2017年 konsukeyama. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {

    // 遷移元から受け取るためのプロパティ
    var zoomImageName: String = ""
    
    // ビューを接続
    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        photoView.image = UIImage(named: zoomImageName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
