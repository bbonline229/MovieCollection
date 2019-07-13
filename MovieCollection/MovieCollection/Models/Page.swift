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
    
    mutating func toggleToNextPage() {
        if currentPageIndex == 0 { return }
        currentPageIndex += 1
    }
    
    mutating func toggleToPreviousPage() {
        currentPageIndex -= 1
    }
}
