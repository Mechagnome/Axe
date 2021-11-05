//
//  App.swift
//  Axe
//
//  Created by linhey on 2021/10/18.
//

import SwiftUI

@main
struct App: SwiftUI.App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                EmptyView().hidden()
            }
        }
        .windowStyle(HiddenTitleBarWindowStyle())
    }
    
}

extension App {
    
    class Windows {
        
        enum Style {
            case settings(app: UserApp)
            case appSotre(view: AnyView)
            case myApps(view: AnyView)
            case others(ID: String, title: String, view: AnyView)
        }
        
        var settings: NSWindow?
        var appSotre: NSWindow?
        var myApps: NSWindow?
        var others: [String: NSWindow] = [:]
        
    }
    
    private static let windows = Windows()
    
    static func openWindow(for style: Windows.Style) {
        switch style {
        case .settings(let app):
            self.windows.settings?.close()
            self.windows.settings = AppWindow.show(title: "\(app.app.name) Settings", sender: app.app.settingsView, level: .normal)
        case .appSotre(let view):
            self.windows.appSotre?.close()
            self.windows.appSotre = AppWindow.show(title: "App Store", sender: view, level: .normal)
        case .myApps(let view):
            self.windows.myApps?.close()
            self.windows.myApps = AppWindow.show(title: "My Apps", sender: view, level: .normal)
        case .others(ID: let ID, title: let title, view: let view):
            self.windows.others[ID]?.close()
            self.windows.others[ID] = AppWindow.show(title: title, sender: view, level: .normal)
        }
    }
    
}
