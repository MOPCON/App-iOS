//
//  MyScheduleConferenceTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/15.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class MyScheduleConferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var floorLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func deleteSchedule(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    func update(mySchedule:Schedule.Payload.Agenda.Item.AgendaContent) {
        self.typeLabel.text = mySchedule.type
        self.titleLabel.text = mySchedule.schedule_topic
        self.speakerLabel.text = mySchedule.name
        
        self.floorLabel.text = mySchedule.location
    }
}
