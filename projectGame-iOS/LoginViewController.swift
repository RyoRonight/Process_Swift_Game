//
//  LoginViewController.swift
//  projectGame-iOS
//
//  Created by Khen Huynh on 12/29/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var coinCurrent = 0
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print("Loi: \(error.localizedDescription)")
        } else if result.isCancelled {
            //Huy dang nhap luc bam Cancel
        } else {
            //successful login
            
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "email, id, name"]).start {
                (connection, result, err) in
                
                if(err == nil)
                {
                    //in ra email, id, name, tokenacess
                    print("******************************")
                    print("result \(String(describing: result))")
                    print(FBSDKAccessToken.current()?.tokenString! as Any)
                    print("******************************")
                }
                else
                {
                    print("******************************")
                    print("Loi roi: \(String(describing: err))")
                    print("******************************")
                }
            }
            
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        UserDefaults.standard.set(0, forKey: "Coin")
        UserDefaults.standard.set(nil, forKey: "UserId")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnFBLogin = FBSDKLoginButton()
        btnFBLogin.readPermissions = ["public_profile", "email"]
        btnFBLogin.delegate = self
        btnFBLogin.center = self.view.center
        self.view.addSubview(btnFBLogin)
        isLoggedIn()
        
    }
    
    //ham kiem tra co dang dang nhap hay khong
    private func isLoggedIn() {
        if FBSDKAccessToken.current() == nil {
            if UserDefaults.standard.integer(forKey: "Coin") != 0 {
                coinCurrent = UserDefaults.standard.integer(forKey: "Coin")
            }
        }
    }
    
    @IBAction func PlayNow(_ sender: UIButton) {
        
        if FBSDKAccessToken.current() == nil {
            UserDefaults.standard.set(coinCurrent, forKey: "Coin")
            UserDefaults.standard.set("1", forKey: "UserId")
            UserDefaults.standard.set(0, forKey: "CongTime")
            UserDefaults.standard.set(0, forKey: "DapAnHelp")
            return
        }
        
        let id = getUserID()
        if id != ""{
            let url = URL(string: "http://tlcn.somee.com/api/user/" + id)
            do{
                let  x = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                if x.contains("true") {
                    UserDefaults.standard.set(id, forKey: "UserId")
                    let coin = UserDefaults.standard.integer(forKey: "Coin")
                    
                    //luu coin vao database
                    _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/user/?id="+id+"&&coin=" + String(coin))!, encoding: String.Encoding.utf8)
                    
                    //luu so luong item tang thoi gian vao db (lan dau dang nhap dc tang 3 cai)
                    let numberTime = 3
                    UserDefaults.standard.set(numberTime, forKey: "CongTime")
                    _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/Bags/?idUser="+id+"&&idVatPham=123&&soLuong=" + String(numberTime))!, encoding: String.Encoding.utf8)
                    
                    //luu so luong item goi y vao db (lan dau dang nhap dc tang 3 cai)
                    let numberHelp = 3
                    UserDefaults.standard.set(numberHelp, forKey: "DapAnHelp")
                    _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/Bags/?idUser="+id+"&&idVatPham=124&&soLuong=" + String(numberHelp))!, encoding: String.Encoding.utf8)
                }
                else {
                    UserDefaults.standard.set(id, forKey: "UserId")
                    let arrThongTin = x.replacingOccurrences(of: "\"", with: "").split(separator: ";")
                    let coin = Int(arrThongTin[0])! + coinCurrent
                    UserDefaults.standard.set(coin, forKey: "Coin")
                    UserDefaults.standard.set(arrThongTin[1], forKey: "CongTime")
                    UserDefaults.standard.set(arrThongTin[2], forKey: "DapAnHelp")
                    _ = try String(contentsOf: URL(string: "http://tlcn.somee.com/api/user/?id="+id+"&&coin=" + String(coin))!, encoding: String.Encoding.utf8)
                  
                }
            }catch{
                
            }
        }
    }
    
    func getUserID() -> String {
        let id:String!
        do{
            id  = FBSDKAccessToken.current() == nil ? "" : String(FBSDKAccessToken.current().userID)
        }
        return id
    }
    
}
