//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Tatsunori Watabe on 2017/04/27.
//  Copyright © 2017年 konsukeyama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // プロパティ
    // let imageList: [String] = ["inu01", "inu02", "inu03", "inu04", "inu05", "inu06", "inu07", "inu08"]
    let imageList: [String] = ["upa01.jpg", "upa02.jpg", "upa03.jpg", "upa04.jpg"]
    var imageListCnt: Int = 0       // 画像の最大個数
    var imageNumber: Int = 0        // 表示画像番号
    var imageName: String = ""      // 受け渡す画像名
    var playbackChange: Bool = true // 再生ボタン制御用

    // タイマー用インスタンス
    var timer: Timer!
    
    // ビューを接続
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // 画像の数を取得
        imageListCnt = imageList.count

        // 画像を表示
        imageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 画像を表示する
    func imageView() {
        photoView.image = UIImage(named: imageList[imageNumber])
    }
    
    // 画像を変更する（true:進む、false:戻る）　※もう少しうまく書けないだろうか...汗
    func changeImage(upDownFlg: Bool) {
        if upDownFlg == true {
            // 進む
            if imageNumber == (imageListCnt - 1) {
                imageNumber = 0
            } else {
                imageNumber += 1
            }
        } else {
            // 戻る
            if imageNumber == 0 {
                imageNumber = (imageListCnt - 1)
            } else {
                imageNumber -= 1
            }
        }
        imageView()
    }

    // 再生ボタン処理（true:再生、false:停止）
    func playback(playbackFlg: Bool) {
        if playbackFlg == true {
            playButton.setTitle("[ 停止 ■ ]", for: .normal)
            isEnabledButton(viewFlg: false)
            playbackChange = false
            // タイマー開始
            if self.timer == nil {
                timer = Timer.scheduledTimer(
                    timeInterval: 2, // 秒単位
                    target: self,
                    selector: #selector(changeImage),
                    userInfo: true,
                    repeats: true
                )
            }
        } else {
            playButton.setTitle("[ 再生する ▶ ]", for: .normal)
            isEnabledButton(viewFlg: true)
            playbackChange = true
            // タイマー停止
            if self.timer != nil {
                self.timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    // 「<」「>」ボタン表示制御（true:表示、false:非表示）
    func isEnabledButton(viewFlg: Bool) {
        if viewFlg == true {
            backButton.isEnabled = true
            nextButton.isEnabled = true
            backButton.alpha = 1
            nextButton.alpha = 1
        }
        if viewFlg == false {
            backButton.isEnabled = false
            nextButton.isEnabled = false
            backButton.alpha = 0.3
            nextButton.alpha = 0.3
        }
    }

    // 遷移先から戻ってきたときの処理
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }

    // segueで画面遷移するときに呼ばれる（値受け渡し処理など）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 再生ボタンをデフォルト
        playback(playbackFlg: false)
        if segue.identifier == "zoomViewSegue" {
            // segueから遷移先のZoomViewControllerのインスタンスを取得
            let zoomViewController: ZoomViewController = segue.destination as! ZoomViewController
            // 遷移先のZoomViewControllerのプロパティに値を代入
            zoomViewController.zoomImageName = imageList[imageNumber]
        }
    }

    // ボタンアクション
    @IBAction func playButton(_ sender: Any) {
        if playbackChange == true {
            playback(playbackFlg: true) // 再生
        } else {
            playback(playbackFlg: false) // 停止
        }
    }

    @IBAction func backButton(_ sender: Any) {
        changeImage(upDownFlg: false) // 戻る
    }

    @IBAction func nextButton(_ sender: Any) {
        changeImage(upDownFlg: true) // 進む
    }
}

