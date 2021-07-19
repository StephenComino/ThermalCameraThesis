//
//  setAlertView.swift
//  thermalCamera
//
//  Created by Stephen Comino on 12/7/21.
//
// This view is to be used to set the alert ranges
import SwiftUI

struct setAlertView: View {
    @EnvironmentObject var added_items: modularised_ui
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
        Text("Set Alert Max")
        TextField("enter a number ...", text: Binding(get: { self.added_items.thermal_objects[self.added_items.current_idx].alert_max },
                                                              set: { self.added_items.thermal_objects[self.added_items.current_idx].alert_max = $0.filter { "0123456789".contains($0) } }))
            .keyboardType(.numberPad)
            .frame(alignment: .center)
            Text("Set Alert Min")
            TextField("enter a number ...", text: Binding(get: { self.added_items.thermal_objects[self.added_items.current_idx].alert_min },
                                                                  set: { self.added_items.thermal_objects[self.added_items.current_idx].alert_min = $0.filter { "-0123456789".contains($0) } }))
                .keyboardType(.numberPad)
                .frame(alignment: .center)
            Button(action: {self.presentationMode.wrappedValue.dismiss()} ) {
                Text("Close")
            }
        }
    }
}

struct setAlertView_Previews: PreviewProvider {
    static var previews: some View {
        setAlertView()
    }
}
