//
//  ContentView.swift
//  thermalCamera
//
//  Created by Stephanie Shore on 4/6/21.
//

import SwiftUI


// A struct to store exactly one restaurant's data.
struct Temperature_object: Identifiable {
    let id = UUID()
    let name: String
    let temp: Float
    let top_range: Float
    let low_range: Float
    //var temp_range: [CGPoint]
}
class Thermal_Objects: Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var name: String = ""
    @Published var temp_range: [CGPoint] = []
    @Published var min_temp: Float = 0.0
    @Published var max_temp: Float = 0.0
    @Published var avg_temp: Float = 0.0
    @Published var tapped: Bool = false
}

// A view that shows the data for one Restaurant.
struct TemperatureRow: View {
    @Binding var updater : Bool
    let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    var temp_item: Temperature_object

    var body: some View {
        //Rectangle().frame(width:25, height: 25, alignment: .center).background(Color.black)
        Text("\(temp_item.name) Lowest: \(temp_item.low_range)\n - Heighest: \(temp_item.top_range)\n Avg :: \(temp_item.temp)")
    }
}

class modularised_ui: ObservableObject {
    @Published var temp_range : Bool = false
    @Published var pencil : Bool = false
    @Published var toggle_pencil_usage : Bool = true
    @Published var pencil_colour : Color = Color.black
    @Published var view_objects : Bool = false
    @Published var capture_image : Bool = false
    @Published var zoom : Bool = false
    @Published var buttons : [String: AnyView]  = [:]
    //@ObservedObject private var therm_obj = Thermal_Objects()
    @Published var thermal_objects : [Thermal_Objects] = []
    @Published var tapped: Bool = false
    
}
struct ContentView: View {
    // Initialise the Struct to help us add Items to the UI Interface
   
    @ObservedObject var added_items = modularised_ui()
    @State var updater: Bool = false
    var body: some View {
        // This is the Thermal Video Stream!!
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                ZStack() {
                    imageVideo().frame(width: geometry.size.width, height:300, alignment: .top)
                        .border(Color.red, width: 2)
                        .environmentObject(self.added_items)
                    if (added_items.toggle_pencil_usage) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 20, height: 125, alignment: .center)
                            .background(Color.clear)
                            .overlay(
                            LinearGradient(gradient: Gradient(colors: [.blue, .yellow, .red]), startPoint: .top, endPoint: .bottom))
                            //.foregroundColor(Color.blue)
                            .offset(x: 150)
                    }
                }
            }
        }
        
        // Middle part
        GeometryReader { geometry in
            
            VStack(alignment: .trailing, spacing: 10) {
            HStack(alignment: .center, spacing: 10) {
                Button(action: {
                    _ = body.snapshot()
                        UIImageWriteToSavedPhotosAlbum(screenshot(), nil, nil, nil)
                    })
                    {
                        Image(systemName: "camera")
                        //.resizable()
                        //.padding(10)
                            .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                    }
            ColorPicker("Pen Color", selection: $added_items.pencil_colour)
                .padding(10)
                .frame(width: 150, height: 50)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
              
            }.frame(width: geometry.size.width, height: 65, alignment: .center)
            // This button will toggle temperature readings on the screen
            HStack(alignment: .center, spacing: 10) {
                Button(action: {
                    added_items.toggle_pencil_usage.toggle()
                }) {
                    Image(systemName: "thermometer")
                        .resizable()
                        .padding(10)
                        .frame(width: 50, height: 50)
                        .background(added_items.toggle_pencil_usage ? Color.blue : Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(added_items.toggle_pencil_usage ? Color.white : Color.blue)
                    }
                Button(action: {
                    // Do Reset
                    let url = URL(string: "http://192.168.0.187/reset")!
                    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                        guard let data = data else { return }
                        print(String(data: data, encoding: .utf8)!)
                    }
                    task.resume()
                    
                }) {
                    Image(systemName: "arrow.clockwise.circle.fill")
                    .resizable()
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white)
                
                //ThermoView().environmentObject(added_items)
                }
            }.frame(width: geometry.size.width, height: 65, alignment: .center)
        }
        }.offset(y:80)
            // Bottom Part
            GeometryReader { geometry in
                VStack(spacing: 10) {
                Text("Temperature Readings").fontWeight(.heavy)
                    if (added_items.thermal_objects.count == 0) {
                        Text("Please circle an area on the Thermal image").fontWeight(.medium).offset(x:20)
                    } else {
            HStack {
               
                List(added_items.thermal_objects) { key in
                 
                    Image.init(systemName: "minus.circle.fill").frame(width: 25, height: 25, alignment: .center)
                        .background(Color.clear)
                        .foregroundColor(Color.red).onTapGesture {
                            if let idx = added_items.thermal_objects.firstIndex(where: { $0 === key }) {
                                added_items.thermal_objects.remove(at: idx)
                            }
                        }
                    TemperatureRow(updater: self.$updater, temp_item: Temperature_object(name: key.name, temp: key.avg_temp, top_range: key.max_temp, low_range: key.min_temp)).onTapGesture {
                        //Highlight the area where selected.
                        drawPathAgain(list: key.temp_range)
                        //circle_path.addPoint(
                        //let Circle_path = Path { path in
                        //    var count = 0
                        //    for index in key.temp_range {
                       //         if (count == 0) {
                        //            path.move(to: index)
                       ///         } else {
                        //            path.addLine(to: index)
                        //
                        //        }
                        //        count += 1
                        //    }
                            
                       // }
                       // Circle_path.fill(Color.red)
                        
                    }
                        
                        .environmentObject(self.added_items)
                }
                }.frame(width: geometry.size.width, height: 200, alignment: .bottom)
            }
            //.frame(width: geometry.size.width, height: 200, alignment: .bottom)
            }
            }
            }

}

func drawPathAgain(list:[CGPoint]) {
    //imageVideo.
}
extension View {
    func snapshot() -> UIImage {
        
        let controller = UIHostingController(rootView:self)
        let view = controller.view
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(x:0, y:0, width:400, height:300)
        view?.backgroundColor = .clear
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
func screenshot() -> UIImage {
    let imageSize = UIScreen.main.bounds.size as CGSize;
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
    let context = UIGraphicsGetCurrentContext()
    for obj : AnyObject in UIApplication.shared.windows {
        if let window = obj as? UIWindow {
            if window.responds(to: #selector(getter: UIWindow.screen)) || window.screen == UIScreen.main {
                                // so we must first apply the layer's geometry to the graphics context
                                context!.saveGState();
                                // Center the context around the window's anchor point
                                context!.translateBy(x: window.center.x, y: window.center
                                    .y);
                                // Apply the window's transform about the anchor point
                                context!.concatenate(window.transform);
                                // Offset by the portion of the bounds left of and above the anchor point
                context!.translateBy(x: -window.bounds.size.width * window.layer.anchorPoint.x,
                                     y: -window.bounds.size.height * window.layer.anchorPoint.y);

                                // Render the layer hierarchy to the current context
                                window.layer.render(in: context!)

                                // Restore the context
                                context!.restoreGState();
            }
        }
    }
    let image = UIGraphicsGetImageFromCurrentImageContext();
    return image!
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
