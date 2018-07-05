//
//  ConferenceTableViewCell.swift
//  Mopcon
//
//  Created by EthanLin on 2018/7/5.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

protocol WhichCellButtonDidTapped {
    func whichCellButtonDidTapped(index:IndexPath)
}

class ConferenceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var speakerLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addToMyScheduleButton: UIButton!
    
    var delegate: WhichCellButtonDidTapped?
    var index:IndexPath?
    
    @IBAction func addToMySchedule(_ sender: UIButton) {
        guard let index = index else {return}
        delegate?.whichCellButtonDidTapped(index: index) 
    }
    
    func updateUI(model:AgendaModel){
        self.categoryLabel.text = model.category
        self.topicLabel.text = model.title
        self.speakerLabel.text = model.speaker
        self.locationLabel.text = model.location
        if model.addedToMySchedule{
            addToMyScheduleButton.setImage(UIImage(named: "buttonStarChecked"), for: .normal)
        }else{
            addToMyScheduleButton.setImage(UIImage(named: "buttonStarNormal"), for: .normal)
        }
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

}
