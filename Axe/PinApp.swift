//
//  PinApp.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import Foundation
import Alliances
import AppKit

public class PinApp: AlliancesApp {
    
    public static let bundleID: String = UUID().uuidString
    public var core: AlliancesUICore = .init()
    public var configuration: AlliancesConfiguration
    
    public var name: String = "PinApp"
    public var remark: String? { "remark" }
    public var tasks: [AlliancesApp] = []

    required public init(_ configuration: AlliancesConfiguration) {
        self.configuration = configuration
    }
        
    public func openSettings() {
        name = "vnc://192.168.205.134"
        reload()
    }
    
    public func run() throws {
        NSWorkspace.shared.open(URL(string: "vnc://192.168.205.134")!)
    }
        
}
