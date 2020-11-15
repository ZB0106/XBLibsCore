//
//  XBBaseTableViews.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/15.
//

import UIKit

//MARK: XBBaseTableCell
open class XBBaseTableCell: UITableViewCell {
    weak open var delegate: XBTableCelldelegate?
    public var dataModel: XBBaseDataModel!
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        makeAddSubViews()
        makeLayoutSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension XBBaseTableCell  {
    @objc func makeLayoutSubViews() {
        
    }
    @objc func makeAddSubViews() {
        
    }
}

//MARK: XBBaseTableSectionView
open class XBBaseTableSectionView: UITableViewHeaderFooterView {
    weak open var delegate: XBTableSecViewdelegate?
    public var secModel: XBBaseSectionModel!
    required public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView .backgroundColor = UIColor.white
        makeAddSubViews()
        makeLayoutSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension XBBaseTableSectionView  {
    @objc func makeLayoutSubViews() {
        
    }
    @objc func makeAddSubViews() {
        
    }
}
