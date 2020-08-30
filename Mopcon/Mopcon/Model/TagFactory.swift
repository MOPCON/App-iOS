//
//  TagFactory.swift
//  Mopcon
//
//  Created by WU CHIH WEI on 2019/10/7.
//  Copyright © 2019 EthanLin. All rights reserved.
//

import Foundation

class TagFactory {
    
    static func unrecordableTag() -> Tag {
        
        return Tag(color: "#ff4492", name: "禁止錄影")
    }
    
    static func partnerTag() -> Tag {
        
        return Tag(color: "#98ce02", name: "夥伴議程")
    }
    
    static func levelTag(level: String) -> Tag {
        
        return Tag(color: "#01aaf0", name: level)
    }
    
    static func keynoteTag() -> Tag {
        
        return Tag(color: "#ff4492", name: "Keynote")
    }
    
    static func generalTag(with name: String) -> Tag {
        
        return Tag(color: "#651fff", name: name)
    }
}
