//
//  AlliancesManager.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import Foundation
import Alliances

class AlliancesManager {
    
    static let shared = AlliancesManager()
    
    private init() {}
    
}

extension AlliancesManager {
    
    var allApps: [AlliancesApp.Type] {
        []
    }

    var myApps: [UserApp] {
        return [UserApp(id: .init(), createTime: .init(), type: PinApp.self)]
    }
    
}

extension AlliancesManager {
    
    func install(_ app: AlliancesApp) {
        
    }
    
    func uninstall(_ app: AlliancesApp) {
        
    }
    
    func hidden(_ app: AlliancesApp) {
        
    }
    
}
