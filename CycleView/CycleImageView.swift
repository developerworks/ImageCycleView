//
//  CycleImageView.swift
//  CycleView
//
//  Created by hezhiqiang on 2018/4/9.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import UIKit

enum ContentMode {
    case scaleAspectFill
    case scaleAspectFit
}

protocol CycleImageViewDelegate: class {
    func didSelectedAt(_ index: NSInteger) ->()
}

class CycleImageView: UIView {
    weak var delegate : CycleImageViewDelegate?
    var mode: ContentMode = .scaleAspectFill
    let count = 100
    let cellId = "cell"
    
    // 轮播图片URL地址数组
    var imageUrlStringArray : [String]? {
        didSet{
            print("imageUrlStringArray?.count \(String(describing: imageUrlStringArray?.count))")
            pageControl.numberOfPages = (imageUrlStringArray?.count)!
            collectionView.reloadData()
            //滚动到中间位置
            let indexPath : IndexPath = IndexPath(item: (imageUrlStringArray?.count)! * self.count, section: 0)
            print("滚动到中间位置 index: \(indexPath)")
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    
    // UIPageControl 颜色
    var pageColor: UIColor? {
        didSet {
            pageControl.pageIndicatorTintColor = pageColor
        }
    }
    
    // 设置 UIPageControl 的颜色
    var currentPageColor : UIColor? {
        didSet{
            pageControl.currentPageIndicatorTintColor = currentPageColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 添加子组件
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        // 启动定时器
        timer.fireDate = Date(timeIntervalSinceNow: 2.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化 UICollectionView
    lazy var collectionView: UICollectionView = {
        let layout: CycleImageViewCellFlowLayout = CycleImageViewCellFlowLayout()
        let cv = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(CycleImageViewCell.self, forCellWithReuseIdentifier: self.cellId)
        return cv
    }()
    
    // 指示器
    lazy var pageControl : UIPageControl = {
        let width  : CGFloat = 120
        let height : CGFloat = 20
        let pointX : CGFloat = (UIScreen.main.bounds.size.width - width) * 0.5
        let pointY : CGFloat = bounds.size.height - height
        let pc = UIPageControl(frame: CGRect(x: pointX, y: pointY, width: width, height: height))
        pc.isUserInteractionEnabled = false
        pc.pageIndicatorTintColor = UIColor.lightText
        pc.currentPageIndicatorTintColor = UIColor.white
        return pc
    }()
    
    // 定时器
    lazy var timer: Timer = {
        let timer = Timer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(timer, forMode: .commonModes)
        return timer
    }()
}

//MARK: 轮播逻辑处理
extension CycleImageView {
    //MARK: 更新定时器 获取当前位置,滚动到下一位置
    @objc func updateTimer() -> Void {
        let indexPath = collectionView.indexPathsForVisibleItems.last
        guard indexPath != nil else {
            return
        }
        let nextPath = IndexPath(item: (indexPath?.item)! + 1, section: (indexPath?.section)!)
        collectionView.scrollToItem(at: nextPath, at: .left, animated: true)
    }
    //MARK: 开始拖拽时,停止定时器
    internal func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.fireDate = Date.distantFuture
    }
    //MARK: 结束拖拽时,恢复定时器
    internal func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer.fireDate = Date(timeIntervalSinceNow: 2.0)
    }
    //MARK: 监听手动减速完成(停止滚动)  - 获取当前页码,滚动到下一页,如果当前页码是第一页,继续往下滚动,如果是最后一页回到第一页
    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX : CGFloat = scrollView.contentOffset.x
        let page : NSInteger = NSInteger(offsetX / bounds.size.width)
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        if page == 0 { //第一页
            collectionView.contentOffset = CGPoint(
                x: offsetX + CGFloat((self.imageUrlStringArray?.count)!) * CGFloat(self.count) * bounds.size.width, y: 0
            )
        } else if page == itemsCount - 1 { //最后一页
            collectionView.contentOffset = CGPoint(
                x: offsetX - CGFloat((self.imageUrlStringArray?.count)!) * CGFloat(self.count) * bounds.size.width, y: 0
            )
        }
    }
    //MARK: 滚动动画结束的时候调用 - 获取当前页码,滚动到下一页,如果当前页码是第一页,继续往下滚动,如果是最后一页回到第一页
    internal func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(collectionView)
    }
    //MARK: 正在滚动(设置分页) -- 算出滚动位置,更新指示器
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        var page = NSInteger(offsetX / bounds.size.width + 0.5)
        page = page % (self.imageUrlStringArray?.count)!
        pageControl.currentPage = page
    }
    //MARK: 随父控件的消失取消定时器
    internal override func removeFromSuperview() {
        super.removeFromSuperview()
        timer.invalidate()
    }
}

extension CycleImageView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedAt(indexPath.item % (self.imageUrlStringArray?.count)!)
    }
}

extension CycleImageView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.imageUrlStringArray?.count)! * 2 * self.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CycleImageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! CycleImageViewCell
        cell.mode = mode
        cell.imageURLString = self.imageUrlStringArray?[indexPath.item % (self.imageUrlStringArray?.count)!] ?? ""
        return cell
    }
}


