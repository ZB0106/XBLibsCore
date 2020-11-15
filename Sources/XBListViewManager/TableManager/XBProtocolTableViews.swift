//
//  XBProtocolTableViews.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/15.
//

import UIKit
import SnapKit

//MARK：CellDataDelgate
@objc public protocol XBTableCellDelegateDataProtocol {
    var indexPath: IndexPath! {get set}
    weak var delegate: XBTableCelldelegate? { get set }
}

public protocol XBTabelCellDataProtocol {
    func configureCellData(item: XBCellModelProtol)
}
//extension XBCollectionCellDataProtocol {
//    public func configureCellData(item: XBCellModelProtol) {}
//}
//合并celldataDelegate
public protocol XBTableCellDelgateAndDataProtocol: XBTableCellDelegateDataProtocol & XBTabelCellDataProtocol {}


//MARK：secViewDataDelgate
@objc public protocol XBTableSecViewDelegateDataProtocol {
    var section: NSNumber! {get set}
    weak var delegate: XBTableSecViewdelegate? { get set }
}

public protocol XBTableSecViewDataProtocol {
    
    func configureSecViewData(section: XBSecModelProtocol)
}
//extension XBCollectionSecViewDataProtocol {
//    public func configureSecViewData(section: XBSecModelProtocol) {}
//}
//合并delelegate
protocol XBTableSecViewDataAndDelegateProtocol: XBTableSecViewDelegateDataProtocol & XBTableSecViewDataProtocol {}


//BaseViews
open class XBBaseProtocolTableCell: UITableViewCell, XBTableCellDelgateAndDataProtocol {
    weak public var delegate: XBTableCelldelegate?
    public func configureCellData(item: XBCellModelProtol) {
        
    }
    
    public var indexPath: IndexPath!
   
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeAddSubViews()
        self.makeLayoutSubViews()
    }
}
extension XBBaseProtocolTableCell {
    @objc open func makeAddSubViews() {
         
     }
     @objc open func makeLayoutSubViews() {
         
     }
}


open class XBBaseProtocolTableSecView: UITableViewHeaderFooterView, XBTableSecViewDataAndDelegateProtocol {
    
    lazy var emptyTitleView: UILabel = {
        let label = UILabel()
        label.text = "暂无数据"
        return label
    }()
    lazy var emptyContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    weak public var delegate : XBTableSecViewdelegate?
    public var section: NSNumber!
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.makeAddSubViews()
        self.makeLayoutSubViews()
    }
   
    public func configureSecViewData(section: XBSecModelProtocol) {}
    
}
extension XBBaseProtocolTableSecView  {
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
