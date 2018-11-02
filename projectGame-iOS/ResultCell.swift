//
//  ResultCell.swift
//  projectGame-iOS
//
//  Created by Ryo Rogueknight on 11/2/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import SpriteKit

class ResultCell: SKScene {
    
    var timePlay = 180.0
    private var arr6: NSMutableArray!
    private var arr5: NSMutableArray!
    private var arr4: NSMutableArray!
    private var arr3: NSMutableArray!
    
    private var vitriSubarry6 = 0
    private var vitriSubarry5 = 0
    private var vitriSubarry4 = 0
    private var vitriSubarry3 = 0
    
    var stDapAn = "0|0|4|9"  // di chuyen xuong init
    var stRow:[Substring]!
    private var widthCell : Int!
    var backgroundAnh:[String] = ["o1","o2"]
    var anhCell:[String] = ["tomato", "pear", "plum", "banana", "carrot"]
    
    override init(size: CGSize) {
        super.init(size: size)
        
        widthCell = Int(frame.size.width / 21)
        
        addBackgourd()
        stRow = stDapAn.split(separator: "|")
        taoCacCot(stDapAn: "18|0|0|12", vitriH: Int(frame.size.width / 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addBackgourd() {
        // add background
        let imgBackground : SKSpriteNode = SKSpriteNode(imageNamed: "play-background.png")
        imgBackground.size = frame.size
        imgBackground.zPosition = -2
        imgBackground.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(imgBackground)
    }
    
    private func createKhung(numberCell:Int, typeCell:Int, vitri:CGPoint) -> NSMutableArray{
        
        let arrAllImange: NSMutableArray = NSMutableArray()
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
                
                //tao background cua khung bao
                let backgr: SKSpriteNode = SKSpriteNode(imageNamed: backgroundAnh[(v + h + typeCell)%2])
                backgr.position = CGPoint(x: xCen + Int(vitri.x), y: Int(frame.midX) - yCen)
                
                backgr.size = CGSize(width: widthCell, height: widthCell)
                
                addChild(backgr)
                
                // tao doi tuong o
                let random = anhCell[Int(arc4random_uniform(UInt32(anhCell.count)))]
                let umage:SKSpriteNode = SKSpriteNode(imageNamed: random)
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
    
    private func getNumberCell( stDapAn: String ) -> Int {
        var soCot:Int = 18
        for i in 0 ..< stRow.count{
            if stRow[i] == "0"{
                soCot -= 6 - i
            }
        }
        return soCot
    }
    
    private func taoCacCot(stDapAn:String, vitriH:Int) -> Void {
        let numberCell = getNumberCell(stDapAn: stDapAn)
        var vitriW = (Int(frame.width) - widthCell*numberCell) / 2 - widthCell / 2 - 10
        
        if stRow[0] != "0" {
            vitriW -= 20
            arr6 = createKhung(numberCell: Int(stRow[0])!, typeCell: 6, vitri: CGPoint(x: vitriW, y: vitriH))
            vitriW += widthCell * 6 + 40
        }
        if stRow[1] != "0" {
            vitriW -= 20
            arr5 = createKhung(numberCell: Int(stRow[1])!, typeCell: 5, vitri: CGPoint(x: vitriW, y: vitriH))
            vitriW += widthCell * 5 + 40
        }
        if stRow[2] != "0" {
            vitriW -= 20
            arr4 = createKhung(numberCell: Int(stRow[2])!, typeCell: 4, vitri: CGPoint(x: vitriW, y: vitriH))
            vitriW += widthCell * 4 + 40
        }
        if stRow[3] != "0" {
            vitriW -= 20
            arr3 = createKhung(numberCell: Int(stRow[3])!, typeCell: 3, vitri: CGPoint(x: vitriW, y: vitriH))
        }
    }
    
    open func hmmm(stDapAn: String) {
        let mangDapAn = Array(stDapAn)
        let typeCell = mangDapAn.count
        
        if typeCell == 6 {
            animatiton(arr: arr6, vitriSubarry: vitriSubarry6, mangDapAn: mangDapAn)
            vitriSubarry6 += typeCell
            return
        }
        if typeCell == 5 {
            animatiton(arr: arr5, vitriSubarry: vitriSubarry5, mangDapAn: mangDapAn)
            vitriSubarry5 += typeCell
            return
        }
        if typeCell == 4 {
            animatiton(arr: arr4, vitriSubarry: vitriSubarry4, mangDapAn: mangDapAn)
            vitriSubarry4 += typeCell
            return
        }
        if typeCell == 3 {
            animatiton(arr: arr3, vitriSubarry: vitriSubarry3, mangDapAn: mangDapAn)
            vitriSubarry3 += typeCell
            return
        }
    }
    
    private func animatiton(arr: NSMutableArray!, vitriSubarry: Int, mangDapAn: [Character]) {
        var indexDapAN = 0
        
        if vitriSubarry >= Int(stRow[6 - mangDapAn.count])!{
            return
        }
        for i in vitriSubarry ..< vitriSubarry + mangDapAn.count {
            let x = arr.object(at: i) as! SKSpriteNode
            let y = x.copy() as! SKSpriteNode
            addChild(y)
            
            let path: UIBezierPath = UIBezierPath()
            path.move(to: CGPoint(x: -100, y: 0))
            
            let random = Int(arc4random_uniform(100))
            let random1 = Int(arc4random_uniform(150))
            
            path.addLine(to: CGPoint(x: Int(x.position.x) + random, y: Int(x.position.y) + random1))
            let action = SKAction.follow(path.cgPath, duration: 3)
            let actionScaleX = SKAction.scale(by: 0.8, duration: 0.1)
            //x.texture = SKTexture(imageNamed: String(mangDapAn[indexDapAN]))
            x.texture = SKTexture(imageNamed: "o12")
            x.run(actionScaleX)
            y.run(action, completion: {
                
                y.removeFromParent()
                
            })
            indexDapAN += 1
        }
    }
    
}
