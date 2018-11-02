//
//  ViewPlayNow.swift
//  projectGame-iOS
//
//  Created by Ryo Rogueknight on 10/29/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import UIKit
import SpriteKit

class ViewPlayNow: UIViewController {

    /*outlets giao dien*/
    
    @IBOutlet weak var btnExit: UIButton!
    //6 nut chua 6 ky tu
    @IBOutlet public var btn1: UIButton!
    @IBOutlet public var btn2: UIButton!
    @IBOutlet public var btn3: UIButton!
    @IBOutlet public var btn4: UIButton!
    @IBOutlet public var btn5: UIButton!
    @IBOutlet public var btn6: UIButton!
    //label chua tu nguoi choi dang sap xep
    @IBOutlet public var lbInput: UILabel!
    //button submit
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var pgTime: UIProgressView!
    
    @IBOutlet weak var vsNotification: UIVisualEffectView!
    @IBOutlet weak var imgVS: UIImageView!
    @IBOutlet weak var btnNewGame: UIButton!
    @IBOutlet weak var btnReview: UIButton!
    @IBOutlet weak var lbNotification: UILabel!
    
    
    /*khai bao bien toan cuc*/
    
    public var scene : ResultCell!
    
    //Mang luu dap an
    var resultArray : [String]?
    //Mang luu dap an cua nguoi choi (0,1)
    var answerArray : [Int]?
    var currentNumAnswer = 0
    var valueProgressView: Float = 1.0
    var time: Timer!
    var datagame = DataGame()
    var check = CheckWord()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeGame()
        
        let size : CGSize!
        let skView = self.view as! SKView
        
        size = self.view.frame.size
        
        
        setupDisplay()
        scene = ResultCell(size: size)
        skView.presentScene(scene)
        
