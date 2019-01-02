//
//  ViewMain.swift
//  projectGame-iOS
//
//  Created by Ryo Rogueknight on 10/29/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewMain: UIViewController {
    
    @IBOutlet weak var btnTapToPlay: UIButton!
    @IBOutlet weak var btnShop: UIButton!
    @IBOutlet weak var btnTop: UIButton!
    
    @IBOutlet weak var Coin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDisplay()
        let userId = UserDefaults.standard.object(forKey: "UserId") as? String
        if userId == nil || userId == "1" {
            btnTop.isHidden = true
            btnShop.isHidden = true
        }
    }
    func setupDisplay() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "m-background")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        btnTapToPlay.setBackgroundImage(UIImage(named: "taptoplay.png"), for: UIControl.State.normal)
        btnTop.setBackgroundImage(UIImage(named: "top.png"), for: .normal)
        btnShop.setBackgroundImage(UIImage(named: "shop.png"), for: .normal)
        
        let numberCoin: Int = UserDefaults.standard.integer(forKey: "Coin")
        Coin.setTitle(String(numberCoin), for: .normal)
    }

}


