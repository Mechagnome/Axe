//
//  AlliancesManager.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import Foundation
import Alliances
import ModularizationHelper
import Stem
import Combine

class AlliancesManager {
    
    static let shared = AlliancesManager()
    
    let myAppsDidChanged: CurrentValueSubject<[UserApp], Never>
    
    var myApps: [UserApp] { myAppsDidChanged.value }
    
    private init() {
        let myApps = UserDefaults.standard.array(forKey: "userApps")?
            .compactMap({ $0 as? Data })
            .compactMap({ try? JSON(data: $0) })
            .compactMap({ try? UserApp(from: $0) { bundleID in
                Self.allApps.first(where: { $0.appInfo.id == bundleID })
            }}) ?? []
        
        myAppsDidChanged = .init(myApps)
    }
    
}

extension AlliancesManager {
    
    static var allApps: [AlliancesApp.Type] {
        [
            ModularizationHelper.self,
            TestApp.self
        ]
    }
    
}

extension AlliancesManager {
    
    func install(_ type: AlliancesApp.Type) throws {
        let app = UserApp(id: .init(), createTime: .init(), type: type)
        var apps = myApps
        apps.append(app)
        UserDefaults.standard.set(apps.map(\.toJSON).compactMap({ try? $0.rawData() }), forKey: "userApps")
        myAppsDidChanged.send(apps)
    }
    
    func uninstall(_ app: UserApp) {
        var apps = myApps.filter({ $0 != app })
        UserDefaults.standard.set(apps.map(\.toJSON).compactMap({ try? $0.rawData() }), forKey: "userApps")
        myAppsDidChanged.send(apps)
    }
    
}
