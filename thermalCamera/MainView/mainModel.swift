//
//  mainModel.swift
//  thermalCamera
//
//  Created by Stephen Comino on 12/7/21.
//

import Foundation
// A struct to store exactly one restaurant's data.
struct Temperature_object: Identifiable {
    let id = UUID()
    let name: String
    let temp: Float
    let top_range: Float
    let low_range: Float
    let distance: Float
    //var temp_range: [CGPoint]
}

struct distance_object: Identifiable {
    let id = UUID()
    let name: String
    let distance: Double

}

class Thermal_Objects: Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var name: String = ""
    @Published var temp_range: [CGPoint] = []
    @Published var min_temp: Float = 0.0
    @Published var max_temp: Float = 0.0
    @Published var avg_temp: Float = 0.0
    @Published var tapped: Bool = false
    @Published var alert_max: String = ""
    @Published var alert_min: String = ""
    @Published var distance: Float = 0.0
}

class Distance_Object: Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var name: String = ""
    @Published var distance: Double = 0.0
    @Published var distance_range: [CGPoint] = []
    @Published var tapped: Bool = false
}
