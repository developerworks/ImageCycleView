//
//  CycleImageViewCell.swift
//  CycleView
//
//  Created by hezhiqiang on 2018/4/9.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import UIKit

class CycleImageViewCell: UICollectionViewCell {
    var mode : ContentMode? {
        didSet{
            switch mode ?? .scaleAspectFill {
            case .scaleAspectFill:
                imageView.contentMode = .scaleAspectFill
            case .scaleAspectFit:
                imageView.contentMode = .scaleAspectFit
            }
        }
    }
    
    //FIXME: 本地和网络下载走的不同路径
    var imageURLString : String? {
        didSet{
            if (imageURLString?.hasPrefix("http"))! {
                //网络图片:使用SDWebImage下载即可
            } else {
                //本地图片
                imageView.image = UIImage(named: imageURLString!)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 懒加载
    lazy var imageView : UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.clipsToBounds = true
        return imageView
    }()
}

extension CycleImageViewCell {
    private func setUpUI() {
        self.contentView.addSubview(imageView)
    }
}
