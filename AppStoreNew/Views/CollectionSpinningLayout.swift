//
//  CollectionSpinningLayout.swift
//  AppStoreNew
//
//  Created by Nuno Pereira on 23/03/2019.
//  Copyright © 2019 Nuno Pereira. All rights reserved.
//

import UIKit


//FIXME: Needs to be improved
class CollectionSpinningLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let cv = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: cv.bounds.width, height: cv.bounds.height)
        
        let attributes = layoutAttributesForElements(in: targetRect)
        
        attributes?.forEach({ print($0.indexPath, $0.frame) })
        
        let attrs = layoutAttributesForItem(at: IndexPath(item: 0, section: 0))
        print("Offset: ", proposedContentOffset)
        
        let itemWidth = attrs?.frame.width ?? 0.0
        print("itemWidth:",itemWidth)
        var pageNumber = round(proposedContentOffset.x / itemWidth)
        print("pageNumber:", pageNumber)
        
        if velocity.x > 0 {
            pageNumber += 1
        } else {
            pageNumber -= 1
        }
        
        return .init(x: pageNumber * itemWidth + pageNumber * minimumLineSpacing - cv.contentInset.left, y: proposedContentOffset.y)
    }
}
