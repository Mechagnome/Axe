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
        private lazy var settingsWindow: NSWindow = {
           let item = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 400, height: 600),
                     styleMask: [.titled, .closable],
                     backing: .buffered,
                     defer: false)
            item.isReleasedWhenClosed = false
            item.center()
            return item
        }()
        
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
                self.settingsWindow.contentView = NSHostingView(rootView: view)
                self.settingsWindow.makeKey()
                self.settingsWindow.orderFrontRegardless()
            }.store(in: &cancellables)
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
                                try? self.app.openSettings()
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
    
    public struct ChildApp: AlliancesApp {
        
        public static let bundleID: String = UUID().uuidString
        public var core: AlliancesUICore = .init()
        public var configuration: AlliancesConfiguration
        
        public var name: String { Self.bundleID }
        public var remark: String? { "remark" }
        public var tasks: [AlliancesApp] = []
        
        public init(_ configuration: AlliancesConfiguration) {
            self.configuration = configuration
        }
        
        public func run() throws {
            progress += 0.05
            show(view: AnyView(Text("66666666")))
        }
    }
    
    public struct TestApp: AlliancesApp {
        
        public static let bundleID: String = UUID().uuidString
        public var core: AlliancesUICore = .init()
        public var configuration: AlliancesConfiguration
        
        public var name: String { Self.bundleID }
        public var remark: String? { "remark" }
        public var tasks: [AlliancesApp] = []
        
        public init(_ configuration: AlliancesConfiguration) {
            self.configuration = configuration
            self.tasks = [ChildApp(.init(from: configuration, app: ChildApp.self)),
                          ChildApp(.init(from: configuration, app: ChildApp.self))]
        }
        
        public func run() throws {
            progress += 0.05
            show(view: AnyView(Text("66666666")))
        }
    }
    
    static var previews: some View {
        VStack {
            StatusCell(UserApp(id: .init(), type: TestApp.self))
            StatusCell(UserApp(id: .init(), type: TestApp.self))
        }
        .fixedSize()
    }
}
