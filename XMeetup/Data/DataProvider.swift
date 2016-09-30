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
    
    let eventFeed = FakeEventFeed()
    
}

class FakeEventFeed: Feed {
    
    typealias Entity = Event
    
    private(set) var data = [Event]()
    
    private let dataUpdated = PublishSubject<Void>()
    
    func asDriver() -> Driver<[Event]> {
        return dataUpdated
            .asDriver(onErrorJustReturn: ())
            .map { [weak self] in self?.data ?? [] }
    }
    
    private var nextPageLoading = false
    
    func needNextPage() {
        guard !nextPageLoading else { return }
        nextPageLoading = true
        
        DispatchQueue.global(qos: .background).async {
            let dataToAppend = (0..<50).map { _ in Event.fake }
            DispatchQueue.main.async {
                self.data.append(contentsOf: dataToAppend)
                self.dataUpdated.onNext()
                self.nextPageLoading = false
            }
        }
    }
    
    func reloadData() -> Observable<Void> {
        return Observable.create { observer in
            
            DispatchQueue.global(qos: .background).async {
                let newData = (0..<50).map { _ in Event.fake }
                DispatchQueue.main.async {
                    self.data = newData
                    self.dataUpdated.onNext()
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
}
