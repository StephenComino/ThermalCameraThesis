//
//  timerModel.swift
//  thermalCamera
//
//  Created by Stephanie Shore on 12/7/21.
//

import Foundation
struct therm_data: Codable {
    var isError: Bool?
    var message: String?
    var statusCode: Int?
    var data: [Float]?
}
