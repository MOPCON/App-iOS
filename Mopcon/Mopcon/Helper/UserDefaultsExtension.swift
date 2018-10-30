//
//  UserDefaults.swift
//  Mopcon
//
//  Created by JeremyXue on 2018/8/19.
//  Copyright © 2018年 EthanLin. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let dayOneSchedule = "2018-11-03"
    static let dayTwoSchedule = "2018-11-04"
    static let fcmToken = "fcmToken"
    static let UUID = "UUID"
}

class CurrentLanguage {
    class func getLanguage() -> String {
        if let language = UserDefaults.standard.string(forKey: "language") {
            return language
        } else {
            return "Chinese"
        }
    }
}

class MySchedules {
    
    // Add new schedule
    class func add(agenda:Schedule.Payload.Agenda.Item.AgendaContent,forKey key: String) {
        
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(agenda) {
            if var savedSchedules = defaults.array(forKey: key) as? [Data] {
                // Check this schedule is repeated or not.
                for saveedSchedule in savedSchedules {
                    if saveedSchedule == encoded {
                        print("重複資料")
                        return
                    }
                }
                print("增加一筆行程")
                savedSchedules.append(encoded)
                defaults.set(savedSchedules, forKey: key)
            } else {
                // If doesn't have any schedule.
                print("創建一我的行程表")
                defaults.set([encoded], forKey: key)
            }
        }
    }
    
    // Remove schedule
    class func remove(agenda:Schedule.Payload.Agenda.Item.AgendaContent,forKey key: String) {
        
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(agenda) {
            if var savedSchedules = defaults.array(forKey: key) as? [Data] {
                // Check this schedule is repeated or not.
                for i in 0..<savedSchedules.count {
                    if savedSchedules[i] == encoded {
                        print("刪除一筆行程")
                        savedSchedules.remove(at: i)
                        defaults.set(savedSchedules, forKey: key)
                        return
                    }
                }
            }
        }
        
    }
    
    // get mySchedule
    class func get(forKey key:String) -> [Schedule.Payload.Agenda.Item.AgendaContent] {
        
        let defaults = UserDefaults.standard
        if let savedSchedules = defaults.array(forKey: key) as? [Data] {
            let decoder = JSONDecoder()
            
            var schedules = [Schedule.Payload.Agenda.Item.AgendaContent]()
            for schedule in savedSchedules {
                if let decode = try? decoder.decode(Schedule.Payload.Agenda.Item.AgendaContent.self, from: schedule) {
                    schedules.append(decode)
                }
            }
            return schedules
        } else {
            // Can't get userdefault, Return empty array.
            return []
        }
    }
    
    class func checkRepeat(scheduleID: String?) -> Bool {
        
        for agenda in MySchedules.get(forKey: UserDefaultsKeys.dayOneSchedule) {
            if scheduleID == agenda.schedule_id {
                return true
            }
        }
        
        for agenda in MySchedules.get(forKey: UserDefaultsKeys.dayTwoSchedule) {
            if scheduleID == agenda.schedule_id {
                return true
            }
        }
        
        return false
    }
    
}
