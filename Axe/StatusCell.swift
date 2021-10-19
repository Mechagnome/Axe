//
//  StatusCell.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import SwiftUI
import Alliances

struct StatusCell: View {
    
    let model: UserApp
    
    private var app: AlliancesApp { model.app }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(app.name)
                    if let value = app.remark {
                        Text(value)
                    }
                }
                Button("Run") {
                    try? app.run()
                }
                Button("Settings") {
                    app.openSettings()
                }
            }
            
            if app.progress > 0 {
                ProgressView(value: app.progress)
            }
        }
    }
    
}

struct StatusCell_Previews: PreviewProvider {
    
    public struct TestApp: AlliancesApp {
        
        public static let bundleID: String = UUID().uuidString
        public var core: AlliancesUICore = .init()
        public var configuration: AlliancesConfiguration
        
        public var name: String { Self.bundleID }
        public var remark: String? { "remark" }
        public var tasks: [AlliancesApp] = []
        
        public init(_ configuration: AlliancesConfiguration) {
            self.configuration = configuration
        }
        
        public func openSettings() {
            progress -= 0.05
        }
        
        public func run() throws {
            progress += 0.05
        }
    }
    
    static var previews: some View {
        StatusCell(model: UserApp.init(id: .init(), type: TestApp.self))
    }
}
