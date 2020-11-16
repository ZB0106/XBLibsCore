//
//  XBListManager.swift
//  WZEfengAndEtong
//
//  Created by rongzebing on 2018/8/7.
//  Copyright © 2018年 wanzhao. All rights reserved.
//

import UIKit


public class XBBaseCollectionManager: NSObject {
    
    public var sectionArray = [XBBaseSectionModel]()
    public var collectionView : UICollectionView!
    weak public var delegate : XBCollectionManagerDelegate?
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        () -> UICollectionViewFlowLayout in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .zero
        return flowLayout
    }()
    
    public func createCollectionView(flowLayout: UICollectionViewFlowLayout? = nil, direction: UICollectionView.ScrollDirection = .vertical) -> UICollectionView {
        let flow = flowLayout != nil ? flowLayout : self.flowLayout
        flow?.scrollDirection = direction
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flow!)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        self.collectionView = collectionView
        return collectionView
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
    
}
extension XBBaseCollectionManager : XBCollectionSectionViewdelegate {
    
    public func handelSectionViewEvent(indexPath: IndexPath, eventID: Int) {
        self.delegate?.handelSectionViewEvent?(indexPath: indexPath, eventID: eventID)
    }
}

extension XBBaseCollectionManager : XBCollectionCelldelegate {
    public func handelCollectionCellEvent(indexPath: IndexPath, eventHandel eventID: Int) {
        self.delegate?.handelCollectionCellEvent?(indexPath: indexPath, eventHandel: eventID)
    }
}
extension XBBaseCollectionManager : UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if let tm = self.delegate?.XBnumberOfSections?(in: collectionView) {
            return tm
        }
        return self.sectionArray.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let tm = self.delegate?.XBcollectionView?(collectionView, numberOfItemsInSection: section) {
            return tm
        }
        let secModel : XBBaseSectionModel = self.sectionArray[section]
        if secModel.isEmpty {
            return 0
        }
        if secModel.isClose {
            return 0
        }
        return secModel.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let tm = self.delegate?.XBcollectionView?(collectionView, cellForItemAt: indexPath) {
            return tm
        }
        let secModel = self.sectionArray[indexPath.section]
        
        var collectionCell : XBBaseCollectionCell?
        let dataModel = secModel.items[indexPath.row]
        var clsName: String = ""
        var clsType: AnyClass?
        if dataModel.cellClass != nil {
            clsName = dataModel.cellClass!
            clsType = NSClassFromString(clsName)
           
        }
        if clsName.count == 0 || clsType == nil {
            clsName = NSStringFromClass(XBBaseCollectionCell.self)
            clsType = XBBaseCollectionCell.self
        }
        collectionCell = collectionView.XBDequeueReusableCollectionCell(withClassName: clsName, clsType: clsType, for: indexPath) as? XBBaseCollectionCell
        collectionCell!.configureCellData(dataModel)
        collectionCell?.indexPath = indexPath
        collectionCell!.delegate = self
        return collectionCell!
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let tm = self.delegate?.XBcollectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath) {
            return tm
        }
        let secModel = self.sectionArray[indexPath.section]
        var clsName: String = ""
        var clsType: AnyClass?
        if secModel.isEmpty {
            clsName = secModel.emptyClass ?? ""
            clsType = NSClassFromString(clsName)
        } else {
            if secModel.headerClass != nil && kind == UICollectionView.elementKindSectionHeader {
                clsName = secModel.headerClass!
                clsType = NSClassFromString(clsName)
            } else if secModel.footerClass != nil && kind == UICollectionView.elementKindSectionFooter {
                clsName = secModel.footerClass!
                clsType = NSClassFromString(clsName)
            }
        }
        if clsName.count == 0 || clsType == nil {
            clsName = NSStringFromClass(XBBaseCollectionSecView.self)
            clsType = UICollectionReusableView.self
        }
        let view = collectionView.XBDequeueReusableSupplementaryView(withClassName: clsName, clsType: clsType, ofKind: kind, for: indexPath) as! XBBaseCollectionSecView
        view.configureSecViewData(secModel)
        view.indexPath = indexPath
        view.delegate = self
        return view
    }

    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return self.delegate?.XBcollectionView?(collectionView, canMoveItemAt: indexPath) ?? false
    }

    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        self.delegate?.XBcollectionView?(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }

    public func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return self.delegate?.XBindexTitles?(for: collectionView)
    }
}

extension XBBaseCollectionManager : UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sec = sectionArray[indexPath.section]
        if sec.items.count == 0 {
            return
        }
        self.delegate?.XBcollectionView?(collectionView, didSelectItemAt: indexPath)
    }
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let sec = sectionArray[indexPath.section]
        if sec.items.count == 0 {
            return
        }
        self.delegate?.XBcollectionView?(collectionView, didDeselectItemAt: indexPath)
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.XBcollectionViewDidScroll?(scrollView)
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.XBscrollViewDidEndDecelerating?(scrollView)
    }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.XBcollectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
}
extension XBBaseCollectionManager : UICollectionViewDelegateFlowLayout {
    //MARK : FLowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        if let edgeInsets = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, insetForSectionAt: section) {
            return edgeInsets
        }
       
        let secModel = self.sectionArray[section]
        if secModel.isEmpty {
            return .zero
        }
        return secModel.edgeInsets
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        if let tm = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) {
            return tm
        }
        let secModel = self.sectionArray[section]
        return secModel.lineSpace
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        if let tm = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section) {
            return tm
        }
        let secModel = self.sectionArray[section]
        return secModel.rowSpace
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if let tm = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section) {
            return tm
        }
        let secModel = self.sectionArray[section]
        if secModel.isEmpty {
            return secModel.emptySize
        }
        if secModel.isEdit {
            return secModel.editHeaderSize
        }
        return secModel.headerSize
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
       
        if let tm = self.delegate?.XBcollectionView?(collectionView,layout:collectionViewLayout, referenceSizeForFooterInSection: section) {
            return tm
        }
        let secModel = self.sectionArray[section]
        if secModel.isFooterEdit {
            return secModel.editFooterSize
        }
        return secModel.footerSize
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let tm = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) {
            return tm
        }
        let secModel = self.sectionArray[indexPath.section]
        let dataModel = secModel.items[indexPath.row]
        if dataModel.isEdit {
            return dataModel.editCellSize
        }
        return dataModel.cellSize
    }
}
