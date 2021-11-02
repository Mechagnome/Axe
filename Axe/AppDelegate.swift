//
//  AppDelegate.swift
//  Axe
//
//  Created by linhey on 2021/10/18.
//

import AppKit
import SwiftUI
import Stem

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private lazy var statusItem: NSStatusItem = {
        let view = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
        view.button?.action = #selector(popoverButtonTapped(_:))
        return view
    }()
    
    private lazy var popover: NSPopover = {
        let view = NSPopover()
        view.behavior = .transient
        view.appearance = NSAppearance(named: .vibrantLight)
        let apps = Array(AlliancesManager.shared.myApps.prefix(5))
        let hoster = NSHostingController(rootView: StatusView(apps))
        view.contentViewController = hoster
        view.contentSize = .init(width: 400, height: 600)
        return view
    }()
        
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.image = SFSymbol.infinity.convert()
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] (event) in
            if self?.popover.isShown ?? false {
                self?.popover.close()
            }
        }
    }
    
    @objc private func popoverButtonTapped(_ sender: NSStatusBarButton) {
        self.popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.minY)
        NSApp.activate(ignoringOtherApps: true)
    }

}
