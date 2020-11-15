//
//  XBBaseCollectionViews.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/15.
//

import UIKit

class XBBaseCollectionCell: UICollectionViewCell {
    
    weak open var delegate : XBCollectionCelldelegate?
    open var dataModel : XBBaseDataModel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeAddSubViews()
        self.makeLayoutSubViews()
    }
}
extension XBBaseCollectionCell {
    @objc func makeLayoutSubViews() {
       
    }
    @objc func makeAddSubViews() {
       
    }
}


class XBBaseCollectionSecView: UICollectionReusableView {
    
    
    weak open var delegate : XBCollectionSectionViewdelegate?
    var secModel : XBBaseSectionModel!
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeAddSubViews()
        self.makeLayoutSubViews()
    }
   
}
extension XBBaseCollectionSecView  {
    
   @objc func makeAddSubViews() {
        
    }
    @objc func makeLayoutSubViews() {
        
    }
}
