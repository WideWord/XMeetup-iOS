//
//  DataProvider.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DataProvider {
    
    private init() {}
    
    static let instance = DataProvider()
    
    let eventFeed = Feed<Event>()
    
}

class Feed<E: DataEntity> {
    
    private(set) var data = [E]()
    
    private let dataChanged = PublishSubject<Void>()
    
    func asDriver() -> Driver<[E]> {
        return dataChanged
            .asDriver(onErrorJustReturn: ())
            .map { [weak self] in self?.data ?? [] }
    }
    
    
    private var pageToken: String?
    
    private var requestNextPageInProgress = false
    
    func requestNextPage() {
        guard !requestNextPageInProgress else { return }
        requestNextPageInProgress = true
        
        DispatchQueue.global(qos: .background).async {
            let newData = (0..<50).map { _ in Event.fake as! E }
            DispatchQueue.main.async {
                self.data.append(contentsOf: newData)
                self.dataChanged.onNext()
                self.requestNextPageInProgress = false
            }
        }
        
    }
    
    func resetPagination() {
        data = []
        requestNextPage()
    }
    
}
