//
//  ZB_BaseSectionModel.swift
//  SwiftTest
//
//  Created by rongzebing on 2018/6/20.
//  Copyright © 2018年 rongzebing. All rights reserved.
//

import UIKit
import Foundation
open class XBBaseDataModel : NSObject {
    public var isSelected = false
    public var isEdit = false
    public var cellSize = CGSize.zero
    public var editCellSize = CGSize.zero
    public var defaultCellSize = CGSize.zero
    public var cellClass: String?
    
    
}

open class XBBaseSectionModel {
//    CGSize.init(width: 0, height: 0.0001)
    public var isClose = false
    public var isEmpty = false
    public var emptySize = XBListDefaultSecSize
    public var emptyClass: String?
    
    public var headerSize = XBListDefaultSecSize
    public var footerSize = XBListDefaultSecSize
    public var defaultHeaderSize = XBListDefaultSecSize
    public var defaultFooterSize = XBListDefaultSecSize
    public var editHeaderSize = XBListDefaultSecSize
    public var editFooterSize = XBListDefaultSecSize
    
    public var edgeInsets = UIEdgeInsets.zero
    public var lineSpace: CGFloat = 0
    public var rowSpace: CGFloat = 0
    
    public var headerClass : String?
    public var footerClass : String?
    
    public var isEdit = false
    public var isFooterEdit = false
    public var isSelected = false
    
    public var items = [XBBaseDataModel]()
    
    
}
