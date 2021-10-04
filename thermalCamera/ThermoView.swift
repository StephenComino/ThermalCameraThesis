//
//  ThermoView.swift
//  thermalCamera
//
//  Created by Stephen Comino on 13/6/21.
//

import SwiftUI

// Get Max and min Temperature and fill out the information
// Set this for every minute.

struct ThermoView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.blue)
            .frame(width: 25, height: 150, alignment: .leading)
    }
}

struct ThermoView_Previews: PreviewProvider {
    static var previews: some View {
        ThermoView()
    }
}
