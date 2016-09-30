//
//  Cache.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import Foundation

class DataCache {
    
    private var caches = [String: AnyObject]()
    
    private func cache<E: DataEntity>(forType: E.Type) -> SpecializedDataCache<E> {
        let typeName = NSStringFromClass(E.self)
        let cache: SpecializedDataCache<E>
        if let existsCache = caches[typeName] as? SpecializedDataCache<E> {
            cache = existsCache
        } else {
            cache = SpecializedDataCache<E>()
            caches[typeName] = cache
        }
        return cache
    }
    
    func get<E: DataEntity>(type: E.Type, id: String) -> E? {
        return cache(forType: E.self).get(id: id)
    }
    
    func add<E: DataEntity>(_ object: E) {
        cache(forType: E.self).add(object)
    }
    
    func clear() {
        for (_, cache) in caches {
            (cache as? AnySpecializedDataCache)?.clear()
        }
    }
    
}

private protocol AnySpecializedDataCache {
    
    func clear()
    
}

private class SpecializedDataCache<E: DataEntity>: AnySpecializedDataCache {
    
    private var cache = [String: E]()
    
    func get(id: String) -> E? {
        return cache[id]
    }
    
    func add(_ object: E) {
        cache[object.id] = object
    }
    
    func clear() {
        cache.removeAll()
    }
    
}
