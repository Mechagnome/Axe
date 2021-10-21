//
//  UserApp.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import Foundation
import Alliances
import Stem

struct UserApp: Identifiable {
    
    let id: UUID
    let app: AlliancesApp
    
    let createTime: Date
    
    init(createTime: Date = .init(), app: AlliancesApp) {
        self.createTime = createTime
        self.app = app
        self.id = UUID()
    }
    
    init(id: UUID, createTime: Date = .init(), type: AlliancesApp.Type) {
        self.id = id
        self.createTime = createTime
        self.app = type.init(.init(sanbox: id, app: type))
    }
    
    init(from json: JSON, app: (_ bundleID: String) -> AlliancesApp.Type?) throws {
        guard let id = UUID(uuidString: json["id"].stringValue),
              let bundleID = json["app_bundleID"].string,
              let type = app(bundleID) else {
                throw SwiftyJSONError.invalidJSON
            }
        
        self.init(id: id,
                  createTime: Date(timeIntervalSince1970: json["createTime"].doubleValue),
                  type: type)
    }
    
    var toJSON: JSON {
        var dict = [String: Any]()
        dict["id"] = id.uuidString
        dict["createTime"] = createTime.timeIntervalSince1970
        dict["app_bundleID"] = type(of: app).bundleID
        return JSON(dict)
    }
    
}
