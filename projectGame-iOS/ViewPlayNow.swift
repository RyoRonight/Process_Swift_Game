//
//  ViewPlayNow.swift
//  projectGame-iOS
//
//  Created by Ryo Rogueknight on 10/29/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import FBSDKLoginKit

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
    
    // show menu
    @IBOutlet weak var Menu: UIView!
    @IBOutlet weak var numberItemDapAn: UILabel!
    @IBOutlet weak var numberItemCongThoiGian: UILabel!
    // button diem khi submimt
    @IBOutlet weak var btnDiemSo: UIButton!
    var diemSo: Int!
    var id: String!
    
    /*khai bao bien toan cuc*/
    public var scene : ResultCell!
    
    
    var currentNumAnswer3 = 0
    var currentNumAnswer4 = 0
    var currentNumAnswer5 = 0
    var currentNumAnswer6 = 0
    var valueProgressView: Float = 1.0
    var time: Timer!
    var keyWord: KeyWord!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberItemDapAn.text = String(UserDefaults.standard.integer(forKey: "DapAnHelp"))
        numberItemCongThoiGian.text = String( UserDefaults.standard.integer(forKey: "CongTime"))
        id = UserDefaults.standard.object(forKey: "UserId") as? String
        diemSo = UserDefaults.standard.integer(forKey: "Coin")
        btnDiemSo.setTitle(String(diemSo), for: .normal)
        initializeGame()
        let size : CGSize!
        let skView = self.view as! SKView
        size = self.view.frame.size
        scene = ResultCell(size: size)
        skView.presentScene(scene)
        scene.khoitao(word: keyWord)
        
    }
    
    private func setupDisplay() {
        btnExit.setBackgroundImage(UIImage(named: "thoat.png"), for: .normal)
        btnSubmit.setBackgroundImage(UIImage(named: "submit.png"), for: .normal)
        
        setTitleBtn()
        customLbInput()
        customPgTime()
        setupNoti()
        DispatchQueue.main.async {
            self.time = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.setupTime), userInfo: nil, repeats: true)
        }
    }
    
    private func initializeGame() {
        
        // viet ham load du lieu tai day
        let radom: Int = Int.random(in: 1...5000)
        let url = URL(string: "http://tlcn.somee.com/api/keyword/" + String(radom))
        do{
            let  x = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            keyWord = KeyWord(str: x)
            setupDisplay()
            
        }catch{
            
        }
    }
    
    private func setTitleBtn() {
        var keyword_Array = Array(keyWord.ChuoiKiTu)
        var i = Int.random(in: 0 ..< 6)
        btn1.setTitle(String(keyword_Array[i]), for: .normal)
        keyword_Array.remove(at: i)
        
        
        i = Int.random(in: 0 ..< 5)
        btn2.setTitle(String(keyword_Array[i]), for: .normal)
        keyword_Array.remove(at: i)
        
        i = Int.random(in: 0 ..< 4)
        btn3.setTitle(String(keyword_Array[i]), for: .normal)
        keyword_Array.remove(at: i)
        
        i = Int.random(in: 0 ..< 3)
        btn4.setTitle(String(keyword_Array[i]), for: .normal)
        keyword_Array.remove(at: i)
        
        i = Int.random(in: 0 ..< 2)
        btn5.setTitle(String(keyword_Array[i]), for: .normal)
        keyword_Array.remove(at: i)
        btn6.setTitle(String(keyword_Array[0]), for: .normal)
        
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn4.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn5.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
        btn6.titleLabel?.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight(rawValue: 3))
    }
    
    private func customLbInput() {
        lbInput.textAlignment = .center
        lbInput.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(rawValue: 1.0))
        lbInput.text = ""
        let mauborder = UIColor(red: 195.0/255.0, green: 195.0/255.0, blue: 195.0/255.0, alpha: 1.0)
        lbInput.layer.borderColor = mauborder.cgColor
        lbInput.layer.borderWidth = 3.0
        lbInput.layer.cornerRadius = 10.0
        let maubackground = UIColor(red: 54.0/255.0, green: 137.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        lbInput.layer.backgroundColor = maubackground.cgColor
    }
    private func customPgTime() {
        let mauPg = UIColor(red: 255.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        pgTime.layer.borderColor = mauPg.cgColor
        pgTime.layer.borderWidth =  0.5
    }
    @IBAction private func setTextLbInput(_ sender: Any) {
        let x = sender as! UIButton
        
        lbInput.text = lbInput.text! + (x.titleLabel?.text)!
        x.isEnabled = false
        if Menu.alpha == 1 {
            Menu.alpha = 0
        }
    }
    
    func refesh() {
        lbInput.text = ""
        btn1.isEnabled = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
        btn5.isEnabled = true
        btn6.isEnabled = true
        Menu.alpha = 0
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
        Menu.alpha = 0
        
    }
    
    //ham vuot man hinh se refesh 6 o chu
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        refesh()
    }
    // click menu
    @IBAction func menuClick(_ sender: Any) {
        if id != nil && id != "1" {
            DispatchQueue.main.async {
                self.Menu.alpha = 1
            }
        }      
    }
    // click submit
    @IBAction func submit(_ sender: Any) {
        
        let x = lbInput.text!.lowercased()
        
        for i in 0 ..< keyWord.DapAn.count {
            if x == keyWord.DapAn[i] {
                self.scene.hmmm(stDapAn: self.lbInput.text!)
                switch x.count {
                case 3:
                    diemSo += 3
                    btnDiemSo.setTitle(String(diemSo), for: .normal)
                    currentNumAnswer3 += (currentNumAnswer3 >= 6) ? 0 : 1
                    break
                case 4:
                    diemSo += 4
                    btnDiemSo.setTitle(String(diemSo), for: .normal)
                    currentNumAnswer4 += (currentNumAnswer4 >= 6) ? 0 : 1
                    break
                case 5:
                    diemSo += 5
                    btnDiemSo.setTitle(String(diemSo), for: .normal)
                    currentNumAnswer5 += (currentNumAnswer5 >= 6) ? 0 : 1
                    break
                default:
                    diemSo += 6
                    btnDiemSo.setTitle(String(diemSo), for: .normal)
                    currentNumAnswer6 += (currentNumAnswer6 >= 6) ? 0 : 1
                    break
                }
                UserDefaults.standard.set(diemSo, forKey: "Coin")
                if id! != "1" {
                    do{
                        _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/user/?id="+id!+"&&coin=" + String(diemSo))!, encoding: String.Encoding.utf8)
                    }catch{
                        
                    }
                }
                keyWord.DapAn.remove(at: i)
                if currentNumAnswer6 + currentNumAnswer5 + currentNumAnswer4 + currentNumAnswer3 == keyWord.TongSL {
                    disableAll()
                    isWin(string: "YOU WON!!!")
                    return
                }
                break
            }
        }
        print(keyWord.DapAn)
        refesh()
        Menu.alpha = 0
    }
    
    @IBAction func CongThoiGian(_ sender: Any) {
        let number = Int( numberItemCongThoiGian.text!)!
        if number > 0 {
            if valueProgressView <= 1.0 {
                valueProgressView = (valueProgressView + 1/6) > 1.0 ? 1.0 : valueProgressView + 1/6
                self.pgTime.setProgress(self.valueProgressView, animated: true)
            }
            
            numberItemCongThoiGian.text = String(number - 1 )
            DispatchQueue.main.async {
                UserDefaults.standard.set(number - 1, forKey: "CongTime")
            }
            if id! != "1" {
                do{
                    _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/Bags/?idUser="+id!+"&&idVatPham=123&&soLuong=" + String(number - 1))!, encoding: String.Encoding.utf8)
                }catch{
                    
                }
            }
        }
        Menu.alpha = 0
    }
    
    @IBAction func DapAnTroGiup(_ sender: Any) {
        
        let number = Int( numberItemDapAn.text!)!
        if number > 0 {
            let numberDapAn = keyWord.DapAn.count
            let radom = Int.random(in: 0 ..< numberDapAn)
            lbInput.text = String(keyWord.DapAn[radom]).uppercased()
            numberItemDapAn.text = String( number - 1)
            DispatchQueue.main.async {
                UserDefaults.standard.set(number - 1, forKey: "DapAnHelp")
            }
            if id! != "1" {
                do{
                    _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/Bags/?idUser="+id!+"&&idVatPham=124&&soLuong=" + String(number - 1))!, encoding: String.Encoding.utf8)
                }catch{
                    
                }
            }
        }
        Menu.alpha = 0
    }
    @IBAction func showSetting(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpID") as! PopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    @objc func setupTime() {       
        
        DispatchQueue.main.async {
            self.valueProgressView -= 1/180
            self.pgTime.setProgress(self.valueProgressView, animated: true)
            if self.valueProgressView <= 0 {
                self.isWin(string: "YOU LOSE")
                self.disableAll()
            }
        }
        
    }
    
    private func setupNoti() {
        imgVS.image = UIImage(named: "layer 1.png")
        
        btnNewGame.setBackgroundImage(UIImage(named: "layer 3.png"), for: UIControl.State.normal)
        btnNewGame.setTitle("New Game", for: .normal)
        btnNewGame.setTitleColor(UIColor(red: 0.9294, green: 0.1216, blue: 0, alpha: 1.0), for: .normal)
        btnNewGame.titleLabel?.font = UIFont(name: "Family", size: 20)
        
        btnReview.setBackgroundImage(UIImage(named: "layer 3.png"), for: UIControl.State.normal)
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
