//
//  StatusCell.swift
//  Axe
//
//  Created by linhey on 2021/10/19.
//

import SwiftUI
import Alliances
import Stem

struct StatusCell: View {
    
    let model: UserApp
    
    private var app: AlliancesApp { model.app }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(app.name)
                    if let value = app.remark {
                        Text(value)
                    }
                }
                
                Spacer()
                
                HStack {
                    SFSymbol.play.convert()
                        .onTapGesture {
                            try? app.run()
                        }
                    
                    SFSymbol.gear.convert()
                        .onTapGesture {
                            app.openSettings()
                            
                        }
                }
            }
            
            if app.progress > 0 {
                ProgressView(value: app.progress)
            }
            
        }.padding()
    }
    
}

struct StatusCell_Previews: PreviewProvider {
    
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
        StatusCell(model: UserApp.init(id: .init(), type: TestApp.self))
    }
}
