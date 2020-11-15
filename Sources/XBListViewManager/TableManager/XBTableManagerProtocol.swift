//
//  XBTableManagerProtocol.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/15.
//

import UIKit

@objc public protocol XBTableCelldelegate : class {
    
    @objc optional func handelTableCellEvent(indexPath: IndexPath, eventID : Int)
}
@objc public protocol XBTableSecViewdelegate : class {
    
    @objc optional func handelTableSecViewEvent(section: Int, eventID : Int)
}


@objc public protocol XBTableViewManagerDelegate: XBTableCelldelegate & XBTableSecViewdelegate & XBTableViewDataSource & XBTableViewDelegate {
    
}


@objc public protocol XBTableViewDataSource: class {
    @objc optional func XBnumberOfSections(in tableView: UITableView) -> Int
    @objc optional func XBtableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    @objc optional func XBtableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    @objc optional func XBtableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func XBtableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    @objc optional func XBtableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @objc optional func XBtableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    @objc optional func XBtableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?

    @objc optional func XBtableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?

    @objc optional func XBtableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    
    @available(iOS 11.0, *)
    @objc optional func XBtableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?

    @available(iOS 11.0, *)
    @objc optional func XBtableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?

    @objc optional func XBtableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    @objc optional func XBtableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    @objc optional func XBtableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
}
@objc public protocol XBTableViewDelegate: class {
    @objc optional func XBtableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func XBtableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    @objc optional func XBtableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc optional func XBtableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)

}
