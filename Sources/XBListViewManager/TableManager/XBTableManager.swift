//
//  ZB_TableViewManager.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/14.
//

import UIKit


//MARK: sectionTable
public class XBTableManager: NSObject {
    public var sectionArray = [XBSecModelProtocol]()
    weak public var delegate: XBTableViewManagerDelegate?
    public var tableView: UITableView!
    func createTableView(style: UITableView.Style = .grouped, separatorStyle: UITableViewCell.SeparatorStyle = .none) -> UITableView {
        let temTableView = UITableView.init(frame: .zero, style: style)
        temTableView.delegate = self
        temTableView.dataSource = self
        temTableView.backgroundColor = UIColor.white
        temTableView.separatorStyle = .none
        //关闭自动估算高度
        temTableView.estimatedSectionHeaderHeight = 0.0
        temTableView.estimatedSectionFooterHeight = 0.0
        temTableView.estimatedRowHeight = 0.0
        //end
        temTableView.keyboardDismissMode = .onDrag
        temTableView.showsVerticalScrollIndicator = false
        self.tableView = temTableView
        return temTableView
    }
   public func reloadData() {
        tableView.reloadData()
    }
}

extension XBTableManager: XBTableSecViewdelegate, XBTableCelldelegate {
    public func handelTableSecViewEvent(section: Int, eventID: Int) {
        self.delegate?.handelTableSecViewEvent?(section: section, eventID: eventID)
    }
    public func handelTableCellEvent(indexPath: IndexPath, eventID: Int) {
        self.delegate?.handelTableCellEvent?(indexPath: indexPath, eventID: eventID)
    }
}

extension XBTableManager : UITableViewDataSource {
    
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
        let secModel = self.sectionArray[section]
        
        if (secModel as? XBSecEmptyModelProtocol)?.isEmpty == true {
            return 0
        }
        if (secModel as? XBSecCloseModelProtocol)?.isClose == true {
            return 0
        }
        return secModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tm = self.delegate?.XBtableView?(tableView, cellForRowAt: indexPath) {
            return tm
        }
        let secModel = self.sectionArray[indexPath.section]
        let dataModel = secModel.items[indexPath.row]
        
        let cell = tableView.XBDequeueReusableTableCell(withClassName: dataModel.cellClass, clsType: NSClassFromString(dataModel.cellClass))
        if let cell = cell as? XBTabelCellDataProtocol {
            cell.configureCellData(item: dataModel)
        }
        if let cell = cell as? XBTableCellDelegateDataProtocol {
            cell.delegate = self
            cell.indexPath = indexPath
        }
        return cell!
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let tm = self.delegate?.XBtableView?(tableView, viewForHeaderInSection: section) {
            return tm
        }
        let secModel = sectionArray[section]
        var clsName: String = ""
        var clsType: AnyClass?
        let emptySecModel = secModel as? XBSecEmptyModelProtocol
        if emptySecModel?.isEmpty == true {
            clsName = emptySecModel?.emptyClass ?? ""
            clsType = NSClassFromString(clsName)
        } else {
            if let cn = (secModel as? XBSecHeaderModelProtocol)?.headerClass {
                clsName = cn
                clsType = NSClassFromString(clsName)
            }
        }
        //安全检测
        if clsName.count == 0 || clsType == nil {
            clsName = NSStringFromClass(UITableViewHeaderFooterView.self)
            clsType = UITableViewHeaderFooterView.self
        }
        let secView = tableView.XBDequeueReusableHeaderFooterView(withClassName: clsName, clsType: clsType)
        if let secView = secView as? XBTableSecViewDataProtocol {
            secView.configureSecViewData(section: secModel)
        }
        if let secView = secView as? XBTableSecViewDelegateDataProtocol {
            secView.delegate = self
            secView.section = NSNumber(value: section)
        }
        return secView
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
        if let cn = (secModel as? XBSecHeaderFooterModelProtocol)?.footerClass {
            clsName = cn
            clsType = NSClassFromString(clsName)
        }
        if clsName.count == 0 || clsType == nil {
            clsName = NSStringFromClass(UITableViewHeaderFooterView.self)
            clsType = (UITableViewHeaderFooterView.self).self
        }
        let secView = tableView.XBDequeueReusableHeaderFooterView(withClassName: clsName, clsType: clsType)
        if let secView = secView as? XBTableSecViewDataProtocol {
            secView.configureSecViewData(section: secModel)
        }
        if let secView = secView as? XBTableSecViewDelegateDataProtocol {
            secView.delegate = self
            secView.section = NSNumber(value: section)
        }
        return secView
    }
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.delegate?.XBtableView?(tableView, titleForFooterInSection: section)
    }
    
   
}
extension XBTableManager : UITableViewDelegate {
    
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let tm = self.delegate?.XBtableView?(tableView, heightForHeaderInSection: section) {
            return tm
        }
        let secModel = sectionArray[section]
        if let secModel = secModel as? XBSecEmptyModelProtocol {
            if secModel.isEmpty ?? false {
                return secModel.emptySize?.height ?? 0.01
            }
        }
        if let secModel = secModel as? XBEditModelProtocol {
            if secModel.isEdit ?? false {
                return secModel.editSize?.height ?? 0.01
            }
        }
        var height: CGFloat = 0.01
        if let secModel = secModel as? XBSecHeaderModelProtocol {
            height = (secModel.headerSize ?? XBListDefaultSecSize).height
        }
        return height
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let tm = self.delegate?.XBtableView?(tableView, heightForFooterInSection: section) {
            return tm
        }
        let secModel = sectionArray[section]
        if let secModel = secModel as? XBFooterEditModelProtocol {
            if secModel.isFooterEdit ?? false {
                return (secModel.footerEditSize ?? XBListDefaultSecSize).height
            }
        }
        var size = XBListDefaultSecSize
        if let secModel = secModel as? XBSecHeaderFooterModelProtocol {
            size = secModel.footerSize ?? XBListDefaultSecSize
        }
        return size.height
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let tm = self.delegate?.XBtableView?(tableView, heightForRowAt: indexPath) {
            return tm
        }
        let secModel = sectionArray[indexPath.section]
        let dataModel = secModel.items[indexPath.row]
        
        if let dataModel = dataModel as? XBEditModelProtocol {
            if dataModel.isEdit ?? false {
                return (dataModel.editSize ?? .zero).height
            }
        }
        return dataModel.cellSize.height
    }
   
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.delegate?.XBtableView?(tableView, canEditRowAt: indexPath) ?? false
    }
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return self.delegate?.XBtableView?(tableView, editActionsForRowAt: indexPath)
    }

    @available(iOS 11.0, *)
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.delegate?.XBtableView?(tableView, leadingSwipeActionsConfigurationForRowAt: indexPath)
    }

    @available(iOS 11.0, *)
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return self.delegate?.XBtableView?(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
    }
    
    
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
