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
        
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(createEvent))
        
        tableView.register(UINib(nibName: "FeedEventCell", bundle: nil), forCellReuseIdentifier: "event")
        
        tableView.tableFooterView = UIView()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.dataSource = nil
    
        let feed = self.feed
        
        feed.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "event", cellType: FeedEventCell.self))
            { $2.event = $1 }
            .addDisposableTo(disposeBag)
        
        let latestDisplayedRow = tableView.rx.willDisplayCell
            .map { _, row in row.row }
        
        let feedLength = feed.asDriver()
            .map { $0.count }
        
        Observable.combineLatest(latestDisplayedRow, feedLength.asObservable(), resultSelector: { $0 + Constants.feedLoadingInset > $1 })
            .filter { $0 }
            .asVoid()
            .subscribe(onNext: feed.needNextPage)
            .addDisposableTo(disposeBag)
        
        refreshControl = UIRefreshControl()
        refreshControl?.rx.controlEvent(.valueChanged)
            .flatMap { feed.reloadData().materializeDisposed() }
            .bindNext(self.refreshControl!.endRefreshing)
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _ = feed.reloadData().subscribe()
    }
    
    @objc private func createEvent() {
        
    }
    
}
