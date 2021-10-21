//
//  AlliancesConfiguration+EX.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import Foundation
import Alliances
import Stem

extension AlliancesConfiguration {
    
    public convenience init(sanbox: UUID, app: AlliancesApp.Type) {
        self.init(folder: try! FilePath.Folder(sanbox: .library)
                    .create(folder: [app.appInfo.id, sanbox.uuidString].joined(separator: "_")))
    }
    
}
