//
//  LabelView.swift
//  ToDoListDemo
//
//  Created by leitanglong on 2024/4/21.
//

import SwiftUI

struct Example2: View {
    @State private var moveIt = false
    var body: some View {
        let animation = Animation.easeInOut(duration: 1.0)
        return VStack {
            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .red)
                .animation(animation, value: moveIt)
            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .orange)
                .animation(animation.delay(0.1), value: moveIt)

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .yellow)
            .animation(animation.delay(0.2), value: moveIt)

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .green)
                .animation(animation.delay(0.3), value: moveIt)

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .blue)
                .animation(animation.delay(0.4), value: moveIt)

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .purple)
            .animation(animation.delay(0.5), value: moveIt)

            LabelView(text: "The SwiftUI Lab", offset: moveIt ? 120 : -120, pct: moveIt ? 1 : 0, backgroundColor: .pink)
            .animation(animation.delay(0.6), value: moveIt)
            Button(action: { self.moveIt.toggle() }) { Text("Animate") }.padding(.top, 50)
        }
        .onTapGesture { self.moveIt.toggle() }
    }
}

struct LabelView: View {
    let text: String
    var offset: CGFloat
    var pct: CGFloat
    let backgroundColor: Color

    var body: some View {

        Text("The SwiftUI Lab")
            .font(.headline)
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(backgroundColor))
            .foregroundColor(Color.black)
            .modifier(SkewedOffset(offset: offset, pct: pct, goingRight: offset > 0))

    }
}

struct SkewedOffset: GeometryEffect {
    var offset: CGFloat
    var pct: CGFloat
    let goingRight: Bool
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(offset, pct)}
        set {
            offset = newValue.first
            pct = newValue.second
        }
    }
    
    init(offset: CGFloat, pct: CGFloat, goingRight: Bool) {
        self.offset = offset
        self.pct = pct
        self.goingRight = goingRight
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        var skew: CGFloat
        if (pct < 0.2) {
            skew = (goingRight ? -1 : 1) * 0.5 * (pct * 5)
        } else if (pct > 0.8) {
            skew = (goingRight ? -1 : 1) * 0.5 * ((1 - pct) * 5)
        } else {
            skew = (goingRight ? -1 : 1) * 0.5
        }
        return ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: skew, d: 1, tx: offset, ty: 0))
    }
}

#Preview {
    Example2()
}
