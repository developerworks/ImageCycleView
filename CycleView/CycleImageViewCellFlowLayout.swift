//
//  CycleImageViewCellFlowLayout.swift
//  CycleView
//
//  Created by hezhiqiang on 2018/4/9.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import UIKit

class CycleImageViewCellFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        //尺寸
        self.itemSize = (self.collectionView?.bounds.size)!
        //间距
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        //滚动方向
        self.scrollDirection = .horizontal
    }
}
