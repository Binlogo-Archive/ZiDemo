//
//  ZiTextStorage.swift
//  ZiDemo
//
//  Created by Binboy on 2016/11/7.
//  Copyright © 2016年 Binboy. All rights reserved.
//

import UIKit

public enum TextToken: String {
    case body  = "BodyTokenName"
    case headline = "HeadlineTokenName"
    case blueTest = "BlueTestName"
}

class ZiInteractiveTextStorage: NSTextStorage {
    
//    public var tokens: [TextToken: Dictionary<String, Any>]?
    public var attrsToApply: Dictionary<String, Any>?
    
    let backingStore = NSMutableAttributedString()
    
    override var string: String {
        return backingStore.string
    }
    
    override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [String : Any] {
        return backingStore.attributes(at: location, effectiveRange: range)
    }
    
    override func replaceCharacters(in range: NSRange, with str: String) {
        print("replaceCharactersInRange\(range) withString:\(str)")
        
        beginEditing()
        backingStore.replaceCharacters(in: range, with: str)
        edited([.editedCharacters, .editedAttributes], range: range, changeInLength: (str as NSString).length - range.length)
        endEditing()
    }
    
    override func setAttributes(_ attrs: [String : Any]?, range: NSRange) {
        print("setAttributes:\(attrs) range:\(range)")
        
        beginEditing()
        backingStore.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    func applyStyleTo(_ searchRange: NSRange) {
        
        guard let attrs = attrsToApply else {
            return
        }
        
        addAttributes(attrs, range: searchRange)
    
//        guard tokens != nil else {
//            return
//        }
//        
//        
//        
//        guard let bodyAttributes = tokens?[.body] else {
//            return
//        }
//        
//        guard let headlineAttributes = tokens?[.headline] else {
//            return
//        }
//        
//        if searchRange.location == 0 {
//            let rawString = backingStore.string
//            let firstLineRange =  NSString(string: rawString).lineRange(for: NSMakeRange(0, 0))
//            addAttributes(headlineAttributes, range: firstLineRange)
//            
//            let remainingRange = NSMakeRange(firstLineRange.location + firstLineRange.length, searchRange.length - firstLineRange.length)
//            if remainingRange.location < (rawString as NSString).length && remainingRange.length <= (rawString as NSString).length {
//                addAttributes(bodyAttributes, range: remainingRange)
//            }
//        } else {
//            addAttributes(bodyAttributes, range: searchRange)
//        }
        
//        // 1. 创建一些字体
//        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body)
//        let boldFontDescriptor = fontDescriptor.withSymbolicTraits(.traitBold)
//        let boldFont = UIFont(descriptor: boldFontDescriptor!, size: 0)
//        let normalFont = UIFont.preferredFont(forTextStyle: .body)
//        
//        // 2. 匹配由星号包围的文本
//        let regexStr = "(\\*\\w+(\\s\\w+)*\\*)"
//        let regex = try? NSRegularExpression(pattern: regexStr)
//        
//        let boldAttributes = [NSFontAttributeName : boldFont]
//        let normalAttributes = [NSFontAttributeName : normalFont]
//        
//        // 3. 遍历所有匹配上的文本，设置加粗字体属性
//        regex?.enumerateMatches(in: backingStore.string, range: searchRange) {
//            match, flags, stop in
//            let matchRange = match?.rangeAt(1)
//            self.addAttributes(boldAttributes, range: matchRange!)
//            
//            // 4. 还原字体格式
//            let maxRange = (matchRange?.location)! + (matchRange?.length)!
//            if maxRange + 1 < self.length {
//                self.addAttributes(normalAttributes, range: NSMakeRange(maxRange, 1))
//            }
//        }
    }
    
    public func performReplacemetsFor(changedRange: NSRange) {
        let extendedRange = NSUnionRange(changedRange, NSString(string: backingStore.string).lineRange(for: NSMakeRange(NSMaxRange(changedRange), 0)))
        applyStyleTo(extendedRange)
    }
    
    override func processEditing() {
//        performReplacemetsFor(changedRange: editedRange)
        super.processEditing()
    }

}
