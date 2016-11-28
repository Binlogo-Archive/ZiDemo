//
//  EditCreationViewController.swift
//  ZiDemo
//
//  Created by Binboy on 2016/11/7.
//  Copyright © 2016年 Binboy. All rights reserved.
//

import UIKit
import SnapKit

class EditCreationViewController: UIViewController {
    
    var template: Templete!
    
    var textView: UITextView!
    var textStorage: ZiInteractiveTextStorage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(EditCreationViewController.keyboardChange(notify:)), name:NSNotification.Name.UIKeyboardWillChangeFrame , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditCreationViewController.keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditCreationViewController.keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        createTextView()
        setupToolbar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func createTextView() {
        
        let attrString = template.content.utf8Data?.attributedString
        
        textStorage = ZiInteractiveTextStorage()
        textStorage.append(attrString!)
        
        let newTextViewRect = view.bounds
        
        let layoutManager = NSLayoutManager()
        
        let containerSize = CGSize(width: newTextViewRect.width, height: CGFloat.greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        container.widthTracksTextView = true
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        textView = UITextView(frame: newTextViewRect, textContainer: container)
        textView.delegate = self
        view.addSubview(textView)
    }
    
    func appleStyleWith(token: TextToken) {
        switch token {
        case .headline:
            let headlineAttrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline),
                                     NSForegroundColorAttributeName: UIColor.red]
            textStorage.attrsToApply = headlineAttrs
        case .blueTest:
            let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption1),
                         NSForegroundColorAttributeName: UIColor.blue]
            textStorage.attrsToApply = attrs
        default:
            let bodyAttrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body),
                             NSForegroundColorAttributeName: UIColor.black]
            textStorage.attrsToApply = bodyAttrs
        }
        textStorage.performReplacemetsFor(changedRange: textView.selectedRange)
    }
    
//    func applyStyle() {
//        let headlineAttrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline),
//                             NSForegroundColorAttributeName: UIColor.red]
//        let bodyAttrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)]
//        let tokens: [TextToken: Dictionary<String, Any>] = [.body: bodyAttrs,
//                                               .headline: headlineAttrs]
//        textStorage.tokens = tokens
//    }
    
    private lazy var toolbar: UIToolbar = UIToolbar()
    
    private func setupToolbar()
    {
        view.addSubview(toolbar)
        
        var items = [UIBarButtonItem]()
        let itemSettings = [["imageName": "icon_font_p", "action": "changeFont"],
                            
                            ["imageName": "keyboardList", "action": "applyList"],
                            
                            ["imageName": "keyboardSeperator", "action": "appylySeperator"],
                            
                            ["imageName": "keyboardPic", "action": "selectPictrue"],
                            
                            ["imageName": "keyboardClose", "action": "closeKeyboard"]]
        for dict in itemSettings
        {
            let image = UIImage(named: dict["imageName"]!)
            
            var action: Selector? = nil
            if let str = dict["action"] {
                action = Selector(str)
            }
            
            let item = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolbar.items = items
        
        toolbar.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.height.equalTo(44)
        }
    }
    
    func keyboardChange(notify: NSNotification)
    {
        let valueEnd = notify.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let rectEnd = valueEnd.cgRectValue
        let valueBegin = notify.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let rectBegin = valueBegin.cgRectValue
        
        let dy = rectEnd.origin.y - rectBegin.origin.y
        
        let duration = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        UIView.animate(withDuration: duration.doubleValue) { [unowned self] in
            
            self.toolbar.snp.updateConstraints { (make) -> Void in
                make.bottom.equalTo(self.view.snp.bottom).offset(dy)
            }
            
            self.view.setNeedsLayout()
        }
    }
    
    
    func keyboardDidShow(notification: NSNotification) {
        if let rectValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            let keyboardSize = rectValue.cgRectValue.size
            updateTextViewSizeForKeyboardHeight(keyboardHeight: keyboardSize.height)
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        updateTextViewSizeForKeyboardHeight(keyboardHeight: 0)
    }
    
    func updateTextViewSizeForKeyboardHeight(keyboardHeight: CGFloat) {
        textView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardHeight)
    }
    
    func changeFont() {
        print("Change Font")
        appleStyleWith(token: .headline)
    }
    
    func applyList() {
        appleStyleWith(token: .body)
    }
    
    func appylySeperator() {
        appleStyleWith(token: .blueTest)
    }
    
    func selectPictrue() {
        print("Select Pictrue")
    }
    
    func closeKeyboard() {
        textView.resignFirstResponder()
    }
}

extension EditCreationViewController: UITextViewDelegate {
    
}

extension Data {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    var utf8String: String? {
        return String(data: self, encoding: .utf8)
    }
}

extension String {
    var utf8Data: Data? {
        return data(using: .utf8)
    }
}

extension NSAttributedString {
    var htmlData: Data? {
        do {
            return try self.data(from: NSMakeRange(0, self.length), documentAttributes: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType])
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
