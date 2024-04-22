//
//  ContentView.swift
//  ToDoListDemo
//
//  Created by leitanglong on 2024/3/16.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: PolygonTransform(), label: {
                    Text("Example1: PolygonTransform")
                })
                NavigationLink(destination: Example2(), label: {
                    Text("Example2: SkewedOffset")
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
