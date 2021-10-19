//
//  ContentView.swift
//  Axe
//
//  Created by linhey on 2021/10/18.
//

import SwiftUI
import Alliances
import Combine

struct AppPopView: View {
    
    class ViewModel: ObservableObject {
        
        var list: [AlliancesApp] = []
        private var cancellables = Set<AnyCancellable>()
        
        init(_ list: [AlliancesApp]) {
            self.list = list
            for item in list {
                item.core.canOpenSettings.sink { _ in
                    self.objectWillChange.send()
                }.store(in: &cancellables)
                
                item.core.canRun.sink { _ in
                    self.objectWillChange.send()
                }.store(in: &cancellables)
                
                item.core.reload.sink { _ in
                    self.objectWillChange.send()
                }.store(in: &cancellables)
                
                item.core.progress.sink { _ in
                    self.objectWillChange.send()
                }.store(in: &cancellables)
            }
        }
    }
    
    @ObservedObject
    var vm: ViewModel
    
    
    init(_ list: [AlliancesApp]) {
        vm = .init(list)
    }
    
    var body: some View {
        List(vm.list, id: \.bundleID) { model in
            VStack {
                HStack {
                    VStack {
                        Text(model.name)
                        if let value = model.remark {
                            Text(value)
                        }
                    }
                    Button("Run") {
                       try? model.run()
                    }
                    Button("Settings") {
                        model.openSettings()
                    }
                }
                ProgressView(value: model.progress)
            }
        }
    }
}

struct AppPopView_Previews: PreviewProvider {
    
    class TestApp: AlliancesApp {
        
        var bundleID: String = UUID().uuidString
        
        var name: String { bundleID }
        
        var remark: String? {
            "remark"
        }
        
        var tasks: [AlliancesApp] = []
        
        var core: AlliancesUICore = .init()
        
        func openSettings() {
            progress -= 0.05
        }
        
        func run() throws {
            progress += 0.05
        }
        
    }
    
    static var previews: some View {
        Group {
            AppPopView([TestApp(),
                        TestApp(),
                        TestApp(),
                        TestApp(),
                        TestApp()])
        }
    }
}
