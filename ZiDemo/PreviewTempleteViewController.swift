//
//  PreviewTempleteViewController.swift
//  ZiDemo
//
//  Created by Binboy on 2016/11/7.
//  Copyright © 2016年 Binboy. All rights reserved.
//

import UIKit

class PreviewTempleteViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var templete: Templete?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let html = templete?.content {
            webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
