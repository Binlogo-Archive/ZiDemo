//
//  Realm.swift
//  ZiDemo
//
//  Created by Binboy on 2016/11/7.
//  Copyright © 2016年 Binboy. All rights reserved.
//

import Foundation

struct Templete {
    let content: String
    let css: String
    let designer: String
    struct Font {
        let compressorUrl: String
        let fontId: String
        let fontVersion: String
        let name: String
        let size: Int
        let url: String
        init?(json info: [String: Any]) {
            guard let compressorUrl = info["compressorUrl"] as? String else { return nil }
            guard let fontId = info["fontId"] as? String else { return nil }
            guard let fontVersion = info["fontVersion"] as? String else { return nil }
            guard let name = info["name"] as? String else { return nil }
            guard let size = info["size"] as? Int else { return nil }
            guard let url = info["url"] as? String else { return nil }
            self.compressorUrl = compressorUrl
            self.fontId = fontId
            self.fontVersion = fontVersion
            self.name = name
            self.size = size
            self.url = url
        }
    }
    let fonts: [Font]
    let isPrivate: Int
    let name: String
    let size: Int
    let staticDomain: String
    let templateId: String
    let templateZip: String
    let thumbnail: String
    let url: String
    let version: Int
    init?(json info: [String: Any]) {
        guard let content = info["content"] as? String else { return nil }
        guard let css = info["css"] as? String else { return nil }
        guard let designer = info["designer"] as? String else { return nil }
        guard let fontsJSONArray = info["fonts"] as? [[String: Any]] else { return nil }
        let fonts = fontsJSONArray.map({ Font(json: $0) }).flatMap({ $0 })
        guard let isPrivate = info["isPrivate"] as? Int else { return nil }
        guard let name = info["name"] as? String else { return nil }
        guard let size = info["size"] as? Int else { return nil }
        guard let staticDomain = info["staticDomain"] as? String else { return nil }
        guard let templateId = info["templateId"] as? String else { return nil }
        guard let templateZip = info["templateZip"] as? String else { return nil }
        guard let thumbnail = info["thumbnail"] as? String else { return nil }
        guard let url = info["url"] as? String else { return nil }
        guard let version = info["version"] as? Int else { return nil }
        self.content = content
        self.css = css
        self.designer = designer
        self.fonts = fonts
        self.isPrivate = isPrivate
        self.name = name
        self.size = size
        self.staticDomain = staticDomain
        self.templateId = templateId
        self.templateZip = templateZip
        self.thumbnail = thumbnail
        self.url = url
        self.version = version
    }
}
