//
//  ContentView.swift
//  Dashboard
//
//  Created by Chris Ross on 4/8/23.
//

import SwiftUI

struct ContentView: View {
    var listMembers: Array<String> = ["Foo","Bar","Baz"]
    var body: some View {
        GeometryReader { geo in
            HStack {
                NavigationView {
                    List(listMembers, rowContent: { Text($0) })
                }
                .padding(5.0)
                .frame(maxWidth: geo.size.width * 0.25)
//                .navigationTitle("Selections")
                VStack {
                    Cat()
                    Spacer()
                    VStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                        .foregroundColor(.accentColor)
                        Text("Hello, world!")
                    }
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ImageFromNetwork())
    }
}

// Random ids for using String in a List()
// XXX - Should really create a struct that can generate a unique id, as this will make
// conflicting hashes, which will piss off List()
extension String: Identifiable {
    public var id: Int {
        return hash
    }
}
