//
//  ContentView.swift
//  Dashboard
//
//  Created by Chris Ross on 4/8/23.
//

import SwiftUI

struct ContentView: View {
    var listMembers: Array<String> = []
    var body: some View {
        GeometryReader { geo in
            HStack {
                NavigationView {
                    List {}
                }
                .navigationTitle("Selections")
                .padding(5.0)
                .frame(maxWidth: geo.size.width * 0.25)
                VStack {
                    Calendar()
                    Spacer()
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                        .foregroundColor(.accentColor)
                        Text("Hello, world!")
                    }
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                //                    .background(Color.blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
