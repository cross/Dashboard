//
//  Calendar.swift
//  Dashboard
//
//  Created by Chris Ross on 4/8/23.
//

import SwiftUI

struct Calendar: View {
    var body: some View {
        VStack {
            Text("This is a calendar")
                .padding(10)
            Text("No, really, it will be.")
                .padding(10)
        }.padding(5)
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
