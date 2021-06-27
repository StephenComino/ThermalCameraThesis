//
//  timerviewmodel.swift
//  thermalCamera
//
//  Created by Stephanie Shore on 19/6/21.
//

import Foundation
struct therm_data: Codable {
    var isError: Bool?
    var message: String?
    var statusCode: Int?
    var data: [Float]?
}
class temp_timer {
    var added_items: modularised_ui   // just member
        
    init (added_items: modularised_ui) {
        self.added_items = added_items
        
        _ = Timer.scheduledTimer(timeInterval: 35.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
       
        fetchFilms() { data in
            print(data)
            // [min, max, average]
        }
    }
    
    func fetchFilms(completionHandler: @escaping ([Float]) -> Void) {
        
        // For items in the range,, Get the pixel values
        // Average
        // Max and Min for in the area.
        for items in self.added_items.thermal_objects {
            var x = [CGFloat]()
            var y = [CGFloat]()
            for x_in in items.temp_range {
                x.append(x_in.x)
                y.append(x_in.y)
            }

        
            var url = URLComponents(string: "http://192.168.0.187/tempAt")!

            var queryItems = [URLQueryItem]()
            for x_val in x {
                queryItems.append(URLQueryItem(name: "x", value: "\(x_val)"))
            }
            for y_val in y {
                queryItems.append(URLQueryItem(name: "y", value: "\(y_val)"))
            }
            url.queryItems = queryItems
            let request = URLRequest(url: url.url!)
            print(request)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching thermal_data: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            return
          }

          if let data = data,
             let thermal_data_results = try? JSONDecoder().decode(therm_data.self, from: data) {
            DispatchQueue.main.async {
            
                items.min_temp = (thermal_data_results.data?[0])!
                items.max_temp = (thermal_data_results.data?[1])!
                items.avg_temp = (thermal_data_results.data?[2])!
                self.added_items.tapped.toggle()
            }
            completionHandler(thermal_data_results.data ?? [0.0])
          }
            })
        task.resume()
      }
    }
}
