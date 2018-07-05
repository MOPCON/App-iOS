//
//  AddToMySchedule.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import Foundation

class AgendaModel{
    
    var category:String
    var title:String
    var speaker:String
    var location:String
    var addedToMySchedule:Bool
    init(category:String,title: String,speaker:String, location:String, addedToMySchedule:Bool) {
        self.category = category
        self.title = title
        self.speaker = speaker
        self.location = location
        self.addedToMySchedule = addedToMySchedule
    }
}
