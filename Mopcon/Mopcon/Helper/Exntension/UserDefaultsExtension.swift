//
//  UserDefaults.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/19.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let saveSchedules = "SavedSchedules"
}


class MySchedules {
    
    // Add new schedule
    class func add(agenda:Schedule.Payload.Agenda.Item.AgendaContent) {
        
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(agenda) {
            if var savedSchedules = defaults.array(forKey: UserDefaultsKeys.saveSchedules) as? [Data] {
                // Check this schedule is repeated or not.
                for saveedSchedule in savedSchedules {
                    if saveedSchedule == encoded {
                        print("重複資料")
                        return
                    }
                }
                print("增加一筆行程")
                savedSchedules.append(encoded)
                defaults.set(savedSchedules, forKey: UserDefaultsKeys.saveSchedules)
            } else {
                // If doesn't have any schedule.
                print("創建一我的行程表")
                defaults.set([encoded], forKey: UserDefaultsKeys.saveSchedules)
            }
        }
    }
    
    // Remove schedule
    class func remove(agenda:Schedule.Payload.Agenda.Item.AgendaContent) {
        
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(agenda) {
            if var savedSchedules = defaults.array(forKey: UserDefaultsKeys.saveSchedules) as? [Data] {
                // Check this schedule is repeated or not.
                for i in 0..<savedSchedules.count {
                    if savedSchedules[i] == encoded {
                        print("刪除一筆行程")
                        savedSchedules.remove(at: i)
                        defaults.set(savedSchedules, forKey: UserDefaultsKeys.saveSchedules)
                        return
                    }
                }
            }
        }
        
    }
    
    // get mySchedule
    class func get() -> [Schedule.Payload.Agenda.Item.AgendaContent] {
        
        let defaults = UserDefaults.standard
        if let savedSchedules = defaults.array(forKey: UserDefaultsKeys.saveSchedules) as? [Data] {
            let decoder = JSONDecoder()
            
            var schedules = [Schedule.Payload.Agenda.Item.AgendaContent]()
            for schedule in savedSchedules {
                if let decode = try? decoder.decode(Schedule.Payload.Agenda.Item.AgendaContent.self, from: schedule) {
                    schedules.append(decode)
                }
            }
            return schedules
        } else {
            // Can't get userdefault return empty array.
            return []
        }
    }
    
}
