import MJPEGStreamLib
import SwiftUI

var points = [CGPoint]()

struct imageVideo: UIViewControllerRepresentable {

    @EnvironmentObject var added_items : modularised_ui

    func makeUIViewController(context: Context) -> UIViewController {
        // Set the ImageView to the stream object

        return VideoViewController(added_items: added_items)
        
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    
    }
    
    
    typealias UIViewControllerType = UIViewController
}

class VideoViewController: UIViewController {
    
    private var pointsArray = [CGPoint]()
    var circle_path = CircleView(frame: CGRect(x:0, y:0, width:400, height:300))
    let path = UIBezierPath()
    var added_items : modularised_ui = modularised_ui()
    
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
        var imageView : UIImageView
        var stream: MJPEGStreamLib
        var url: URL?
        imageView  = UIImageView(frame:CGRect(x:0, y:0, width:400, height:300));
        // Set the ImageView to the stream object
        stream = MJPEGStreamLib(imageView: imageView)
        // Your stream url should be here !
        url = URL(string: "http://192.168.0.187/video_stream")
        stream.contentURL = url
        stream.play() // Play the stream
        
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Make the Status Bar Light/Dark Content for this View
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        _ = touch.location(in: self.view)
        circle_path = CircleView(frame: CGRect(x:0, y:0, width:400, height:300))
        if ((self.added_items.toggle_pencil_usage)) {
        for touch in touches {
            
            print(touch.location(in: self.view))
               // Set the Center of the Circle
               // 1
            var circleCenter = touch.location(in: view)

               // Create a new CircleView
               // 3
              // let circleView = CircleView(frame: CGRect(x: circleCenter.x, y: circleCenter.y, width: circleWidth, height: circleHeight))
            let point = CGPoint(x: circleCenter.x, y: circleCenter.y)
            
            // Join up
            //pointsArray.append(point)
            circle_path.add_point(point: point)
            // Make initial Point
            // Check and remove old subview
            
            view.addSubview(circle_path)
            if circle_path.isDescendant(of: view) {
                circle_path.removeFromSuperview()
                circle_path.remove_list()
            }
            circle_path.change_colour(col: self.added_items.pencil_colour)
                view.addSubview(circle_path)
            
        }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ((self.added_items.toggle_pencil_usage)) {
        for touch in touches {
            //print("Adding")
            var circleCenter = touch.location(in: view)
               // Set a random Circle Radius
               // 2
               //let circleWidth = CGFloat(25)
               //let circleHeight = circleWidth
                   
               // Create a new CircleView
               // 3
              // let circleView = CircleView(frame: CGRect(x: circleCenter.x, y: circleCenter.y, width: circleWidth, height: circleHeight))
            let point = CGPoint(x: circleCenter.x, y: circleCenter.y)
            
            // Join up
            //pointsArray.append(point)
            circle_path.add_point(point: point)
            
            
            circle_path.setNeedsDisplay()
            
        }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ended")
        
        if ((self.added_items.toggle_pencil_usage)) {
        view.addSubview(circle_path)
        }
        }
        
    
    
}

// Handle First touch
// Handle touch moved
// Handle touch end
class CircleView: UIView {
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
        points.append(point)
        print(point)
        print(points)
        print(last_index)
        //draw(CGRect(x: 0, y: 0, width: 400, height: 300))
    }
    func remove_list() {
        last_index = 0
        points.removeAll()
    }
    
    override func draw(_ rect: CGRect) {
        // Get the Graphics Context
        if let context = UIGraphicsGetCurrentContext() {
            
            print(points)
            if (last_index == 0 && points.count > 0) {
                self.path.move(to: points[0])
                for p in points {
                    self.path.addLine(to: p)
                    print(p)
                }
                self.last_index = points.count

            } else if (points.count > 0) {
                self.path.move(to: points[last_index])
                for p in points[last_index...(points.count-1)] {
                    self.path.addLine(to: p)
                }
            } else {
                return
            }           //path.move(to: point)
            
                       //Keep using the method addLineToPoint until you get to the one where about to close the path

           //path.close()

           //If you want to stroke it with a red color
            //UIColor.red.set()
            UIColor(self.colour).set() //self.colour.set()
            self.path.stroke()
           //If you want to fill it as well
           //path.fill()
        context.strokePath()
            
        }
    }
}
