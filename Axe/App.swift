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
            EmptyView()
        }.windowStyle(HiddenTitleBarWindowStyle())
    }
    
    private static var settingsWindow: NSWindow?
    private static var windows = [NSWindow]()
    
    static func openInWindow(title: String, sender: AnyView?, level: NSWindow.Level = .normal) {
        self.windows.append(AppWindow.show(title: title, sender: sender, level: level))
    }
    
    static func openSettingsWindow(_ app: UserApp) {
        self.settingsWindow?.close()
        self.settingsWindow = AppWindow.show(title: "settings", sender: app.app.settingsView, level: .normal)
    }
    
}
