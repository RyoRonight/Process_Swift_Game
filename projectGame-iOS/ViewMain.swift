//
//  ViewMain.swift
//  projectGame-iOS
//
//  Created by Ryo Rogueknight on 10/29/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import UIKit

class ViewMain: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var btnTapToPlay: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDisplay() {
        background.image = UIImage(named: "m-background.png")
        btnTapToPlay.setBackgroundImage(UIImage(named: "taptoplay.png"), for: UIControlState.normal)
    }

}


