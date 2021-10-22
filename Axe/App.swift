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
            StoreAppsView()
        }
    }
    
    
    private static var settingsWindow: NSWindow?
    private static var windows = [NSWindow]()
    
    static func openInWindow(title: String, sender: AnyView?, level: NSWindow.Level = .normal) {
        self.windows.append(newWindow(title: title, sender: sender, level: level))
    }
    
    static func openSettingsWindow(_ app: UserApp) {
        self.settingsWindow?.close()
        self.settingsWindow = newWindow(title: "settings", sender: app.app.settingsView, level: .popUpMenu)
    }
    
    static func newWindow(title: String, sender: AnyView?, level: NSWindow.Level = .normal) -> NSWindow {
        let controller = NSHostingController(rootView: sender?.fixedSize())
        let win = NSWindow(contentViewController: controller)
        win.center()
        win.contentViewController = controller
        win.title = title
        win.level = level
        win.makeKeyAndOrderFront(sender)
        return win
    }
    
}
