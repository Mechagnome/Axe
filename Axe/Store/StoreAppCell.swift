//
//  StoreAppCell.swift
//  Axe
//
//  Created by linhey on 2021/10/21.
//

import SwiftUI
import Alliances
import Stem

struct StoreAppsCell: View {
    
    let app: AlliancesApp.Type
    
    init(app: AlliancesApp.Type) {
        self.app = app
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(app.appInfo.name)
                    .font(.title)
                Text(app.appInfo.summary)
                    .font(.body)
            }
            Spacer()
            SFSymbol.arrowDownCircle.convert()
                .font(.largeTitle)
                .onTapGesture {
                   try? AlliancesManager.shared.install(app)
                }
        }
        .frame(width: 200, height: 60)
        .padding()
        .background(RoundedCorners(value: 12, color: Color.gray.opacity(0.25)))
    }
    
}

struct StoreAppsCell_Previews: PreviewProvider {
    static var previews: some View {
        StoreAppsCell(app: TestApp.self)
    }
}
