//
//  AppWindow.swift
//  Axe
//
//  Created by linhey on 2021/10/30.
//

import AppKit
import SwiftUI

class AppWindow: NSWindow {
    
    override func close() {
        super.close()
        contentViewController = nil
    }
    
    @discardableResult
    static func show(title: String, sender: AnyView?, level: NSWindow.Level = .normal) -> NSWindow {
        let controller = NSHostingController(rootView: sender)
        let win = AppWindow(contentViewController: controller)
        win.styleMask.insert(.resizable)
        win.center()
        win.contentViewController = controller
        win.title = title
        win.level = level
        win.makeKeyAndOrderFront(sender)
        win.becomeMain()
        win.level = .popUpMenu
        win.level = level
        return win
    }
    
}
