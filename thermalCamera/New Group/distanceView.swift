
import SwiftUI

var distance_points = [CGPoint]()
var num_distance = 0
var index_item_distance = 0
var last_pixel_distance:CGPoint? = nil
public var color_scheme_distance = -1
// View Controller Representable
// Bridge between Objective C (UI KIT) and Swift UI

struct distanceImageVideo: UIViewControllerRepresentable {

    @EnvironmentObject var added_items : modularised_ui

    func makeUIViewController(context: Context) -> UIViewController {
        // Set the ImageView to the stream object

        return DistanceVideoViewController(added_items: added_items)
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
        uiViewController.view.setNeedsDisplay()
        
        //uiViewController.view.setNeedsLayout()
        //uiViewController.view.
        //uiViewController.viewDidAppear(true)
        //uiViewController.up
        
    }
    
    
    typealias UIViewControllerType = UIViewController
}

// View Controller that lets us draw on the screen
class DistanceVideoViewController: UIViewController {
    
    private var pointsArray = [CGPoint]()
    var circle_path = DistanceCircleView(frame: CGRect(x:0, y:0, width:375, height:299))
    let path = UIBezierPath()
    var added_items : modularised_ui = modularised_ui()
    var stream: MJPEGStreamLib? = nil
    var imageView: UIImageView? = nil
   // var stream = MJPEGStreamLib()
    
    init(added_items: modularised_ui) {
           self.added_items = added_items
        
           //super.init(coder: NSCoder)
        super.init(nibName: nil, bundle: nil)

       }
       
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Get the Request for temperature
        distance_temp_timer(added_items: added_items)
        //imageView : UIImageView
        //var stream: MJPEGStreamLib
        
        //print("\(OpenCVWrapper.openCVVersionString())")
        imageView  = UIImageView(frame:CGRect(x:0, y:0, width:375, height:299));
        imageView!.tag = 55
        // Set the ImageView to the stream object
        stream = MJPEGStreamLib(imageView: imageView!)
        var url: URL?
        url = URL(string: "http://192.168.0.187/video_stream?type=1")
        print(self.added_items.choose_view)
        stream!.contentURL = url
        stream!.play() // Play the stream
        //print(stream.imageView.image)
        //self.imageView.tag = 55
        let value = stream!.get_view()
        print("Value \(value)")
        if (value != self.added_items.current_view) {
            stream!.change_view(data: Int32(self.added_items.current_view))
            imageView  = UIImageView(frame:CGRect(x:0, y:0, width:375, height:299));
            // Set the ImageView to the stream object
            stream = MJPEGStreamLib(imageView: imageView!)
            
            if let viewWithTag = self.view.viewWithTag(55) {
                viewWithTag.removeFromSuperview()
                print("REMOVED")
                self.view.addSubview(imageView!)
            }
        } else {
        self.view.addSubview(imageView!)
        }
    }
    
   
    func showDrawing(list: [CGPoint]) {
        for p in list {
            circle_path.add_point(point: p)
        }
        circle_path = DistanceCircleView(frame: CGRect(x:0, y:0, width:375, height:299))
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //stream.change_view(data: )
        //open func change_view(data: Int32) {
        //    self.object_view = data
        // }
        // Your stream url should be here !
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super .viewDidDisappear(true)
        stream!.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Make the Status Bar Light/Dark Content for this View
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    // Start the Touch Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Check if there is a subView and if there is, Remove it then add the new one
        // before we remove the old subview we should think of saving it
        //print(num)
        if (num_distance >= 1) {
            removeSubView()
        }
        circle_path.remove_list()
        let touch = touches.first!
        _ = touch.location(in: self.view)
        
        circle_path = DistanceCircleView(frame: CGRect(x:0, y:0, width:375, height:299))
        circle_path.tag = 99
        if ((self.added_items.toggle_pencil_usage)) {
        for touch in touches {
            
        
            //print(touch.location(in: self.view))
               // Set the Center of the Circle
               // 1
            let circleCenter = touch.location(in: view)

            
            let point = CGPoint(x: circleCenter.x, y: circleCenter.y)
            last_pixel_distance = point
            // Join up
            //pointsArray.append(point)
            circle_path.add_point(point: point)
    
            
            
         
            circle_path.change_colour(col: self.added_items.pencil_colour)
            view.addSubview(circle_path)
        }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ((self.added_items.toggle_pencil_usage)) {
        for touch in touches {
            //print("Adding")
            let circleCenter = touch.location(in: view)
            let point = CGPoint(x: circleCenter.x, y: circleCenter.y)
         
            circle_path.add_point(point: point)
            
            
            circle_path.setNeedsDisplay()
            
        }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("ended")
     
        circle_path.add_point(point: CGPoint(x: distance_points[0].x, y: distance_points[0].y))
        circle_path.setNeedsDisplay()
        num_distance += 1
        // Add to the list
        let obj = Distance_Object()
        obj.name = "\(index_item_distance)"
        obj.distance_range = distance_points
        print(distance_points)
        added_items.distance_objects.append(obj)
        print(added_items.distance_objects)
        index_item_distance += 1
    }
    
    func removeSubView(){
        //print("Start remove subview")
        if let viewWithTag = self.view.viewWithTag(99) {
            viewWithTag.removeFromSuperview()
            num_distance -= 1
        }else{
            print("No!")
        }
    }
    
    
    
}

// Handle First touch
// Handle touch moved
// Handle touch end
class DistanceCircleView: UIView {
    //private var points = [CGPoint]()
    var colour = Color.black
    var path = UIBezierPath()
    private var last_index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func change_colour (col : Color) {
        self.colour = col
    }
    

    func add_point(point: CGPoint) {
        distance_points.append(point)

    }
    func remove_list() {
        last_index = 0
        distance_points.removeAll()
    }
    
    override func draw(_ rect: CGRect) {
        // Get the Graphics Context
        print("Drawing")

        if let context = UIGraphicsGetCurrentContext() {
            
            if (last_index == 0 && distance_points.count > 0) {
                self.path.move(to: distance_points[0])
                for p in distance_points {
                    self.path.addLine(to: p)
                }
                self.last_index = distance_points.count

            } else if (distance_points.count > 0) {
                self.path.move(to: distance_points[last_index])
                for p in distance_points[last_index...(distance_points.count-1)] {
                    self.path.addLine(to: p)
                }
            } else {
                return
            }
            UIColor(self.colour).set() //self.colour.set()
            self.path.stroke()
           //If you want to fill it as well
           //path.fill()
        context.strokePath()
            
        }
    }
    
    
}
