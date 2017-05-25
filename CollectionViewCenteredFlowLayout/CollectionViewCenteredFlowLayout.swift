
// Copyright (c) 2017 Cœur
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

/**
 *  Simple UICollectionViewFlowLayout that centers the cells rather than justify them
 *
 *  Based on https://github.com/Coeur/UICollectionViewLeftAlignedLayout
 */
open class CollectionViewCenteredFlowLayout: UICollectionViewFlowLayout {
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributesForElements = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        guard let collectionView = collectionView else {
            return layoutAttributesForElements
        }
        // we group copies of the elements from the same row/column
        var representedElements: [UICollectionViewLayoutAttributes] = []
        var cells: [[UICollectionViewLayoutAttributes]] = [[]]
        var previousFrame: CGRect? = nil
        for layoutAttributes in layoutAttributesForElements {
            guard layoutAttributes.representedElementKind == nil else {
                representedElements.append(layoutAttributes)
                continue
            }
            let currentItemAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
            if previousFrame != nil {
                if scrollDirection == .vertical {
                    // if the current frame, once stretched to the full row intersects the previous frame then they are on the same row
                    if !currentItemAttributes.frame.intersects(CGRect(x: -.infinity, y: previousFrame!.origin.y, width: .infinity, height: previousFrame!.size.height)) {
                        // the item is on a different row
                        cells.append([])
                    }
                } else {
                    // if the current frame, once stretched to the full column intersects the previous frame then they are on the same column
                    if !currentItemAttributes.frame.intersects(CGRect(x: previousFrame!.origin.x, y: -.infinity, width: previousFrame!.size.width, height: .infinity)) {
                        // the item is on a different column
                        cells.append([])
                    }
                }
            }
            cells[cells.endIndex - 1].append(currentItemAttributes)
            previousFrame = currentItemAttributes.frame
        }
        return representedElements + cells.flatMap { group -> [UICollectionViewLayoutAttributes] in
            guard !group.isEmpty else {
                return group
            }
            let section = group.first!.indexPath.section
            let evaluatedSectionInset = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: self, insetForSectionAt: section) ?? sectionInset
            let evaluatedMinimumInteritemSpacing = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: section) ?? minimumInteritemSpacing
            if scrollDirection == .vertical {
                var origin = (collectionView.bounds.width + evaluatedSectionInset.left - evaluatedSectionInset.right - group.reduce(0, { $0 + $1.frame.size.width }) - CGFloat(group.count - 1) * evaluatedMinimumInteritemSpacing) / 2
                return group.map {
                    $0.frame.origin.x = origin
                    origin += $0.frame.size.width + evaluatedMinimumInteritemSpacing
                    return $0
                }
            } else {
                var origin = (collectionView.bounds.height + evaluatedSectionInset.top - evaluatedSectionInset.bottom - group.reduce(0, { $0 + $1.frame.size.height }) - CGFloat(group.count - 1) * evaluatedMinimumInteritemSpacing) / 2
                return group.map {
                    $0.frame.origin.y = origin
                    origin += $0.frame.size.height + evaluatedMinimumInteritemSpacing
                    return $0
                }
            }
        }
    }
}
