//
//  EditAlarmTableViewController.swift
//  AlarmRise
//
//  Created by Tiffany Cai on 5/18/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import UIKit

class EditAlarmTableViewController: UITableViewController {
    
    
    @IBOutlet var editAlarmTableView: UITableView!
    
    @IBOutlet weak var datePickerAlarmTime: UIDatePicker!
    @IBOutlet weak var txtFieldAlarmName: UITextField!
    @IBOutlet weak var switchSnooze: UISwitch!
    @IBOutlet weak var labelSnoozeTime: UILabel!
    @IBOutlet weak var stepperSnoozeTime: UIStepper!
    @IBOutlet weak var buttonSave: UIBarButtonItem!
    @IBOutlet weak var buttonCancel: UIBarButtonItem!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func buttonSavePressed(_ sender: Any) {
        
        let newAlarm = AlarmEntity(context: DB.context)
        
        newAlarm.alarmEnabled = true
        newAlarm.alarmName = txtFieldAlarmName.text
        newAlarm.alarmTime = datePickerAlarmTime.date
        
        
        //newItem.snoozeEnabled =
        //newItem.snoozeTime = stepperSnoozeTime.
        
        DB.saveData()
        
        //tableAlarms.reloadData()

        /*
        AlarmListTableViewController().scheduleNotification(alarmName: txtFieldAlarmName.text, alarmTime: datePickerAlarmTime.date)*/
               
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func buttonCancelPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func stepperSnoozePressed(_ sender: UIStepper) {
        let newValue = sender.value
        self.labelSnoozeTime.text = "\(Int(newValue)) minutes"
        
    }

}
