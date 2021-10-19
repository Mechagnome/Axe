//
//  AppDelegate.swift
//  Axe
//
//  Created by linhey on 2021/10/18.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private lazy var statusItem: NSStatusItem = {
        let view = NSStatusBar.system.statusItem(withLength: 25)
        view.button?.action = #selector(popoverButtonTapped(_:))
        return view
    }()
    
    private lazy var popover: NSPopover = {
        let view = NSPopover()
        view.behavior = .transient
        view.appearance = NSAppearance(named: .vibrantLight)
        let apps = Array(AlliancesManager.shared.myApps.prefix(5))
        view.contentViewController = NSHostingController(rootView: StatusView(apps))
        return view
    }()
        
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.image = NSImage(named: "StatusIcon")
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] (event) in
            if self?.popover.isShown ?? false {
                self?.popover.close()
            }
        }
    }
    
    @objc private func popoverButtonTapped(_ sender: NSStatusBarButton) {
        popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
    }

}
