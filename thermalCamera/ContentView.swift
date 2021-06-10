//
//  ContentView.swift
//  thermalCamera
//
//  Created by Stephanie Shore on 4/6/21.
//

import SwiftUI

class modularised_ui: ObservableObject {
    @Published var temp_range : Bool = false
    @Published var pencil : Bool = false
    @Published var view_objects : Bool = false
    @Published var capture_image : Bool = false
    @Published var zoom : Bool = false
    //@Published var items_added : int = 0
    @Published var buttons : [String: AnyView]  = [:]
    
}
struct ContentView: View {
    // Initialise the Struct to help us add Items to the UI Interface
    
    @ObservedObject var added_items = modularised_ui()
    var body: some View {
        // This is the Thermal Video Stream!!
        VStack(alignment: .leading) {
            imageVideo().frame(width: 400, height:300, alignment: .top)
                .border(Color.red, width: 2)
                .environmentObject(self.added_items)
                
            Spacer()
            NavigationView {
                if self.added_items.buttons.count == 0 {
                VStack(alignment: .center){
                    Text("Add Items to interact with Video")
                        NavigationLink(destination: MyView().environmentObject(self.added_items)) {
                                ZStack {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .padding(6)
                                        .frame(width: 24, height: 24)
                                        .background(Color.blue)
                                        .clipShape(Circle())
                                        .foregroundColor(.white)
                                        }
                            }
                        
                        Spacer()
                }
                } else {
                    VStack(alignment: .leading){
                        NavigationLink(destination: MyView().environmentObject(self.added_items)) {
                        ZStack {
                            Image(systemName: "plus")
                                .resizable()
                                .padding(6)
                                .frame(width: 24, height: 24)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .foregroundColor(.white)
                            
                                }
                        }
                        ForEach(Array(self.added_items.buttons), id: \.key) { key, value in
                            
                        HStack(alignment: .center){
                           value
                        
                        }
                            Spacer()
                        }
                    }
                }
                Spacer()
            // If not all UIs are added use the add button
            // Toggle Drawing when the Pen Is clicked
            // Ability to add and remove functionality,
            // 1. Zoom
            // 2. Temp Scale
            // 3. Save
            
        }
        }
    }

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
