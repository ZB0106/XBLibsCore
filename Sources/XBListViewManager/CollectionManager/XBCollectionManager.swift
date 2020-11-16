//
//  XBListManager.swift
//  WZEfengAndEtong
//
//  Created by rongzebing on 2018/8/7.
//  Copyright © 2018年 wanzhao. All rights reserved.
//

import UIKit



public class XBCollectionManager: NSObject {
    
   
    weak private var emptyView: UIView?
    public var sectionArray = [XBSecModelProtocol]()
    public var collectionView : UICollectionView!
    weak public var delegate : XBCollectionManagerDelegate?
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        () -> UICollectionViewFlowLayout in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = .zero
        return flowLayout
    }()
    
    public func createCollectionView(flowLayout: UICollectionViewFlowLayout? = nil, direction: UICollectionView.ScrollDirection = .vertical, emptyView: UIView? = nil) -> UICollectionView {
        let flow = flowLayout != nil ? flowLayout : self.flowLayout
        flow?.scrollDirection = direction
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flow!)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        if emptyView != nil {
            emptyView?.isHidden = true
            collectionView.addSubview(emptyView!)
        }
        self.collectionView = collectionView
        return collectionView
    }
    public func reloadData() {
        collectionView.reloadData()
        if emptyView != nil {
            if sectionArray.count == 0 {
                emptyView?.isHidden = false
                collectionView.bringSubviewToFront(emptyView!)
            } else {
                emptyView?.isHidden = true
            }
        }
    }
}

extension XBCollectionManager : XBCollectionSectionViewdelegate {
    
    public func handelSectionViewEvent(indexPath: IndexPath, eventID: Int) {
        self.delegate?.handelSectionViewEvent?(indexPath: indexPath, eventID: eventID)
    }
}

extension XBCollectionManager : XBCollectionCelldelegate {
    public func handelCollectionCellEvent(indexPath: IndexPath, eventHandel eventID: Int) {
        self.delegate?.handelCollectionCellEvent?(indexPath: indexPath, eventHandel: eventID)
    }
}

extension XBCollectionManager : UICollectionViewDataSource {
    
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
        let secModel = self.sectionArray[section]
        
        if (secModel as? XBSecEmptyModelProtocol)?.isEmpty == true {
            return 0
        }
        if (secModel as? XBSecCloseModelProtocol)?.isClose == true {
            return 0
        }
        return secModel.items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let tm = self.delegate?.XBcollectionView?(collectionView, cellForItemAt: indexPath) {
            return tm
        }
        let secModel = self.sectionArray[indexPath.section]
        let dataModel = secModel.items[indexPath.row]
        let collectionCell = collectionView.XBDequeueReusableCollectionCell(withClassName: dataModel.cellClass, clsType: NSClassFromString(dataModel.cellClass), for: indexPath)
        if let collectionCell = collectionCell as? XBCollectionCellDataProtocol{
            collectionCell.configureCellData(item: dataModel)
        }
        if let collectionCell = collectionCell as? XBCollectionCellDelegateDataProtocol {
            collectionCell.delegate = self
            collectionCell.indexPath = indexPath
        }
        return collectionCell
    }
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let tm = self.delegate?.XBcollectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath) {
            return tm
        }
        let secModel = self.sectionArray[indexPath.section]
        var clsType: AnyClass?
        var clsName: String = ""
        
        let emptySecModel = secModel as? XBSecEmptyModelProtocol
        if emptySecModel?.isEmpty == true {
            clsName = emptySecModel?.emptyClass ?? ""
            clsType = NSClassFromString(clsName)
        } else {
            if (secModel as? XBSecHeaderModelProtocol)?.headerClass != nil && kind == UICollectionView.elementKindSectionHeader {
                clsName = (secModel as! XBSecHeaderModelProtocol).headerClass!
                clsType = NSClassFromString(clsName)
            } else if (secModel as? XBSecHeaderFooterModelProtocol)?.footerClass != nil && kind == UICollectionView.elementKindSectionFooter {
                clsName = (secModel as! XBSecHeaderFooterModelProtocol).headerClass!
                clsType = NSClassFromString(clsName)
            } else {}
        }
        
        //安全检测
        if clsName.count == 0 || clsType == nil {
            clsName = NSStringFromClass(UICollectionReusableView.self)
            clsType = UICollectionReusableView.self
        }
        
        let secView = collectionView.XBDequeueReusableSupplementaryView(withClassName: clsName, clsType: clsType, ofKind: kind, for: indexPath)

        if let secView = secView as? XBCollectionSecViewDataProtocol {
            secView.configureSecViewData(section: secModel)
        }
        if let secView = secView as? XBCollectionCellDelegateDataProtocol {
            secView.delegate = self
            secView.indexPath = indexPath
        }
        return secView
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

