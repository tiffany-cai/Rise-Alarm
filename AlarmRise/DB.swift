//
//  DB.swift
//  RiseAlarm
//
//  Created by Tiffany Cai on 5/17/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import UIKit
import CoreData

class DB {
    
     static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
     static func saveData(){
        do {
            try context.save()
            print("Data Save!")
        }
        catch {
            print("Error saving Context \(error)")
        }
    }

    //MARK: quote entity
    static func getQuotes()->[QuoteEntity]? {

        let request: NSFetchRequest<QuoteEntity> = QuoteEntity.fetchRequest()

        var temp:[QuoteEntity]!
        do {
           temp = try context.fetch(request)
        }catch {
            print("Error getting quotes \(error)")
        }

        return temp
    }

    static func deleteQuote(quote: QuoteEntity) {
        context.delete(quote)
        saveData()
    }
    
    //MARK:alarm entity
    static func getAlarms()->[AlarmEntity]? {
        
        let request: NSFetchRequest<AlarmEntity> = AlarmEntity.fetchRequest()
        var temp:[AlarmEntity]!
        do {
            temp = try context.fetch(request)
        } catch {
            print("Error getting alarms \(error)")
        }
        return temp
    }
    
    static func deleteAlarm(alarm: AlarmEntity) {
        context.delete(alarm)
        saveData()
    }
}
 
