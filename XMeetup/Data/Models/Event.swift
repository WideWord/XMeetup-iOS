//
//  Event.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import Foundation
import CoreLocation
import ObjectMapper

class Event: DataEntity {
    
    var startDate = Date()
    var endDate: Date?
    var location = CLLocationCoordinate2D()
    var title = ""
    var descr = ""
    var picture: String?
    var distance: Double = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
    }
    
    
    
}
