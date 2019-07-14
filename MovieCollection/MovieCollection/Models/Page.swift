//
//  Page.swift
//  MovieCollection
//
//  Created by Jack on 7/13/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import Foundation

struct Page {
    var currentPageIndex: Int
    let totalPage: Int
    
    var currentPageDescription: String {
        return "\(currentPageIndex + 1)"
    }
    
    var totalPageDescription: String {
        return "\(totalPage)"
    }
    
    var pageDescription: String {
        return "\(currentPageIndex + 1) of \(totalPage)"
    }
    
    mutating func toggleToNextPage(with settingMode: Setting) {
        if currentPageIndex == totalPage - 1 {
            if settingMode == .infinite { currentPageIndex = 0 }
            return
        }
        currentPageIndex += 1
    }
    
    mutating func toggleToPreviousPage(with settingMode: Setting) {
        if currentPageIndex == 0 {
            if settingMode == .infinite { currentPageIndex = totalPage - 1 }
            return
        }
        currentPageIndex -= 1
    }
}
