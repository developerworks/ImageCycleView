//
//  ViewController.swift
//  CycleView
//
//  Created by hezhiqiang on 2018/4/9.
//  Copyright © 2018年 Totorotec. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 导航栏高度
    let KNavBarHeight : CGFloat = 44.0
    // 专挑栏高度
    let KStatusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
    // 屏幕高度
    let KUIScreenHeight : CGFloat = UIScreen.main.bounds.size.height
    // 屏幕宽度
    let KUIScreenWidth : CGFloat = UIScreen.main.bounds.size.width
    // 导航栏+状态栏高度和
    let KNavStausHeight : CGFloat = 44.0 + UIApplication.shared.statusBarFrame.size.height
    
    let cellId = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        var tabBarHeight : CGFloat = 49
        
        self.view.backgroundColor = UIColor.white
        
        // 判断iPhone X的Tabbar高度
//        if isIphoneX {
//            tabBarHeight = 83
//        } else {
//            tabBarHeight = 49
//        }
//        tabBarHeight = 49
        
//        let frame : CGRect = CGRect(
//            x: 0,
//            y: KNavStausHeight,
//            width: KUIScreenWidth,
//            height: KUIScreenHeight - KNavStausHeight - tabBarHeight
//        )
//        print("UITableView Size: \(frame)")
//        let tv : UITableView = {
//            let tv = UITableView(frame: frame, style: .grouped)
//            tv.showsVerticalScrollIndicator = false
//            tv.showsHorizontalScrollIndicator = false
//            tv.separatorStyle = .singleLine
//            tv.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.02))
//            tv.tableFooterView?.isHidden = true
//
//            tv.delegate = self
//            tv.dataSource = self
//
//            tv.rowHeight = UITableViewAutomaticDimension
//            tv.estimatedRowHeight = 200
//
//            tv.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
//
//            if #available(iOS 11.0, *) {
//                tv.contentInsetAdjustmentBehavior = .never
//            } else {
//                self.automaticallyAdjustsScrollViewInsets = false
//            }
//            // 轮播图加载
//            let pointY = 44 + UIApplication.shared.statusBarFrame.size.height
//
//            print("pointY: \(pointY)")
//            let cycleView : CycleImageView = CycleImageView(
//                frame: CGRect(x: 0, y: pointY, width: UIScreen.main.bounds.size.width, height: 220)
//            )
//            cycleView.delegate = self
//            cycleView.mode = .scaleAspectFill
//            // 本地图片测试
//            // 加载网络图片,请用第三方库如SDWebImage等
//            cycleView.imageUrlStringArray = [
//                "banner01.jpg",
//                "banner02.jpg",
//                "banner03.jpg",
//                "banner04.jpg"
//            ]
//            tv.tableHeaderView = cycleView
//            return tv
//        }()
        
//        let pointY = 44 + UIApplication.shared.statusBarFrame.size.height
//
//        // CycleView 大小
//        let cycleViewFrame: CGRect = CGRect(x: 0, y: pointY, width: UIScreen.main.bounds.size.width, height: 220)
//        // 初始化 CycleImageView
//        let cycleView : CycleImageView = CycleImageView(
//            frame: cycleViewFrame
//        )
//        cycleView.delegate = self
//        cycleView.mode = .scaleAspectFill
//        // 本地图片测试
//        // 加载网络图片,请用第三方库如SDWebImage等
//        cycleView.imageUrlStringArray = [
//            "banner01.jpg",
//            "banner02.jpg",
//            "banner03.jpg",
//            "banner04.jpg"
//        ]
//        self.view.addSubview(cycleView)
//        self.view.addSubview(tv)
        self.createCycleImageView()
    }
    
    private func createCycleImageView() {
        // 状态栏+导航栏高度和
        let pointY = 44 + UIApplication.shared.statusBarFrame.size.height
        // 轮播组件高度
        let frameHeight = (576/1180) * UIScreen.main.bounds.size.width
        // 轮播组件Frame
        let cycleViewFrame: CGRect = CGRect(
            x: 0,
            y: pointY,
            width: UIScreen.main.bounds.size.width,
            height: frameHeight
        )
        // 实例化
        let cycleView: CycleImageView = CycleImageView(frame: cycleViewFrame)
        // 事件委派
        cycleView.delegate = self
        // 内容模式
        cycleView.contentMode = .scaleAspectFit
        // 背景色
        cycleView.backgroundColor = UIColor.gray
        // 图片地址
        cycleView.imageUrlStringArray = [
            "banner01.jpg",
            "banner02.jpg",
            "banner03.jpg",
            "banner04.jpg"
        ]
        // 添加
        self.view.addSubview(cycleView)
    }
    
    @objc private func click() {
        self.navigationController?.pushViewController(SaasController(), animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: CycleImageViewDelegate {
    func didSelectedAt(_ index: Int) {
        print("点击了轮播图第\(index)个图片")
        let demoVc = DemoController()
        demoVc.title = "点击了轮播图第\(index)个图片"
        demoVc.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(demoVc, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        navigationController?.pushViewController(SaasController(), animated: true)
//    }
}
extension ViewController: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SaasController(), animated: true)
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    //数据源方法
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 1;
//        } else {
//            return 5
//        }
        return 0
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell index path: \(indexPath)")
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(indexPath.section) + \(indexPath.row)"
        cell.selectionStyle = .gray
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 6
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        cell.textLabel?.text = "\(indexPath.section) + \(indexPath.row)"
//        cell.selectionStyle = .gray
//        cell.accessoryType = .disclosureIndicator
//        return cell
//    }
//}

