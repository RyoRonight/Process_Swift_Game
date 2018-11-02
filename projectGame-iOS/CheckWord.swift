//
//  CheckWord.swift
//  projectGame-iOS
//
//  Created by Ryo Rogueknight on 11/1/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import Foundation
import UIKit

class CheckWord  {
    
    //Ham kiem tra co phai tu tieng anh ko
    public func correctWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    //Ham kiem tra tu da ton tai trong mang ket qua chua
    public func isWordExist(word : String , arr : [String]! , max : Int) -> Int {
        var i = 0
        for _ in 0..<max {
            if arr[i] == word {
                //tu da ton tai
                return i
            }
            i = i + 1
        }
        //tu ko ton tai
        return -1
    }
}
