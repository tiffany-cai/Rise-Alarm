//
//  AlarmListTableViewController.swift
//  AlarmRise
//
//  Created by Tiffany Cai on 5/18/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import AVFoundation

import UserNotifications
import UIKit

class AlarmListTableViewController: UITableViewController {
    
    @IBOutlet weak var tableAlarms: UITableView!
    @IBOutlet weak var buttonAddAlarm: UIBarButtonItem!

    var alarmArray = [AlarmEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        notification()

        tableAlarms.delegate = self
        tableAlarms.dataSource = self
        
        let temp = DB.getAlarms()
        if temp != nil {
            alarmArray = temp!
        }
    }
    
    //this is loading the view again each time
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let temp = DB.getAlarms() 
        if temp != nil {
            alarmArray = temp!
            
        }
        
        tableAlarms.reloadData()
        waterfall()
    }
       
    
    //MARK: notifications
    
    func notification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
            if success{
                print("User granted notifs!")
            }
            else if error != nil{
                print("error, user did not grant notif")
            }
        })
    }
    
    func scheduleNotification(alarmName: String, alarmTime: Date) {
        
        let content = UNMutableNotificationContent()
        
        content.title = alarmName
        content.body = "Your alarm is ringing!"
        content.sound = UNNotificationSound.init(named:UNNotificationSoundName(rawValue: "alarm_perfect.wav"))

            
        let schedule = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: alarmTime), repeats: false)
        
        let request = UNNotificationRequest(identifier: "notif \(String(describing: alarmTime))", content: content, trigger: schedule)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil{
                print("error")
            }
        })
    }
    
    
    
    // MARK:animations
    
    //animates table cells
    func waterfall() {
        
        tableAlarms.reloadData()
        let cells = tableAlarms.visibleCells
        let tableViewHeight = tableAlarms.bounds.size.height
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var delayCounter = 0
        for cell in cells {
            UIView.animate(withDuration: 1.75, delay:Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }

    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! AlarmListTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        cell.labelAlarmTime.text = dateFormatter.string(from: alarmArray[indexPath.row].alarmTime!)
        cell.labelAlarmName.text = alarmArray[indexPath.row].alarmName
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            DB.context.delete(alarmArray[indexPath.row])
            alarmArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


}
