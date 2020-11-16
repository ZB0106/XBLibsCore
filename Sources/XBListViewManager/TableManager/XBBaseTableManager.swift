//
//  XBBaseTableManager.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/15.
//

import UIKit


public class XBBaseTableViewManager: NSObject {
    
    public var sectionArray = [XBBaseSectionModel]()
    weak public var delegate: XBTableViewManagerDelegate?
    public var tableView: UITableView!
    func createTableView(style: UITableView.Style = .grouped, separatorStyle: UITableViewCell.SeparatorStyle = .none) -> UITableView {
        let temTableView = UITableView.init(frame: .zero, style: style)
        temTableView.delegate = self
        temTableView.dataSource = self
        temTableView.backgroundColor = UIColor.white
        temTableView.separatorStyle = .none
        temTableView.keyboardDismissMode = .onDrag
        temTableView.showsVerticalScrollIndicator = false
        //关闭自动估算高度
        temTableView.estimatedSectionHeaderHeight = 0.0
        temTableView.estimatedSectionFooterHeight = 0.0
        temTableView.estimatedRowHeight = 0.0
        //end
        self.tableView = temTableView
        return temTableView
    }
    
    public func reloadData() {
        tableView.reloadData()
    }
}

extension XBBaseTableViewManager: XBTableSecViewdelegate, XBTableCelldelegate {
    public func handelTableSecViewEvent(section: Int, eventID: Int) {
        self.delegate?.handelTableSecViewEvent?(section: section, eventID: eventID)
    }
    public func handelTableCellEvent(indexPath: IndexPath, eventID: Int) {
        self.delegate?.handelTableCellEvent?(indexPath: indexPath, eventID: eventID)
    }
}

extension XBBaseTableViewManager : UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let tm = self.delegate?.XBnumberOfSections?(in: tableView) {
            return tm
        }
        return sectionArray.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let tm = self.delegate?.XBtableView?(tableView, numberOfRowsInSection: section) {
            return tm
        }
        let secModel = sectionArray[section]
        if secModel.isEmpty {
            return 0
        }
        if secModel.isClose {
            return 0
        }
        return secModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tm = self.delegate?.XBtableView?(tableView, cellForRowAt: indexPath) {
            return tm
        }
        let secModel = self.sectionArray[indexPath.section]
        
        var cell : XBBaseTableCell?
        let dataModel = secModel.items[indexPath.row]
        var clsName: String = ""
        var clsType: AnyClass?
        if dataModel.cellClass != nil {
            clsName = dataModel.cellClass!
            clsType = NSClassFromString(clsName)
        }
        if clsName.count == 0 || clsType == nil {
            clsName = NSStringFromClass(XBBaseTableCell.self)
            clsType = XBBaseTableCell.self
        }
        cell = tableView.XBDequeueReusableTableCell(withClassName: clsName, clsType: clsType) as? XBBaseTableCell
        cell?.configureCellData(dataModel)
        cell?.indexPath = indexPath
        cell?.delegate = self
        
        return cell!
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let tm = self.delegate?.XBtableView?(tableView, viewForHeaderInSection: section) {
            return tm
        }
        let secModel = sectionArray[section]
        var clsName: String = ""
        var clsType: AnyClass?
        if secModel.isEmpty {
            clsName = secModel.emptyClass ?? ""
            clsType = NSClassFromString(clsName)
        } else {
            if secModel.headerClass != nil{
                clsName = secModel.headerClass!
                clsType = NSClassFromString(clsName)
            }
        }
        if clsName.count == 0 || clsType == nil {
            clsName = NSStringFromClass(XBBaseTableSectionView.self)
            clsType = XBBaseTableSectionView.self
        }
        let view = tableView.XBDequeueReusableHeaderFooterView(withClassName: clsName, clsType: clsType) as? XBBaseTableSectionView
        view?.configureSecViewData(secModel)
        view?.section = section
        view?.delegate = self
        return view
    }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.delegate?.XBtableView?(tableView, titleForHeaderInSection: section)
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if let tm = self.delegate?.XBtableView?(tableView, viewForFooterInSection: section) {
            return tm
        }
        let secModel = sectionArray[section]
        var clsName: String = ""
        var clsType: AnyClass?
        if secModel.footerClass != nil{
            clsName = secModel.footerClass!
            clsType = NSClassFromString(clsName)
        }
        if clsName.count == 0 || clsType == nil {
            clsName = NSStringFromClass(XBBaseTableSectionView.self)
            clsType = XBBaseTableSectionView.self
        }
        let view = tableView.XBDequeueReusableHeaderFooterView(withClassName: clsName, clsType: clsType) as? XBBaseTableSectionView
        view?.configureSecViewData(secModel)
        view?.section = section
        view?.delegate = self
        return view
    }
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.delegate?.XBtableView?(tableView, titleForFooterInSection: section)
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let tm = self.delegate?.XBtableView?(tableView, heightForHeaderInSection: section) {
            return tm
        }
        let secModel = sectionArray[section]
        if secModel.isEmpty {
            return secModel.emptySize.height
        }
        if secModel.isEdit {
            return secModel.editHeaderSize.height
        }
        return secModel.headerSize.height
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let tm = self.delegate?.XBtableView?(tableView, heightForFooterInSection: section) {
            return tm
        }
        let secModel = sectionArray[section]
        if secModel.isFooterEdit {
            return secModel.editFooterSize.height
        }
        return secModel.footerSize.height
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let tm = self.delegate?.XBtableView?(tableView, heightForRowAt: indexPath) {
            return tm
        }
        let secModel = sectionArray[indexPath.section]
        let dataModel = secModel.items[indexPath.row]
        
        if dataModel.isEdit {
            return dataModel.editCellSize.height
        }
        return dataModel.cellSize.height
    }
   

    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return self.delegate?.XBtableView?(tableView, editActionsForRowAt: indexPath)
    }
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.delegate?.XBtableView?(tableView, canEditRowAt: indexPath) ?? false
    }
    
    @available(iOS 11.0, *)
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.delegate?.XBtableView?(tableView, leadingSwipeActionsConfigurationForRowAt: indexPath)
    }

    @available(iOS 11.0, *)
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.delegate?.XBtableView?(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
    }
   
}
extension XBBaseTableViewManager : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.XBtableView?(tableView, didSelectRowAt: indexPath)
    }
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    self.delegate?.XBtableView?(tableView, didDeselectRowAt: indexPath)
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.delegate?.XBtableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.delegate?.XBtableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
}
