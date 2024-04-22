//
//  PolygonTransform.swift
//  ToDoListDemo
//
//  Created by leitanglong on 2024/4/20.
//

import SwiftUI

struct MyButton: View {
    let label: String
    var font: Font = .title
    var textColor: Color = .white
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Text(label)
                .font(font)
                .padding(10)
                .frame(width: 70)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.green).shadow(radius: 2))
                .foregroundColor(textColor)
            
        })
    }
}

struct Example4PolygonShape: Shape {
    var sides: Double
    var scale: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatableData(sides, scale)
        }
        set {
            sides = newValue.first
            scale = newValue.second
        }
        
    }
    
    func path(in rect: CGRect) -> Path {
        let h = Double(min(rect.width, rect.height) / 2.0) * scale
        let c = CGPoint(x: rect.width / 2, y: rect.height / 2);
        var path = Path()
        
        let extra: Int = sides != Double(Int(sides)) ? 1 : 0
        
        var vertex: [CGPoint] = []
        
        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) * (360.0 / sides)) * (Double.pi / 180)
            
            // Calculate vertex
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            vertex.append(pt)
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        path.closeSubpath()
        drawVertexLines(path: &path, vertex: vertex, n: 0)
        return path
    }
    
    func drawVertexLines(path: inout Path, vertex: [CGPoint], n: Int) {
        
        if (vertex.count - n) < 3 { return }
        
        for i in (n+2)..<min(n + (vertex.count-1), vertex.count) {
            path.move(to: vertex[n])
            path.addLine(to: vertex[i])
        }
        
        drawVertexLines(path: &path, vertex: vertex, n: n+1)
    }
}

struct PolygonTransform: View {
    @State var sides: Double = 3
    @State var scale: Double = 1.0
    @State var duration: Double = 2.5
    var body: some View {
        VStack {
            Example4PolygonShape(sides: sides, scale: scale)
                .stroke(Color.blue, lineWidth: (sides < 3) ? 7 : ( sides < 7 ? 5 : 3))
                .padding(20)
                .animation(.easeInOut(duration: duration), value: sides)
            
            Text("\(Int(sides)) sides, \(String(format: "%.2f", scale as Double)) scale")
                .foregroundStyle(.white)
            
            Slider(value: $sides, in: 0...30)
            Slider(value: $scale, in: 0.3...1)
            HStack(spacing: 20) {
                MyButton(label: "1") {
                    self.sides = 1.0
                }
                
                MyButton(label: "3") {
                    self.sides = 3.0
                }
                
                MyButton(label: "7") {
                    self.sides = 7.0
                }
                
                MyButton(label: "30") {
                    self.sides = 30.0
                }
            }
        }
        .background(.black)
    }
}

#Preview {
    PolygonTransform()
}
