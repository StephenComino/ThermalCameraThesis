//
//  timerModel.swift
//  thermalCamera
//
//  Created by Stephen Comino on 12/7/21.
//

import Foundation
struct therm_data: Codable {
    var isError: Bool?
    var message: String?
    var statusCode: Int?
    var data: [Float]?
}
