//
//  FeedEventCell.swift
//  XMeetup
//
//  Created by Kirill Vilkov on 29.09.16.
//  Copyright © 2016 Kirill Vilkov. All rights reserved.
//

import UIKit
import FormatterKit
import SwiftMoment


class FeedEventCell: UITableViewCell {

    static let identifier = "FeedEventCell"

    var event: Event? {
        didSet {
            guard let event = event else { return }
            titleLabel.text = event.title
            descrLabel.text = event.descr
            distanceLabel.text = TTTLocationFormatter().string(fromDistance: event.distance)
            
            startTimeLabel.text = "началось " + moment(event.startDate).fromNow().lowercased()
        }
    }
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descrLabel: UILabel!
    @IBOutlet private var distanceLabel: UILabel!
    @IBOutlet private var startTimeLabel: UILabel!
    
}
