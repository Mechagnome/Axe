//
//  RoundedCorners.swift
//  Axe
//
//  Created by linhey on 2021/10/20.
//

import SwiftUI

struct RoundedCorners: View {
    
    let color: Color
    
    let minXMinY: CGFloat
    let maxXMinY: CGFloat
    let minXMaxY: CGFloat
    let maxXMaxY: CGFloat
    
    init(_ edges: Edge.Set = .all, value: CGFloat, color: Color) {
        var minXMinY: CGFloat = 0
        var maxXMinY: CGFloat = 0
        var minXMaxY: CGFloat = 0
        var maxXMaxY: CGFloat = 0
        
        switch edges {
        case .leading:
            minXMinY = value
            minXMaxY = value
        case .trailing:
            maxXMinY = value
            maxXMaxY = value
        case .top:
            minXMinY = value
            maxXMinY = value
        case .bottom:
            minXMaxY = value
            maxXMaxY = value
        default:
            minXMinY = value
            maxXMinY = value
            minXMaxY = value
            maxXMaxY = value
        }
        
        self.init(minXMinY: minXMinY,
                  maxXMinY: maxXMinY,
                  minXMaxY: minXMaxY,
                  maxXMaxY: maxXMaxY,
                  color: color)
    }
    
    init(minXMinY: CGFloat = 0.0,
         maxXMinY: CGFloat = 0.0,
         minXMaxY: CGFloat = 0.0,
         maxXMaxY: CGFloat = 0.0,
         color: Color) {
        
        self.minXMinY = max(minXMinY, 0)
        self.maxXMinY = max(maxXMinY, 0)
        self.minXMaxY = max(minXMaxY, 0)
        self.maxXMaxY = max(maxXMaxY, 0)
        
        self.color = color
    }

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let w = geometry.size.width
                let h = geometry.size.height

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - maxXMinY, y: 0))
                path.addArc(center: CGPoint(x: w - maxXMinY, y: maxXMinY),
                            radius: maxXMinY,
                            startAngle: Angle(degrees: -90),
                            endAngle: Angle(degrees: 0),
                            clockwise: false)
                
                path.addLine(to: CGPoint(x: w, y: h - maxXMaxY))
                path.addArc(center: CGPoint(x: w - maxXMaxY, y: h - maxXMaxY),
                            radius: maxXMaxY,
                            startAngle: Angle(degrees: 0),
                            endAngle: Angle(degrees: 90),
                            clockwise: false)
                
                path.addLine(to: CGPoint(x: minXMaxY, y: h))
                path.addArc(center: CGPoint(x: minXMaxY, y: h - minXMaxY),
                            radius: minXMaxY, startAngle: Angle(degrees: 90),
                            endAngle: Angle(degrees: 180),
                            clockwise: false)
                
                path.addLine(to: CGPoint(x: 0, y: minXMinY))
                path.addArc(center: CGPoint(x: minXMinY, y: minXMinY),
                            radius: minXMinY,
                            startAngle: Angle(degrees: 180),
                            endAngle: Angle(degrees: 270),
                            clockwise: false)
            }
            .fill(self.color)
        }
    }
}


struct RoundedCorners_Previews: PreviewProvider {
    static var previews: some View {
        let width: CGFloat = 200
        let height: CGFloat = 40

       return VStack(spacing: 4) {
            Text("Text")
                .frame(width: width, height: height, alignment: .center)
                .background(RoundedCorners(.all, value: 20, color: Color.red))
            Text("Text")
                .frame(width: width, height: height, alignment: .center)
                .background(RoundedCorners(.top, value: 20, color: Color.blue))
            Text("Text")
                .frame(width: width, height: height, alignment: .center)
                .background(RoundedCorners(.bottom, value: 20, color: Color.red))
            Text("Text")
                .frame(width: width, height: height, alignment: .center)
                .background(RoundedCorners(.leading, value: 20, color: Color.blue))
            Text("Text")
                .frame(width: width, height: height, alignment: .center)
                .background(RoundedCorners(.trailing, value: 20, color: Color.red))
            Text("Text")
                .frame(width: width, height: height, alignment: .center)
                .background(RoundedCorners(minXMinY: 200,
                                           maxXMinY: 40,
                                           minXMaxY: 30,
                                           maxXMaxY: 5  ,
                                           color: .red))
        }
    }
}
