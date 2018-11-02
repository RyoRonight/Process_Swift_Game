//
//  PopUpViewController.swift
//  projectGame-iOS
//
//  Created by Ryo Rogueknight on 11/2/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var imgBgSetting: UIImageView!
    @IBOutlet weak var btnNewGame: UIButton!
    @IBOutlet weak var btnQuit: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        setupDisplay()
        setTitleBtn()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickBtnBack(_ sender: Any) {
        removeAnimate()
    }
    
    private func setupDisplay() {
        imgBgSetting.image = UIImage(named: "layer 1.png")
        btnNewGame.setBackgroundImage(UIImage(named: "layer 3.png"), for: .normal)
        btnBack.setBackgroundImage(UIImage(named: "layer 3.png"), for: .normal)
        btnQuit.setBackgroundImage(UIImage(named: "layer 3.png"), for: .normal)
    }
    
    private func setTitleBtn() {
        btnNewGame.setTitle("New Game", for: .normal)
        btnQuit.setTitle("Quit", for: .normal)
        btnBack.setTitle("Back", for: .normal)
        
        btnNewGame.setTitleColor(UIColor(red: 0.0431, green: 0, blue: 0.8667, alpha: 1.0), for: .normal)
        btnQuit.setTitleColor(UIColor(red: 0.0431, green: 0, blue: 0.8667, alpha: 1.0), for: .normal)
        btnBack.setTitleColor(UIColor(red: 0.0431, green: 0, blue: 0.8667, alpha: 1.0), for: .normal)
        
        btnNewGame.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 3))
        btnQuit.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 3))
        btnBack.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 3))
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    private func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    public func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