extension XBCollectionManager : UICollectionViewDelegate {
    
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
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.XBcollectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    //MARK: scrollDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.XBcollectionViewDidScroll?(scrollView)
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.XBscrollViewDidEndDecelerating?(scrollView)
    }
   
}
extension XBCollectionManager : UICollectionViewDelegateFlowLayout {
    //MARK : FLowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        if let edgeInsets = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, insetForSectionAt: section) {
            return edgeInsets
        }
       
        let secModel = self.sectionArray[section]
        var edgeInsets = UIEdgeInsets.zero
        if (secModel as? XBSecEmptyModelProtocol)?.isEmpty == true {
            return edgeInsets
        }
        if let secModel = secModel as? XBSecModelLayoutProtocol {
            edgeInsets = secModel.edgeInsets ?? .zero
        }
        return edgeInsets
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        if let tm = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) {
            return tm
        }
        let secModel = self.sectionArray[section]
        var lineSpace: CGFloat = 0.0
        if let secModel = secModel as? XBSecModelLayoutProtocol {
            lineSpace = secModel.lineSpace ?? 0.0
        }
        return lineSpace
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        if let tm = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section) {
            return tm
        }
        let secModel = self.sectionArray[section]
        var rowSpace: CGFloat = 0.0
        if let secModel = secModel as? XBSecModelLayoutProtocol {
            rowSpace = secModel.lineSpace ?? 0.0
        }
        return rowSpace
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if let tm = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section) {
            return tm
        }
        let secModel = self.sectionArray[section]
       
        if let secModel = secModel as? XBSecEmptyModelProtocol {
            if secModel.isEmpty ?? false {
                return secModel.emptySize ?? .zero
            }
        }
        if let secModel = secModel as? XBEditModelProtocol {
            if secModel.isEdit ?? false {
                return secModel.editSize ?? XBListDefaultSecSize
            }
        }
        var size = XBListDefaultSecSize
        if let secModel = secModel as? XBSecHeaderModelProtocol {
            size = secModel.headerSize ?? XBListDefaultSecSize
        }
        return size
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
       
        if let tm = self.delegate?.XBcollectionView?(collectionView,layout:collectionViewLayout, referenceSizeForFooterInSection: section) {
            return tm
        }
        
        let secModel = self.sectionArray[section]
        
        if let secModel = secModel as? XBFooterEditModelProtocol {
            if secModel.isFooterEdit ?? false {
                return secModel.footerEditSize ?? XBListDefaultSecSize
            }
        }
        var size = XBListDefaultSecSize
        if let secModel = secModel as? XBSecHeaderFooterModelProtocol {
            size = secModel.footerSize ?? XBListDefaultSecSize
        }
        return size
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let tm = self.delegate?.XBcollectionView?(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) {
            return tm
        }
        let secModel = self.sectionArray[indexPath.section]
        let dataModel = secModel.items[indexPath.row]
        if let dataModel = dataModel as? XBEditModelProtocol {
            if dataModel.isEdit ?? false {
                return dataModel.editSize ?? .zero
            }
        }
        return dataModel.cellSize
    }
}
