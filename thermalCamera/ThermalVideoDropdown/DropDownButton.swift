//
//  DropDownButton.swift
//  thermalCamera
//
//  Created by Stephen Comino on 3/7/21.
//

import SwiftUI

struct DropDownButton: View {
    @EnvironmentObject var added_items : modularised_ui
    @Environment(\.presentationMode) var presentationMode


    
    var body: some View {
        GeometryReader { geometry in
            
        VStack (alignment: .leading, spacing: 5) {
            Text("Pick an Image Display")
                .font(.title)
                .padding(10)
                .frame(maxWidth: geometry.size.width, alignment: .center)
            List(Array(zip(self.added_items.values.indices, self.added_items.values)), id: \.1) { (index, key) in
            
                HStack {
                    Spacer()
                    Text("\(key)")
                    Spacer()
                }.frame(width: geometry.size.width, height: 30, alignment: .center)
                .onTapGesture {
                    

                    self.added_items.current_view = index
                    color_scheme = index
                    presentationMode.wrappedValue.dismiss()
                }
            
            }
        }
        //.offset(y:-150)
        .frame(height: 600)
    }
    }
}

struct DropDownButton_Previews: PreviewProvider {
    static var previews: some View {
        DropDownButton()
    }
}
extension String: Identifiable {
    public var id: String {
        self
    }
}
