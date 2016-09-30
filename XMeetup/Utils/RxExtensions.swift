//
//  RxExtensions.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 30.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import RxSwift

extension ObservableType {
    
    func materialize() -> Observable<RxSwift.Event<E>> {
        return Observable.create { observer in
            return self.subscribe { e in
                observer.onNext(e)
                if e.isStopEvent {
                    observer.onCompleted()
                }
            }
        }
    }
    
    func asVoid() -> Observable<Void> {
        return self.map { _ in }
    }
    
    func materializeCompleted() -> Observable<Void> {
        return Observable.create { observer in
            return self.subscribe(onError: { e in
                observer.onError(e)
                }, onCompleted: {
                    observer.onNext()
                    observer.onCompleted()
                })
        }
    }
    
    func materializeDisposed() -> Observable<Void> {
        return Observable.create { observer in
            return self.subscribe(onDisposed: {
                observer.onNext()
                observer.onCompleted()
            })
        }
    }
    
}
