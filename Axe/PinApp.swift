//
//  PinApp.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import Foundation
import Alliances
import AppKit

public struct PinApp: AlliancesApp {
    
    public static let bundleID: String = UUID().uuidString
    public var core: AlliancesUICore = .init()
    public var configuration: AlliancesConfiguration
    
    public let name: String = "PinApp"
    public var remark: String? { "remark" }
    public var tasks: [AlliancesApp] = []

    public init(_ configuration: AlliancesConfiguration) {
        self.configuration = configuration
    }
        
    public func openSettings() {
       
    }
    
    public func run() throws {
        NSWorkspace.shared.open(URL(string: "vnc://192.168.205.134")!)
    }
        
}
