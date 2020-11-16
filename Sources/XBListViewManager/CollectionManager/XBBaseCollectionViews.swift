//
//  XBBaseCollectionViews.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/15.
//

import UIKit

open class XBBaseCollectionCell: UICollectionViewCell {
    
    weak open var delegate : XBCollectionCelldelegate?
    open var indexPath : IndexPath!
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeAddSubViews()
        self.makeLayoutSubViews()
    }
}
extension XBBaseCollectionCell {
    @objc open func configureCellData(_ item: XBBaseDataModel) {
        
    }
    @objc open func makeLayoutSubViews() {
       
    }
    @objc open func makeAddSubViews() {
       
    }
}


open class XBBaseCollectionSecView: UICollectionReusableView {
    
    
    weak open var delegate : XBCollectionSectionViewdelegate?
    var indexPath : IndexPath!
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeAddSubViews()
        self.makeLayoutSubViews()
    }
   
}
extension XBBaseCollectionSecView  {
    @objc open func configureSecViewData(_ section: XBBaseSectionModel) {
        
    }
   @objc open func makeAddSubViews() {
        
    }
    @objc open func makeLayoutSubViews() {
        
    }
}
