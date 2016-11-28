//
//  Networing.swift
//  ZiDemo
//
//  Created by Binboy on 2016/11/6.
//  Copyright © 2016年 Binboy. All rights reserved.
//

import Foundation

func fakeRequestTemplete() -> [Templete] {
    let bundle = Bundle.main
    let templetesJsonPath = bundle.path(forResource: "FakeTempletes", ofType: "json")
    let data = try! Data(contentsOf: URL(fileURLWithPath: templetesJsonPath!))
    guard let result = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) else {
        return []
    }
    
    var templetes = [Templete]()
    
    if let dictionary = result as? [String: Any] {
        if let array = dictionary["rows"] as? [[String: Any]] {
            for dict in array {
                let templete = Templete(json: dict)
                templetes.append(templete!)
            }
        }
    }
    
    return templetes
}
