//
//  ZB_BaseSectionModel.swift
//  SwiftTest
//
//  Created by rongzebing on 2018/6/20.
//  Copyright © 2018年 rongzebing. All rights reserved.
//

import UIKit
import Foundation
public class XBBaseDataModel : NSObject {
    var isSelected = false
    var isEdit = false
    var cellSize = CGSize.zero
    var editCellSize = CGSize.zero
    var defaultCellSize = CGSize.zero
    var cellClass: String?
    
    
}

public class XBBaseSectionModel {
//    CGSize.init(width: 0, height: 0.0001)
    var isClose = false
    var isEmpty = false
    var emptySize = XBListDefaultSecSize
    var emptyClass: String?
    
    var headerSize = XBListDefaultSecSize
    var footerSize = XBListDefaultSecSize
    var defaultHeaderSize = XBListDefaultSecSize
    var defaultFooterSize = XBListDefaultSecSize
    var editHeaderSize = XBListDefaultSecSize
    var editFooterSize = XBListDefaultSecSize
    
    var edgeInsets = UIEdgeInsets.zero
    var lineSpace: CGFloat = 0
    var rowSpace: CGFloat = 0
    
    var headerClass : String?
    var footerClass : String?
    
    var isEdit = false
    var isFooterEdit = false
    var isSelected = false
    
    var items = [XBBaseDataModel]()
    
    
}
