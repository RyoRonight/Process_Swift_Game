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

    @IBOutlet weak var imgBackground: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDisplay()
        let a =  ResultCell.init(coder: <#T##NSCoder#>)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupDisplay() {
        imgBackground.image = UIImage(named: "play-background.png")
    }
    
}


class ResultCell: SKScene {
    
    var timePlay = 180.0
    private var arr6:NSMutableArray!
    private var arr5:NSMutableArray!
    private var arr4:NSMutableArray!
    private var arr3:NSMutableArray!
    
    private var vitriSubarry6 = 0
    private var vitriSubarry5 = 0
    private var vitriSubarry4 = 0
    private var vitriSubarry3 = 0
    
    // thay doi luc load numbercaell voi stDapAn
    var numberCell = 18
    var stDapAn = "12|10|4|15"  // di chuyen xuong init
    var stRow:[Substring]!
    //private var background:SKSpriteNode = SKSpriteNode(imageNamed: "background")****
    private var widthCell = 35
    var backgroundAnh:[String] = ["o1","o2"]
    var anhCell:[String] = ["tomato"]
    
    
    
    override init(size: CGSize) {
        super.init(size: size)
        //addBackGround()
        stRow = stDapAn.split(separator: "|")
        //taoCacCot(numberCell: numberCell, stDapAn: stDapAn, vitriH: 20)
        print("Fne")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func createKhung(numberCell:Int, typeCell:Int, vitri:CGPoint) -> NSMutableArray{
        let arrAllImange:NSMutableArray = NSMutableArray()
        
        
        var xCen:Int = widthCell
        var yCen:Int = Int(vitri.y)
        
        
        //tao khung bao
        
        let khungbao:SKSpriteNode = SKSpriteNode(imageNamed: "khungbao")
        khungbao.position = CGPoint(x: Int(vitri.x) + xCen / 2 - 2, y: Int(frame.midX) - Int(vitri.y) - widthCell * (numberCell / typeCell) - widthCell / 2 + widthCell - 2 )
        khungbao.anchorPoint = CGPoint(x: 0, y: 0)
        khungbao.zPosition = -1
        khungbao.size = CGSize(width: widthCell * typeCell + 4, height: widthCell * numberCell / typeCell + 4)
        addChild(khungbao)
        
        //tao cell
        
        for v in 0..<numberCell/typeCell{
            for h in 0..<typeCell{
                
                //tao background
                let backgr: SKSpriteNode = SKSpriteNode(imageNamed: backgroundAnh[(v + h + typeCell)%2])
                backgr.position = CGPoint(x: xCen + Int(vitri.x), y: Int(frame.midX) - yCen)
                backgr.size = CGSize(width: widthCell, height: widthCell)
                
                addChild(backgr)
                
                // tao doi tuong o
                let umage:SKSpriteNode = SKSpriteNode(imageNamed: "tomato.png")
                umage.position = CGPoint(x: xCen + Int(vitri.x), y: Int(frame.midX) - yCen)
                umage.size = CGSize(width: widthCell, height: widthCell)
                addChild(umage)
                
                // luu tung o lai
                arrAllImange.add(umage)
                
                
                xCen += widthCell
            }
            xCen = widthCell
            yCen += widthCell
        }
        return arrAllImange
    }
 
    
    
    
}

