//
//  AlarmListTableViewCell.swift
//  AlarmRise
//
//  Created by Tiffany Cai on 5/18/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import UIKit

class AlarmListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelAlarmTime: UILabel!
    @IBOutlet weak var labelAlarmName: UILabel!
    @IBOutlet weak var switchAlarmEnabled: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

