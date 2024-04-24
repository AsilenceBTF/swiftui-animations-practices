//
//  CradRotate.swift
//  AdvanceAnimation
//
//  Created by leitanglong on 2024/4/23.
//

import SwiftUI

struct CradRotate: View {
    @State var flipped = false
    @State var rotated = false
    @State private var imgIndex = 0
    
    let images = ["diamonds-7", "clubs-8", "diamonds-6", "clubs-b", "hearts-2", "diamonds-b"]
    var body: some View {
        let binding = Binding<Bool>(get: { self.flipped }, set: { self.updateBinding($0) })
                
        return VStack {
                Spacer()
                Image(flipped ? "back" : images[imgIndex])
                    .resizable()
                    .scaledToFit()
                    .padding(70)
                    .modifier(FlipEffect(flipped: binding, angle: rotated ? 0 : 360, axis: (1, 5)))
                    //  rorationEffect 绕着z轴旋转
                    .rotationEffect(Angle(degrees: rotated ? 0 : 360))
                    .onAppear() {
                        withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                            self.rotated = true
                        }
                    }
//                    .border(.blue)
                Spacer()
            }
//            .border(.red)
            .background(.black)
    }
    
    func updateBinding(_ value: Bool) {
        // If card was just flipped and at front, change the card
        if flipped != value && !flipped {
            self.imgIndex = self.imgIndex+1 < self.images.count ? self.imgIndex+1 : 0
        }
        
        flipped = value
    }
}

struct FlipEffect: GeometryEffect {
    
    @Binding var flipped: Bool
    
    var angle: Double
    
    var animatableData: Double {
        get { angle }
        set {
            angle = newValue
        }
    }
  
    
    let axis: (x: CGFloat, y: CGFloat)
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }
        let a = CGFloat(Angle(degrees: angle).radians)
                
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

#Preview {
    CradRotate()
}
