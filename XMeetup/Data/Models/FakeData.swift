//
//  FakeData.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import Fakery
import CoreLocation

private let faker = Faker(locale: "ru-RU")

extension Event {
    
    static var fake: Event {
        let event = Event()
        event.id = UUID().uuidString
        event.startDate = Date().addingTimeInterval(faker.number.randomDouble(min: -100000, max: 100000))
        event.endDate = event.startDate.addingTimeInterval(faker.number.randomDouble(min: event.startDate.timeIntervalSinceNow, max: 100000))
        event.location = CLLocationCoordinate2D(latitude: faker.number.randomDouble(min: 0, max: 90),
                                                longitude: faker.number.randomDouble(min: 0, max: 90))
        
        event.title = faker.lorem.sentence(wordsAmount: 3)
        event.descr = faker.lorem.sentences(amount: 2)
        event.distance = faker.number.randomDouble(min: 0, max: 20000)
        return event
    }
    
}
