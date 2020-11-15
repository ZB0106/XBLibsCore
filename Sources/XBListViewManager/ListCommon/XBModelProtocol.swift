//
//  XBModelProtocol.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/14.
//

import UIKit

public protocol XBSelectedModelProtocol {
    var isSelected: Bool? {set get}
}


//MARK: 目前支持header和cell有editProtocol
public protocol XBEditModelProtocol {
    var isEdit: Bool? {set get}
    var editSize: CGSize? {set get}
    
}

public protocol XBCellModelProtol {
    var cellSize: CGSize! {set get}
    var cellClass: String! {set get}
}

public protocol XBSecModelLayoutProtocol {
    var edgeInsets: UIEdgeInsets? {set get}
    var lineSpace: CGFloat? {set get}
    var rowSpace: CGFloat? {set get}
}


public protocol XBSecModelProtocol {
    var items: [XBCellModelProtol]! {set get}
}


//控制sec下的cell的展开与收起
public protocol XBSecCloseModelProtocol {
    var isClose: Bool? {set get}
}

public protocol XBSecEmptyModelProtocol {
    var isEmpty: Bool? {set get}
    var emptySize: CGSize? {set get}
    var emptyClass: String? {set get}
}



public protocol XBSecHeaderModelProtocol: XBSecModelProtocol {
    var headerSize: CGSize? {set get}
    var headerClass: String? {set get}
}

//MARK: footerEdit
public protocol XBFooterEditModelProtocol {
    var isFooterEdit: Bool? {set get}
    var footerEditSize: CGSize? {set get}
    
}


public protocol XBSecHeaderFooterModelProtocol: XBSecModelProtocol & XBSecHeaderModelProtocol {
    var footerSize: CGSize? {set get}
    var footerClass: String? {set get}
}

public protocol XBAllSecModelProtocol: XBSecHeaderFooterModelProtocol & XBEditModelProtocol & XBSecModelLayoutProtocol & XBSelectedModelProtocol & XBFooterEditModelProtocol & XBSecCloseModelProtocol {
    
}

public protocol XBAllDataModelProtocol: XBCellModelProtol & XBEditModelProtocol & XBSecEmptyModelProtocol & XBSelectedModelProtocol {
    
}

//MARK: Protocol-extension

extension XBSecHeaderFooterModelProtocol {
    var footerSize: CGSize? {XBListDefaultSecSize}
    var footerClass: String? {NSStringFromClass(UICollectionReusableView.self)}
}
extension XBFooterEditModelProtocol {
    var isFooterEdit: Bool? {false}
    var footerEditSize: CGSize? {XBListDefaultSecSize}
}
extension XBSecHeaderModelProtocol {
    
    var headerSize: CGSize? {XBListDefaultSecSize}
    var headerClass: String? {NSStringFromClass(UICollectionReusableView.self)}
}
extension XBSecEmptyModelProtocol {
    var isEmpty: Bool? {false}
    var emptySize: CGSize? {CGSize(width: XBScreenW, height: XBScreenH)}
    var emptyClass: String? {NSStringFromClass(UICollectionReusableView.self)}
}
extension XBSecCloseModelProtocol {
    var isClose: Bool? {false}
}
extension XBSecModelProtocol {
    var items: [XBCellModelProtol]! {[]}
}
extension XBEditModelProtocol {
    var isEdit: Bool? {false}
    var editSize: CGSize? {XBListDefaultSecSize}
}
extension XBSelectedModelProtocol {
    var isSelected: Bool? {false}
}
extension XBSecModelLayoutProtocol {
    var edgeInsets: UIEdgeInsets? {.zero}
    var lineSpace: CGFloat? {0.0}
    var rowSpace: CGFloat? {0.0}
}
