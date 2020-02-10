//
//  ViewController.swift
//  SampleRefreshAnimation
//
//  Created by hajime ito on 2020/02/10.
//  Copyright © 2020 hajime_poi. All rights reserved.
//

import UIKit
import SwiftGifOrigin

typealias TableViewDD = UITableViewDelegate & UITableViewDataSource

class ViewController: UIViewController, TableViewDD {
    
    var myHeaderView: UIView!
    var lastContentOffset: CGFloat = 0
    @IBOutlet weak var myTableView: UITableView!
    
    fileprivate let refreshCtl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createHeaderView()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.tableFooterView = UIView()
        myTableView.backgroundColor = UIColor(red: 95/255, green: 158/255, blue: 160/255, alpha: 1)
        myTableView.contentInset.top = 30 //ヘッダーの高さ分下げる
        myTableView.refreshControl = refreshCtl
        refreshCtl.tintColor = .clear // ゲージを透明にする
        refreshCtl.addTarget(self, action: #selector(ViewController.refresh(sender:)), for: .valueChanged)
        
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        self.addHeaderViewGif()
        myTableView.contentInset.top = 130 //ヘッダーの分下げる
        sender.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [],animations: {
                self.myTableView.contentInset.top = 30
            }, completion: nil)
            self.updateHeaderView()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TEST",for: indexPath as IndexPath)
        cell.textLabel?.text = "test~"
        cell.backgroundColor = UIColor(red: 95/255, green: 158/255, blue: 160/255, alpha: 1)
        return cell
    }
    
}

extension ViewController {
    private func createHeaderView() {
        let displayWidth: CGFloat! = self.view.frame.width
        // 上に余裕を持たせている（後々アニメーションなど追加するため）
        myHeaderView = UIView(frame: CGRect(x: 0, y: -230, width: displayWidth, height: 230))
        myHeaderView.alpha = 1
        myHeaderView.backgroundColor = .white
        myTableView.addSubview(myHeaderView)
        let myLabel = UILabel(frame: CGRect(x: 0, y: 200, width: displayWidth, height: 30))
        myLabel.text = "header"
        myLabel.textAlignment = .center
        myLabel.textColor = UIColor(red: 95/255, green: 158/255, blue: 160/255, alpha: 1)
        myLabel.alpha = 1
        myHeaderView.addSubview(myLabel)
        let image = UIImageView(frame: CGRect(x: (displayWidth-100)/2, y: 100, width: 100, height: 100))
        image.image = UIImage(named: "bili")
        myHeaderView.addSubview(image)
    }
    
    private func updateHeaderView() {
        let displayWidth: CGFloat! = self.view.frame.width
        myHeaderView.subviews[1].removeFromSuperview()
        let image = UIImageView(frame: CGRect(x: (displayWidth-100)/2, y: 100, width: 100, height: 100))
        image.image = UIImage(named: "bili")
        myHeaderView.addSubview(image)
    }
    
    func addHeaderViewGif() {
        let displayWidth: CGFloat! = self.view.frame.width
        myHeaderView.subviews[1].removeFromSuperview()
        let image = UIImageView(frame: CGRect(x: (displayWidth-100)/2, y: 100, width: 100, height: 100))
        image.loadGif(name: "bili")
        myHeaderView.addSubview(image)
    }
}

