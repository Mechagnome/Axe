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
            AppPopView()
        }
    }
    
}
