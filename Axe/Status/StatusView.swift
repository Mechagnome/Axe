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
            .font(Font.system(size: 14))

            Divider(
            )
            ForEach(vm.list) { model in
                StatusCell(model)
            }
            Spacer()
        }
        .padding(.all, 12)
        .frame(minWidth: 300, minHeight: 400)
    }
}

struct StatusView_Previews: PreviewProvider {
    
    public struct TestApp: AlliancesApp {
        
        public static let bundleID: String = UUID().uuidString
        public var core: AlliancesUICore = .init()
        public var configuration: AlliancesConfiguration
        
        public var name: String { Self.bundleID }
        public var remark: String? { "remark" }
        public var tasks: [AlliancesApp] = []
        
        public init(_ configuration: AlliancesConfiguration) {
            self.configuration = configuration
        }
        
        public func openSettings() {
            progress -= 0.05
        }
        
        public func run() throws {
            progress += 0.05
        }
    }
    
    static var previews: some View {
        Group {
            StatusView([UserApp(id: .init(), createTime: .init(), type: TestApp.self),
                        UserApp(id: .init(), createTime: .init(), type: TestApp.self),
                        UserApp(id: .init(), createTime: .init(), type: TestApp.self)])
        }
    }
}
