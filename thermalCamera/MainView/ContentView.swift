//
//  ContentView.swift
//  thermalCamera
//
//  Created by Stephen Comino on 4/6/21.
//

import SwiftUI

public var choose = 0
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

struct DistanceRow: View {
    @Binding var updater : Bool
    let timer = Timer.publish(every: 15, on: .main, in: .common).autoconnect()
    var temp_item: distance_object

    var body: some View {
        //Rectangle().frame(width:25, height: 25, alignment: .center).background(Color.black)
        Text("\(temp_item.name) Distance: \(temp_item.distance)\n")
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
    @Published var values:[String] = ["Autumn", "Bone", "Jet", "Winter", "Rainbow", "Ocean", "Summer", "Spring", "Cool", "HSV", "Pink", "Hot", "Parula", "Magma", "Inferno", "Plasma", "Viridis", "Cividis", "Twilight", "Twilight Shifted", "Turbo"]
    @Published var thermal_objects : [Thermal_Objects] = []
    @Published var distance_objects : [Distance_Object] = []
    @Published var tapped: Bool = false
    @Published var current_view = -1
    @Published var current_idx = 0
    @Published var choose_view:Bool = false
    //@State var showTimeframeDropDown = true
}
    
struct ContentView: View {
    // Initialise the Struct to help us add Items to the UI Interface
   
    @ObservedObject var added_items = modularised_ui()
    @State var updater: Bool = false
    @State var show_video_changer: Bool = false
    @State var showing_action_sheet: Bool = false
    
    
    var body: some View {
        // This is the Thermal Video Stream!!
       // NavigationView {
        VStack(alignment: .leading) {
            
            GeometryReader { geometry in
                ZStack() {
                    if added_items.choose_view {
                        imageVideo().frame(width: geometry.size.width, height:300, alignment: .top)
                            .border(Color.red, width: 2)
                            .environmentObject(self.added_items)                    } else {
                        
                
                    distanceImageVideo().frame(width: geometry.size.width, height:300, alignment: .top)
                    .border(Color.red, width: 2)
                .environmentObject(self.added_items)
                            }
                    if (added_items.toggle_pencil_usage) {
                        thermalPillView().environmentObject(self.added_items)
                            //.foregroundColor(Color.blue)
                        //.offset(x: 150)
                    }
                }
            }
        //}.frame(height:300)
        
        //NavigationView {
        GeometryReader { geometry in

            VStack(alignment: .leading, spacing: 5) {
        // Middle part
        //GeometryReader { geometry in
            
                //Form{
                HStack(alignment: .top, spacing: 5) {
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
                }.frame(width:50, height: 50)
                .zIndex(1)
                    
            ColorPicker("Pen Color", selection: $added_items.pencil_colour)
                .padding(10)
                .frame(width: 150, height: 50)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .zIndex(1)
                //.offset(y:-95)
                Button(action: {
                    print("Hello")
                    })
                    {
                        Image(systemName: "plus.magnifyingglass")
                        //.resizable()
                        //.padding(10)
                            .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                }.frame(width:50, height: 50)
                .zIndex(1)
                }
                .frame(width: geometry.size.width, height: 50, alignment:.center)
                //plus.magnifyingglass
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
                    }.buttonStyle(PlainButtonStyle())
                .frame(width:50, height: 50)
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
                }.buttonStyle(PlainButtonStyle())
                .frame(width:50, height: 50)
                
                Button(action: {self.show_video_changer.toggle()}) {
                        Image(systemName: "display")
                        .resizable()
                        .padding(10)
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                }.sheet(isPresented: self.$show_video_changer,
                        onDismiss: {self.show_video_changer = false },
                        content: {
                    DropDownButton().environmentObject(self.added_items)
                    
                }).frame(alignment: .center)
                .frame(width:50, height: 50)
                Button(action: {
                    print("Hello")
                    })
                    {
                        Image(systemName: "minus.magnifyingglass")
                        //.resizable()
                        //.padding(10)
                            .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                }.frame(width:50, height: 50)
                .zIndex(1)
                Button(action: {
                    if (added_items.choose_view == true) {
                        added_items.choose_view = false
                    } else {
                        added_items.choose_view = true
                    }
                    })
                    {
                        Image(systemName: "eye.fill")
                        //.resizable()
                        //.padding(10)
                            .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundColor(.white)
                }.frame(width:50, height: 50)
                .zIndex(1)
               
            }//.offset(y:-90)
            .frame(width: geometry.size.width, height: 50, alignment:.center)
            //.frame(width: geometry.size.width, alignment:.center)//.frame(width: geometry.size.width, height:
            
