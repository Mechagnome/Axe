//
//  StoreAppsView.swift
//  Axe
//
//  Created by linhey on 2021/10/21.
//

import SwiftUI
import Alliances

struct StoreAppsView: View {
    
    class ViewModel: ObservableObject {
        
        var apps: [AlliancesApp.Type]
        
        init() {
            apps = AlliancesManager.allApps
        }
        
    }
    
    @ObservedObject
    var vm = ViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            let columns = [GridItem(.adaptive(minimum: 200))]
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(vm.apps.indices, id: \.self) { index in
                    StoreAppsCell(app: vm.apps[index])
                }
            }
        }
        .frame(minWidth: 800, minHeight: 600)
    }
    
}

struct StoreAppsView_Previews: PreviewProvider {
    static var previews: some View {
        StoreAppsView()
    }
}
