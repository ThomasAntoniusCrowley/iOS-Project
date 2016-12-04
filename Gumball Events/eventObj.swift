//
//  eventObj.swift
//  Gumball Events
//
//  Created by Thomas Crowley [sc14talc] on 04/12/2016.
//  Copyright © 2016 Thomas Crowley [sc14talc]. All rights reserved.
//

import Foundation

class Event
{
    var id: String = ""
    var url: String = ""
    var title: String = ""
    var description: String = ""
    var start_time: String = ""
    var stop_time: String = ""
    var venue_id: String = ""
    var venue_url: String = ""
    var venue_display: String = ""
    var venue_address: String = ""
    var city_name: String = ""
    var region_name: String = ""
    var region_abbr: String = ""
    var postal_code: String = ""
    var country_name: String = ""
    var all_day: Int = 0
    var latitude: Float = 0
    var longitude: Float = 0
    var geocode_type: String = ""
    var trackback_count: Int = 0
    var calendar_count: Int = 0
    var comment_count: Int = 0
    var link_count: Int = 0
    var created: String = ""
    var owner: String = ""
    var modified: String = ""
    
}
