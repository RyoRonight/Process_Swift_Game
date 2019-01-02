//
//  CheckWord.swift
//  projectGame-iOS
//
//  Created by Ryo Rogueknight on 11/1/18.
//  Copyright © 2018 Ryo Rogueknight. All rights reserved.
//

import Foundation
import UIKit

public class CheckWord  {
    
//    //Ham kiem tra co phai tu tieng anh ko
//    public func correctWord(word: String) -> Bool {
//        let checker = UITextChecker()
//        let range = NSRange(location: 0, length: word.utf16.count)
//        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
//        return misspelledRange.location == NSNotFound
//    }
//
    //Ham kiem tra tu da ton tai trong mang ket qua chua
    public func isWordExist(word : String , arr : [String]!) -> Int {
     
        for i in 0 ..< arr.count {
            if arr[i] == word {
                return i
            }
        }
        //tu ko ton tai
        return -1
    }
}