        if (!self.show_video_changer) {
                
                VStack(spacing: 5){
                //Text("Temperature Readings").fontWeight(.heavy).offset(y:-100)
                    if (added_items.thermal_objects.count == 0 && added_items.distance_objects.count == 0) {
                        Text("Temperature Readings").fontWeight(.heavy).offset(y:-100)
                        Text("Please circle an area on the Thermal image").fontWeight(.medium).offset(y:-100)
                    } else {
                        Text("Temperature Readings").fontWeight(.heavy)
            HStack {
                //Text("Temperature Readings").fontWeight(.heavy).offset(y:-100)
                if added_items.choose_view {
                List(added_items.thermal_objects) { key in
                    let idx = added_items.thermal_objects.firstIndex(where: { $0 === key })
                    Image.init(systemName: "minus.circle.fill").frame(width: 25, height: 25, alignment: .center)
                        .background(Color.clear)
                        .foregroundColor(Color.red).onTapGesture {
                            if let idx = added_items.thermal_objects.firstIndex(where: { $0 === key }) {
                                added_items.thermal_objects.remove(at: idx)
                            }
                        }
                    TemperatureRow(updater: self.$updater, temp_item: Temperature_object(name: key.name, temp: key.avg_temp, top_range: key.max_temp, low_range: key.min_temp))
                        .background(added_items.thermal_objects[idx!].alert_max != "" && ((Int(added_items.thermal_objects[idx!].alert_max)! < Int(added_items.thermal_objects[idx!].max_temp)) || (Int(added_items.thermal_objects[idx!].alert_min)! > Int(added_items.thermal_objects[idx!].min_temp))) ? Color.red : Color.clear)
                    
                    Spacer()
                    Button(action: {}) {
                        Text("Alerts").foregroundColor(.black).font(.system(size: 11.0))
                    }.frame(width: 35, height: 35, alignment: .center)
                    .background(Color.red)
                    .clipShape(Circle())
                    .onTapGesture {
                        self.showing_action_sheet.toggle()
                        let idx = added_items.thermal_objects.firstIndex(where: { $0 === key })
                        self.added_items.current_idx = idx!
                    }
                    .sheet(isPresented: self.$showing_action_sheet,
                            onDismiss: {self.showing_action_sheet = false },
                            content: {
                                setAlertView().environmentObject(self.added_items)
                        
                    }).frame(alignment: .center)
                }
                } else {
                    List(added_items.distance_objects) { key in
                        let idx = added_items.distance_objects.firstIndex(where: { $0 === key })
                        Image.init(systemName: "minus.circle.fill").frame(width: 25, height: 25, alignment: .center)
                            .background(Color.clear)
                            .foregroundColor(Color.red).onTapGesture {
                                if let idx = added_items.distance_objects.firstIndex(where: { $0 === key }) {
                                    added_items.distance_objects.remove(at: idx)
                                }
                            }
                        DistanceRow(updater: self.$updater, temp_item: distance_object(name: key.name, distance: key.distance))
                        
                        Spacer()
                        Button(action: {}) {
                            Text("Alerts").foregroundColor(.black).font(.system(size: 11.0))
                        }.frame(width: 35, height: 35, alignment: .center)
                        .background(Color.red)
                        .clipShape(Circle())
                        .onTapGesture {
                            self.showing_action_sheet.toggle()
                            let idx = added_items.distance_objects.firstIndex(where: { $0 === key })
                            self.added_items.current_idx = idx!
                        }
                        .sheet(isPresented: self.$showing_action_sheet,
                                onDismiss: {self.showing_action_sheet = false },
                                content: {
                                    setAlertView().environmentObject(self.added_items)
                            
                        }).frame(alignment: .center)
                }
                    
                }
                }//.frame(width: geometry.size.width, height: 150, alignment: .topLeading)
            
                    }//.frame(width: geometry.size.width, height: 200, alignment: .top)
                }.frame(width: geometry.size.width, height: 220, alignment: .bottom)
                //.offset(y:20)//.frame(width: geometry.size.width, height: 200, alignment: .top)
        }
        }
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
