//
//  SwiftUIView.swift
//  thermalCamera
//
//  Created by Stephanie Shore on 10/6/21.
//

import SwiftUI
import AVKit

struct MyView: View {
    @EnvironmentObject var test : modularised_ui
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            HStack {
            Button(action: {self.test.pencil.toggle()
                if self.test.pencil {
                    self.test.buttons["pencil"] = AnyView(
                        HStack {
                        Button(action: {
                            self.test.toggle_pencil_usage.toggle()
                        }) {
                            Image(systemName: "pencil")
                            .resizable()
                            .padding(6)
                            .frame(width: 40, height: 40)
                            .background(self.test.toggle_pencil_usage ? Color.blue : Color.white)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                        }
                            ColorPicker("Set pencil Colour", selection: self.$test.pencil_colour)
                            .frame(width: 150, height: 150, alignment: .center)
                        })
                } else {
                    if (self.test.buttons["pencil"] != nil) {
                        print(self.test.buttons)
                        self.test.buttons.removeValue(forKey: "pencil")
                    }
                }
            }, label: {
                if self.test.pencil == false {
                    Text("Add drawing Pencil").padding(10)
                    
                } else {
                    Text("Remove drawing Pencil").padding(10)
                }
            })
            .clipShape(Rectangle())
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(7.0)
                
            Button(action: {
                    self.test.capture_image.toggle()
                    if self.test.capture_image {
                        self.test.buttons["camera"] = AnyView(Button(action: {
                            
                            _ = body.snapshot()
                                UIImageWriteToSavedPhotosAlbum(screenshot(), nil, nil, nil)
                            })
                            {
                                Image(systemName: "camera")
                                .resizable()
                                .padding(6)
                                .frame(width: 40, height: 40)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        })
                    } else {
                        if (self.test.buttons["camera"] != nil) {
                            print(self.test.buttons)
                            self.test.buttons.removeValue(forKey: "camera")
                        }
                        print(self.test.buttons)
                    }
            }, label: {
                if self.test.capture_image == false {
                    Text("Add Photo capture").padding(10)
                } else {
                    Text("Remove Photo capture").padding(10)
                }
            })
            .clipShape(Rectangle())
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            }
            
            HStack {
            Button(action: {self.test.temp_range.toggle()}, label: {
                Text("Add Temp Range Scaler").padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            })
            .clipShape(Rectangle())
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            Button(action: {self.test.temp_range.toggle()}, label: {
                Text("Add Change Camera View").padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            })
            .clipShape(Rectangle())
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(7.0)
            }
        })
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}

