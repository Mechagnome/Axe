//
//  UninstallAppsCell.swift
//  Axe
//
//  Created by linhey on 2021/10/22.
//

import SwiftUI
import Stem

struct UninstallAppCell: View {
    
    class ViewModel: ObservableObject {
        
        let app: UserApp
        
        init(app: UserApp) {
            self.app = app
        }
        
    }
    
    @ObservedObject
    var vm: ViewModel
    
    init(app: UserApp) {
        self.vm = .init(app: app)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(vm.app.appInfo.name)
                    .fontWeight(.medium)
                    .font(.title)
                HStack {
                    Text(vm.app.app.name)
                        .lineLimit(1)
                    if let text = vm.app.app.remark {
                        Text(text)
                    }
                }
                .font(.body)
            }
            Spacer()
            SFSymbol.trashCircle.convert()
                .font(.largeTitle)
                .foregroundColor(.red)
                .onTapGesture {
                    AlliancesManager.shared.uninstall(vm.app)
                }
        }
        .frame(width: 200, height: 60)
        .padding()
        .background(RoundedCorners(value: 12, color: Color.gray.opacity(0.25)))
    }
    
}

struct UninstallAppCell_Previews: PreviewProvider {
    static var previews: some View {
        UninstallAppCell(app: TestApp.useApp)
    }
}
