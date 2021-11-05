//
//  StatusPreferencesView.swift
//  Axe
//
//  Created by linhey on 2021/10/21.
//

import SwiftUI
import Stem
import AppKit

struct StatusPreferencesView: View {
    var body: some View {
        MenuButton(label: SFSymbol.gear.convert()) {
            DividerSection(title: "About")
            Button(action: storeApps, label: { Text("App Store") })
            Button(action: unstallApps, label: { Text("My Apps") })
            Button(action: quit, label: { Text("Quit") })
        }
        .menuButtonStyle(BorderlessButtonMenuButtonStyle())
        .fixedSize()
    }
}

extension StatusPreferencesView {
    
    struct DividerSection: View {

        let title: String?

        var body: some View {
            VStack {
                Divider()
                if let title = title {
                    Text(title)
                }
            }
        }
    }

    
}

private extension StatusPreferencesView {

    func storeApps() {
        App.openWindow(for: .appSotre(view: .init(StoreAppsView())))
    }
    
    func unstallApps() {
        App.openWindow(for: .myApps(view: .init(UninstallAppsView())))
    }
    
    func quit() {
        NSApp.terminate(nil)
    }

}

struct StatusPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        StatusPreferencesView()
    }
}
