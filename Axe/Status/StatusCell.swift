//
//  StatusCell.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import SwiftUI
import Alliances
import Stem
import Combine

struct StatusCell: View {
    
    private class ViewModel: ObservableObject {
        
        var userApp: UserApp
        var childApps: [UserApp] = []
        
        private var cancellables = Set<AnyCancellable>()
        private var settingsWindow: NSWindow?
        private var windows = [NSWindow]()
        
        init(_ userApp: UserApp) {
            self.userApp = userApp
            reload()
            
            userApp.app.core.canOpenSettings.sink { _ in
                self.objectWillChange.send()
            }.store(in: &cancellables)
            
            userApp.app.core.canRun.sink { _ in
                self.objectWillChange.send()
            }.store(in: &cancellables)
            
            userApp.app.core.reload.sink { _ in
                self.reload()
            }.store(in: &cancellables)
            
            userApp.app.core.progress.sink { _ in
                self.objectWillChange.send()
            }.store(in: &cancellables)
            
            userApp.app.core.showView.sink {[weak self] view in
                guard let self = self else { return }
                self.windows.append(self.openInWindow(title: userApp.app.name, sender: view))
            }.store(in: &cancellables)
        }
        
        func openInWindow(title: String, sender: AnyView?, level: NSWindow.Level = .normal) -> NSWindow {
            let controller = NSHostingController(rootView: sender?.fixedSize())
            let win = NSWindow(contentViewController: controller)
            win.center()
            win.contentViewController = controller
            win.title = title
            win.level = level
            win.makeKeyAndOrderFront(sender)
            return win
        }
        
        func openSettingsWindow() {
            self.settingsWindow?.close()
            self.settingsWindow = openInWindow(title: "settings", sender: userApp.app.settingsView, level: .popUpMenu)
        }
        
        func reload() {
            self.childApps = userApp.app.tasks.map({ app in
                UserApp(app: app)
            })
            self.objectWillChange.send()
        }
    }
    
    
    
    @ObservedObject
    private var vm: ViewModel
    
    init(_ model: UserApp) {
        self.vm = ViewModel(model)
    }
    
    private var app: AlliancesApp { vm.userApp.app }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(app.name)
                        .font(.title2)
                    
                    if let value = app.remark {
                        Text(value)
                            .font(.title3)
                    }
                }
                
                Spacer()
                
                HStack {
                    if app.canRun {
                        SFSymbol.play.convert()
                            .onTapGesture {
                                try? app.run()
                            }
                    }
                    
                    if app.canOpenSettings {
                        SFSymbol.gear.convert()
                            .onTapGesture {
                                vm.openSettingsWindow()
                            }
                    }
                }
                .font(.title)
            }
            
            if app.progress > 0, app.progress <= 1 {
                ProgressView(value: app.progress)
            }
            
            ForEach(vm.childApps) { app in
                StatusCell(app)
            }
            
        }
        .padding()
        .background(RoundedCorners(value: 12, color: Color.gray.opacity(0.25)))
        .cornerRadius(15)
    }
    
}

struct StatusCell_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            StatusCell(TestApp.useApp)
            StatusCell(TestApp.useApp)
        }
        .fixedSize()
    }
}
