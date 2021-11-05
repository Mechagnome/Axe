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
            
            userApp.app.core.showSettingsView.sink { _ in
                App.openWindow(for: .settings(app: userApp))
            }.store(in: &cancellables)
            
            userApp.app.core.showView.sink { view in
                App.openWindow(for: .others(ID: userApp.id.uuidString,
                                            title: userApp.app.name,
                                            view: view))
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
    
    @State
    var isPresented = false

    init(_ model: UserApp) {
        self.vm = ViewModel(model)
    }
    
    private var app: AlliancesApp { vm.userApp.app }
    
    var body: some View {
        VStack(alignment: .trailing) {
            

            HStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    Text(app.name)
                        .font(.title2)
                    
                    if let value = app.remark {
                        Text(value)
                            .fontWeight(.thin)
                            .font(.body)
                    }
                }
                
                Spacer()
                
                HStack {
                    if app.canRun {
                        Button {
                            try? app.run()
                        } label: {
                            SFSymbol.play.convert()
                        }
                    }
                    
                    if app.canOpenSettings {
                        Button {
                            App.openWindow(for: .settings(app: vm.userApp))
                        } label: {
                            SFSymbol.gear.convert()
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .font(.title2)
            }
            

            if app.progress > 0, app.progress <= 1 {
                Spacer().frame(height: 4)
                ProgressView(value: app.progress)
            }
            
            if vm.childApps.isEmpty == false {
                Spacer().frame(height: 4)
                ForEach(vm.childApps) { app in
                    StatusCell(app)
                }
            }
        }
        .padding(.all, 8)
        .listRowInsets(.init())
        .background(RoundedCorners(.all, value: 8, color: .gray.opacity(0.5)))
    }
    
}

struct StatusCell_Previews: PreviewProvider {
    
    static var previews: some View {
        return List {
            StatusCell(TestApp.useApp)
            StatusCell(TestApp.useApp)
        }
        .environment(\.defaultMinListRowHeight, 4)
    }
}
