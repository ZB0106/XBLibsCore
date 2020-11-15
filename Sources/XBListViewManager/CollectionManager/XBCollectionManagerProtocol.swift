//
//  XBCollectionManagerProtocol.swift
//  XBGitDemo
//
//  Created by 苹果兵 on 2020/11/15.
//

import UIKit

//MARK: SecViewDelegate
@objc public protocol XBCollectionSectionViewdelegate :  NSObjectProtocol {
    @objc optional func handelSectionViewEvent(indexPath: IndexPath, eventID: Int)
}
//MARK:CollectionCellDelegate
@objc public protocol XBCollectionCelldelegate:  NSObjectProtocol {
    
    @objc optional func handelCollectionCellEvent(indexPath: IndexPath, eventHandel: Int)
}



@objc public protocol XBUICollectionViewDataSource: NSObjectProtocol {
    @objc optional func XBnumberOfSections(in collectionView: UICollectionView) -> Int
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
   
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    
    
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    
    @objc optional func XBCollectionView(_ collectionView: UICollectionView, cellForItem cell: UICollectionViewCell, at indexPath: IndexPath)
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool

    @objc optional func XBcollectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)

    @objc optional func XBindexTitles(for collectionView: UICollectionView) -> [String]?

    @objc optional func XBcollectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath
}


@objc public protocol XBUICollectionViewDelegate: NSObjectProtocol {
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    @objc optional func XBcollectionViewDidScroll(_ scrollView: UIScrollView)
    @objc optional func XBscrollViewDidEndDecelerating(_ scrollView: UIScrollView)
}
@objc public protocol XBUICollectionViewDelegateFlowLayout {
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    
   @objc optional func XBcollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    
    @objc optional func XBcollectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize
}
@objc public protocol XBCollectionManagerDelegate :XBCollectionCelldelegate&XBCollectionSectionViewdelegate&XBUICollectionViewDelegate&XBUICollectionViewDataSource&XBUICollectionViewDelegateFlowLayout {
    
}

extension XBCollectionManagerDelegate {
    
}
