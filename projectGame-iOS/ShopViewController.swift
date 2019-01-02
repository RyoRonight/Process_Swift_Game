//
//  ShopViewController.swift
//  projectGame-iOS
//
//  Created by Khen Huynh on 12/29/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var btnDiem: UIButton!

    var diemSo: Int!
    var id:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        diemSo = UserDefaults.standard.integer(forKey: "Coin")
        id = UserDefaults.standard.object(forKey: "UserId") as? String
        
        btnDiem.setTitle(String(diemSo), for: .normal)
        
    }
    
    @IBAction func muaTime(_ sender: Any) {
        let numberTime = UserDefaults.standard.integer(forKey: "CongTime")
        if diemSo > 30 {
            diemSo -= 30
            btnDiem.setTitle(String( diemSo ), for: .normal)
            UserDefaults.standard.set(numberTime + 1, forKey: "CongTime")
            UserDefaults.standard.set(diemSo, forKey: "Coin")
            do{
                _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/Bags/?idUser="+id!+"&&idVatPham=123&&soLuong=" + String(numberTime + 1))!, encoding: String.Encoding.utf8)
                _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/user/?id="+id!+"&&coin=" + String(diemSo))!, encoding: String.Encoding.utf8)
            }catch{
                
            }
        }
    }
    
    @IBAction func muaDapAn(_ sender: Any) {
        let numbDapAn = UserDefaults.standard.integer(forKey: "DapAnHelp")
        if diemSo > 60 {
            diemSo -= 60
            btnDiem.setTitle(String( diemSo ), for: .normal)
            UserDefaults.standard.set(numbDapAn + 1, forKey: "DapAnHelp")
            UserDefaults.standard.set(diemSo, forKey: "Coin")
            do{
                _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/Bags/?idUser="+id!+"&&idVatPham=124&&soLuong=" + String(numbDapAn + 1))!, encoding: String.Encoding.utf8)
                _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/user/?id="+id!+"&&coin=" + String(diemSo))!, encoding: String.Encoding.utf8)
            }catch{
                
            }
        }
    }
}
