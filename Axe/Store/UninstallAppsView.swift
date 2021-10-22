//
//  UninstallAppsView.swift
//  Axe
//
//  Created by linhey on 2021/10/22.
//

import SwiftUI
import Stem
import Combine

struct UninstallAppsView: View {

    class ViewModel: ObservableObject {
        
        private(set) var apps: [UserApp] = []
        private var cancellables = Set<AnyCancellable>()

        init() {
           AlliancesManager.shared.myAppsDidChanged.sink(receiveValue: { apps in
               self.apps = apps
               self.objectWillChange.send()
           }).store(in: &cancellables)
        }
        
    }
    
    @ObservedObject
    var vm = ViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            let columns = [GridItem(.adaptive(minimum: 200))]
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(vm.apps) { app in
                    UninstallAppCell(app: app)
                }
            }
        }
        .frame(minWidth: 800, minHeight: 600)
    }
    
}

struct UninstallAppsView_Previews: PreviewProvider {
    static var previews: some View {
        UninstallAppsView()
    }
}
