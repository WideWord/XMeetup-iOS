//
//  Feed.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 30.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import RxSwift
import RxCocoa

protocol Feed {
    
    associatedtype Entity: DataEntity
    
    var data: [Entity] { get }
    
    func asDriver() -> Driver<[Entity]>
    
    func needNextPage()
    func reloadData() -> Observable<Void>
    
}