        for i in 0..<datagame.totalWord {
            print(resultArray![i])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setupDisplay() {
        btnExit.setBackgroundImage(UIImage(named: "thoat.png"), for: UIControlState.normal)
        btnSubmit.setBackgroundImage(UIImage(named: "submit.png"), for: UIControlState.normal)
        setTitleBtn()
        customLbInput()
        setupNoti()
    }
    
    private func initializeGame() {
        resultArray = [String](repeating: "D", count: datagame.totalWord)
        answerArray = [Int](repeating: 0, count: datagame.totalWord)
        initializeResult()
        self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setupTime), userInfo: nil, repeats: true)
    }
    
    private func setTitleBtn() {
        let keyword_Array = Array(datagame.keyword_String)
        btn1.setTitle(String(keyword_Array[0]), for: .normal)
        btn2.setTitle(String(keyword_Array[1]), for: .normal)
        btn3.setTitle(String(keyword_Array[2]), for: .normal)
        btn4.setTitle(String(keyword_Array[3]), for: .normal)
        btn5.setTitle(String(keyword_Array[4]), for: .normal)
        btn6.setTitle(String(keyword_Array[5]), for: .normal)
        
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn4.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn5.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn6.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
    }
    
    private func customLbInput() {
        lbInput.textAlignment = .center
        lbInput.font = UIFont.systemFont(ofSize: 27, weight: UIFont.Weight(rawValue: 0))
        lbInput.text = ""
    }
    
    @IBAction private func setTextLbInput(_ sender: Any) {
        let x = sender as! UIButton
        lbInput.text = lbInput.text! + String(x.title(for: UIControlState.normal)!)
        x.isEnabled = false
    }
    
    func refesh() {
        lbInput.text = ""
        btn1.isEnabled = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
        btn5.isEnabled = true
        btn6.isEnabled = true
    }
    
    func disableAll() {
        lbInput.text = ""
        lbInput.isEnabled = false
        btn1.isEnabled = false
        btn2.isEnabled = false
        btn3.isEnabled = false
        btn4.isEnabled = false
        btn5.isEnabled = false
        btn6.isEnabled = false
        btnSubmit.isHidden = true
        btnExit.isHidden = true
    }
    
    //ham vuot man hinh se refesh 6 o chu
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        refesh()
    }
    
    @IBAction func submit(_ sender: Any) {
        if validateWord() == true {
            scene.hmmm(stDapAn: lbInput.text!)
            currentNumAnswer += 1
            if currentNumAnswer == resultArray?.count {
                disableAll()
                isWin(string: "YOU WON!!!")
                print("Winnnnn!!!")
                return
            }
            print("Dung roi")
        }
        else {
            print("Sai roi")
        }
        refesh()
    }
    
    private func initializeResult() {
        
        //mang dung de luu lai word duoi dang so
        var tempArray = [Int](repeating: 0, count: 6)
        //mang dung de danh dau da su dung chua | 0 : roi , 1 : chua
        var flagArray = [Int](repeating: 0, count: 6)
        
        //Bien dem cua mang resultArray
        var x = 0
        
        func k_permutation(t: Int, k: Int) {
            for i in 0..<6 {
                if flagArray[i] == 0 {
                    tempArray[t] = i
                    if t == k {
                        joinWord(K: k)
                    }
                    else {
                        flagArray[i] = 1
                        k_permutation(t: t+1, k: k)
                        flagArray[i] = 0
                    }
                }
            }
        }
        
        func joinWord(K: Int) {
            var text = ""
            var keyword_Array = Array(datagame.keyword_String)
            for i in 0...K {
                text = text + String(keyword_Array[tempArray[i]])
            }
            if check.correctWord(word: text.lowercased()) == true {
                if check.isWordExist(word: text, arr: resultArray, max: datagame.totalWord) == -1 {
                    resultArray![x] = text
                    x += 1
                }
            }
        }
        
        for i in 2..<6 {
            k_permutation(t: 0, k: i)
        }
    }
    
    private func validateWord() -> Bool {
        
        //true: tu hop le
        //false: tu ko hop le
        
        if lbInput.text!.count <= 2 {
            return false
        }
        if check.correctWord(word: lbInput.text!.lowercased()) == false {
            return false
        }
        let i = check.isWordExist(word: lbInput.text!, arr: resultArray, max: datagame.totalWord)
        print(i)
        if i > -1 {
            if answerArray![i] == 1 {
                return false
            }
            else {
                answerArray![i] = 1
                return true
            }
        }
        return true
    }
    
    @IBAction func showSetting(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpID") as! PopUpViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @objc func setupTime() {
        valueProgressView -= 1/50
        pgTime.setProgress(valueProgressView, animated: true)
        if valueProgressView <= 0 {
            isWin(string: "YOU LOSE")
            disableAll()
        }
    }
    
    private func setupNoti() {
        imgVS.image = UIImage(named: "layer 1.png")
        
        btnNewGame.setBackgroundImage(UIImage(named: "layer 3.png"), for: UIControlState.normal)
        btnNewGame.setTitle("New Game", for: .normal)
        btnNewGame.setTitleColor(UIColor(red: 0.9294, green: 0.1216, blue: 0, alpha: 1.0), for: .normal)
        btnNewGame.titleLabel?.font = UIFont(name: "Family", size: 20)
        
        btnReview.setBackgroundImage(UIImage(named: "layer 3.png"), for: UIControlState.normal)
        btnReview.setTitle("Review", for: .normal)
        btnReview.setTitleColor(UIColor(red: 0.9294, green: 0.1216, blue: 0, alpha: 1.0), for: .normal)
        btnReview.titleLabel?.font = UIFont(name: "Family", size: 20)
        
        lbNotification.textAlignment = .center
        lbNotification.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(rawValue: 3))
        lbNotification.textColor = UIColor(red: 0.8471, green: 0, blue: 0, alpha: 1.0)
        hiddenNoti()
    }
    
    private func hiddenNoti() {
        vsNotification.alpha = 0
    }
    
    private func isWin(string: String) {
        time.invalidate()
        time = nil
        lbNotification.text = string
        vsNotification.transform = CGAffineTransform(scaleX: 0.3, y: 2)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            self.vsNotification.transform = .identity
        }) { (success) in
        }
        vsNotification.alpha = 1
    }
    
    @IBAction func clickBtnReview(_ sender: Any) {
        vsNotification.alpha = 0
        btnExit.isHidden = false
    }
    
}
