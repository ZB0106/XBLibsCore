//
//  ZB_CollectionViews.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/14.
//

import UIKit
import SnapKit

//MARK：CellDataDelgate
@objc public protocol XBCollectionCellDelegateDataProtocol {
    var indexPath: IndexPath! {get set}
    weak var delegate: XBCollectionCelldelegate? { get set }
}

public protocol XBCollectionCellDataProtocol {
    func configureCellData(item: XBCellModelProtol)
}
//extension XBCollectionCellDataProtocol {
//    public func configureCellData(item: XBCellModelProtol) {}
//}
//合并celldataDelegate
public protocol XBCollectionCellDelgateAndDataProtocol: XBCollectionCellDataProtocol & XBCollectionCellDelegateDataProtocol {}


//MARK：secViewDataDelgate
@objc public protocol XBCollectionSecViewDelegateDataProtocol {
    var indexPath: IndexPath! {get set}
    weak var delegate: XBCollectionSectionViewdelegate? { get set }
}

public protocol XBCollectionSecViewDataProtocol {
    
    func configureSecViewData(section: XBSecModelProtocol)
}
//extension XBCollectionSecViewDataProtocol {
//    public func configureSecViewData(section: XBSecModelProtocol) {}
//}
//合并delelegate
protocol XBCollectionSecViewDataAndDelegateProtocol: XBCollectionSecViewDelegateDataProtocol & XBCollectionSecViewDelegateDataProtocol {}


//BaseViews
open class XBBaseProtocolCollectionCell: UICollectionViewCell, XBCollectionCellDelgateAndDataProtocol {
    public func configureCellData(item: XBCellModelProtol) {
        
    }
    
    public var indexPath: IndexPath!
    weak public var delegate: XBCollectionCelldelegate?
   
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeAddSubViews()
        self.makeLayoutSubViews()
    }
}
extension XBBaseProtocolCollectionCell {
    @objc open func makeAddSubViews() {
         
     }
     @objc open func makeLayoutSubViews() {
         
     }
}


open class XBBaseProtocolCollectionSecView: UICollectionReusableView, XBCollectionSecViewDataAndDelegateProtocol {
    
    lazy var emptyTitleView: UILabel = {
        let label = UILabel()
        label.text = "暂无数据"
        return label
    }()
    lazy var emptyContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    weak public var delegate : XBCollectionSectionViewdelegate?
    public var indexPath: IndexPath!
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeAddSubViews()
        self.makeLayoutSubViews()
    }
   
    
    
    func configureSecViewData(section: XBSecModelProtocol) {}
    
}
extension XBBaseProtocolCollectionSecView  {
    @objc open func makeLayoutSubViews() {
        emptyContentView.snp.makeConstraints { (make) in
           make.edges.equalToSuperview()
        }
        emptyTitleView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    @objc open func makeAddSubViews() {
        emptyContentView.addSubview(emptyTitleView)
        self.addSubview(emptyContentView)
    }
}
