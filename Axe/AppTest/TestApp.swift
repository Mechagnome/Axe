//
//  TestApp.swift
//  Axe
//
//  Created by linhey on 2021/10/21.
//

import Foundation
import Alliances
import SwiftUI

public struct TestApp: AlliancesApp {
    
    static var useApp: UserApp { UserApp(id: .init(), type: TestApp.self) }
    
    public static var appInfo: AppInfo = .init(id: "TestApp", name: "TestApp", icon: nil, summary: "summary")
    
    public static let bundleID: String = UUID().uuidString
    public var core: AlliancesUICore = .init()
    public var configuration: AlliancesConfiguration
    
    public var name: String { Self.bundleID }
    public var remark: String? { "remark" }
    public var tasks: [AlliancesApp] = []
    
    public init(_ configuration: AlliancesConfiguration) {
        self.configuration = configuration
        self.tasks = [ChildApp(.init(from: configuration, app: ChildApp.self)),
                      ChildApp(.init(from: configuration, app: ChildApp.self))]
    }
    
    public var settingsView: AnyView? {
        .init(VStack {
            Text("1111")
            Text("1111")
            Text("1111")
            Text("1111")
            Text("1111")
        }.frame(width: 300, height: 300))
    }
    
    public func run() throws {
        progress += 0.05
        show(view: AnyView(Text("66666666").frame(width: 300, height: 300)))
    }
    
}

extension TestApp {
    
    public struct ChildApp: AlliancesApp {
        
        public static var appInfo: AppInfo = .init(id: "ChildApp", name: "ChildApp")
        
        public static let bundleID: String = UUID().uuidString
        public var core: AlliancesUICore = .init()
        public var configuration: AlliancesConfiguration
        
        public var name: String { Self.bundleID }
        public var remark: String? { "remark" }
        public var tasks: [AlliancesApp] = []
        
        public init(_ configuration: AlliancesConfiguration) {
            self.configuration = configuration
        }
        
        public func run() throws {
            progress += 0.05
            show(view: AnyView(Text("66666666")))
        }
    }
    
}
