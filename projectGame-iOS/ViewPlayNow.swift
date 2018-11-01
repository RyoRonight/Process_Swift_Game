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

    //outlets giao dien
    
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
    
    
    //khai bao bien toan cuc
    
    private var scene : ResultCell!
    
    //Mang luu dap an
    var resultArray : [String]?
    //Mang luu dap an cua nguoi choi (0,1)
    var answerArray : [Int]?
    var datagame = DataGame()
    var check = CheckWord()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultArray = [String](repeating: "D", count: datagame.totalWord)
        answerArray = [Int](repeating: 0, count: datagame.totalWord)
        initializeResult()
        
        let size : CGSize!
        let skView = self.view as! SKView
        
        size = self.view.frame.size
        
        
        setupDisplay()
        scene = ResultCell(size: size)
        skView.presentScene(scene)
        
        
        print("*****************")
        for i in 0..<30 {
            print(resultArray![i])
        }
        
    }
    
    
    @IBAction func jjjjj(_ sender: Any) {
        let size : CGSize!
        let skView = self.view as! SKView
        
        size = self.view.frame.size
        
        
        
        scene = ResultCell(size: size)
        scene.hmmm()
        
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
    }
    
    private func setTitleBtn() {
        let keyword_Array = Array(datagame.keyword_String)
        btn1.setTitle(String(keyword_Array[0]), for: .normal)
        btn2.setTitle(String(keyword_Array[1]), for: .normal)
        btn3.setTitle(String(keyword_Array[2]), for: .normal)
        btn4.setTitle(String(keyword_Array[3]), for: .normal)
        btn5.setTitle(String(keyword_Array[4]), for: .normal)
        btn6.setTitle(String(keyword_Array[5]), for: .normal)
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
    
    //ham vuot man hinh se refesh 6 o chu
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        refesh()
    }
    
    @IBAction func submit(_ sender: Any) {
        if validateWord() == true {
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
                if check.isWordExist(word: text, arr: resultArray, max: datagame.totalWord) > -1 {
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
    
    
    
    
}



/*************************************************************************************/



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
    
    var stDapAn = "18|10|4|15"  // di chuyen xuong init
    var stRow:[Substring]!
    //private var background:SKSpriteNode = SKSpriteNode(imageNamed: "background")****
    private var widthCell : Int!
    var backgroundAnh:[String] = ["o1","o2"]
    var anhCell:[String] = ["tomato"]
    
 
    override init(size: CGSize) {
        super.init(size: size)
        
        widthCell = Int(frame.size.width / 21)
        
        addBackgourd()
        stRow = stDapAn.split(separator: "|")
        taoCacCot(stDapAn: "18|0|0|12", vitriH: Int(frame.size.width / 24))

        
        hmmm()
        
        print("Fne")
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
    
    open func hmmm() {
        let mangDapAn = Array(stDapAn)
        //let typeCell = mangDapAn.count
        let x = arr6.object(at: 13) as! SKSpriteNode
        let y = x.copy() as! SKSpriteNode
        addChild(y)
        
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: -100, y: 0))
        
        path.addLine(to: CGPoint(x: Int(x.position.x)
            + 30, y: Int(x.position.y) + 50))
        let action = SKAction.follow(path.cgPath, duration: 3)
        let actionScaleX = SKAction.scale(by: 0.8, duration: 0.1)
        x.texture = SKTexture(imageNamed: "o12")
        x.run(actionScaleX)
        y.run(action, completion: {
            
            y.removeFromParent()
            
        })
    }
    
}


