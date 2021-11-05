//
//  ContentView.swift
//  Axe
//
//  Created by linhey on 2021/10/18.
//

import SwiftUI
import Alliances
import Combine
import Stem

struct StatusView: View {
    
    class ViewModel: ObservableObject {
        
        var list: [UserApp] = []
        private var cancellables = Set<AnyCancellable>()
        @State
        var searchTerm = ""

        init(_ list: [UserApp]) {
            self.list = list
            if Device.isPreviews {
                return
            }
            AlliancesManager.shared.myAppsDidChanged.sink { apps in
                self.list = apps
                self.objectWillChange.send()
            }.store(in: &cancellables)
        }
    }
    
    @ObservedObject
    var vm: ViewModel
    
    
    init(_ list: [UserApp]) {
        vm = .init(list)
    }
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center) {
                TextField("Search", text: $vm.searchTerm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                StatusPreferencesView()
            }
            .font(.body)
            .padding()

            Divider()
            
            List(vm.list) { model in
                StatusCell(model)
                Spacer().frame(height: 8)
            }
            
            Spacer()
        }
        .frame(minWidth: 400, minHeight: 600)
        
    }
}

struct StatusView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            StatusView([TestApp.useApp,
                        TestApp.useApp,
                        TestApp.useApp])
        }
    }
}
