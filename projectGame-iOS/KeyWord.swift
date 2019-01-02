import Foundation
public class KeyWord{
    let IDChuoi:Int
    let ChuoiKiTu:String
    var DapAn:[String.SubSequence]
    let SoLuong3 :Int
    let SoLuong4: Int
    let SoLuong5: Int
    let SoLuong6: Int
    let TongSL: Int
    init(str: String) {
        
        var u = str.replacingOccurrences(of: " ", with: "")
        u = str.replacingOccurrences(of: "\"", with: "")
        let arr: [String.SubSequence] = u.split(separator: "|")
        self.IDChuoi = Int(arr[0])!
        self.ChuoiKiTu = String(arr[1]).trimmingCharacters(in: .whitespaces)
        self.DapAn = String(arr[2].trimmingCharacters(in: .whitespaces)).lowercased().split(separator: ";")
        
        self.SoLuong3 = Int(arr[4].trimmingCharacters(in: .whitespaces))! >= 7 ? 6 : Int(arr[4].trimmingCharacters(in: .whitespaces))!
        self.SoLuong4 = Int(arr[5].trimmingCharacters(in: .whitespaces))! >= 7 ? 6 : Int(arr[5].trimmingCharacters(in: .whitespaces))!
        self.SoLuong5 = Int(arr[6].trimmingCharacters(in: .whitespaces))! >= 7 ? 6 : Int(arr[6].trimmingCharacters(in: .whitespaces))!
        self.SoLuong6 = Int(arr[7].trimmingCharacters(in: .whitespaces))! >= 7 ? 6 : Int(arr[7].trimmingCharacters(in: .whitespaces))!
        
        self.TongSL = self.SoLuong3 + self.SoLuong4 + self.SoLuong5 + self.SoLuong6
        
    }
    public func toString() -> Void{
        print(ChuoiKiTu + "\n" + String(SoLuong3) + "\n" + String(TongSL))
    }
}

