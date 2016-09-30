//
//  FeedViewController.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FeedViewController: UITableViewController {
    
    private enum Constants {
        static let feedLoadingInset: Int = 10
    }
    
    private let disposeBag = DisposeBag()
    
    private let feed = DataProvider.instance.eventFeed
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "События"
        
        tableView.register(UINib(nibName: "FeedEventCell", bundle: nil), forCellReuseIdentifier: "event")
        
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = nil
    
        
        feed.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "event", cellType: FeedEventCell.self))
            { $2.event = $1 }
            .addDisposableTo(disposeBag)
        
        refreshControl = UIRefreshControl()
        refreshControl?.rx.controlEvent(.valueChanged)
            .subscribe(onNext: feed.resetPagination)
            .addDisposableTo(disposeBag)
        
        feed.asDriver()
            .map { _ in }
            .drive(onNext: refreshControl!.endRefreshing)
            .addDisposableTo(disposeBag)
    }
    
  
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.indexPathsForVisibleRows?.last?.row ?? 0 > feed.data.count - Constants.feedLoadingInset {
            feed.requestNextPage()
        }
    }
    
}
