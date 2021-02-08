//
//  AlarmRingingViewController.swift
//  RiseAlarm
//
//  Created by Tiffany Cai on 5/17/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import UIKit

class RingingAlarmViewController: UIViewController {

    @IBOutlet weak var labelAlarmName: UILabel!
    @IBOutlet weak var buttonSnooze: UIButton!
    @IBOutlet weak var buttonStop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    @IBAction func buttonSnoozeTapped(_ sender: Any) {
        
        bounce(buttonSnooze)
    }
    
    @IBAction func buttonStopTapped(_ sender: Any) {
        
        bounce(buttonStop)
        
    }
    
    // MARK: animations
    
    func bounce(_ sender: UIButton) {
        let theButton = sender
        let bounds = theButton.bounds
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .curveEaseIn, animations: {
            theButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 30, height: bounds.size.height)
        }) { (success:Bool) in
            if success {
                UIView.animate(withDuration: 0.5, animations: {
                    theButton.bounds = bounds
                    
                })
            }
        }
    }
    
    
}
