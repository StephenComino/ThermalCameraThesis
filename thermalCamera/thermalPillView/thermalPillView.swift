//
//  thermalPillView.swift
//  thermalCamera
//
//  Created by Stephen Comino on 13/7/21.
//

import SwiftUI
let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
let Burgandy = Color(red: 0.39, green: 0.00, blue: 0.05)
let lightPink = Color(red: 1.00, green: 0.71, blue: 0.71)
let lightBlue = Color(red: 0.09, green: 0.97, blue: 0.97)
let oceanBrown = Color(red: 0.60, green: 0.47, blue: 0.00)
let darkGreen = Color(red: 0.20, green: 0.40, blue: 0.00)
let hotPink = Color(red: 1.00, green: 0.00, blue: 1.00)
let grayBlue = Color(red: 0.60, green: 0.60, blue: 1.00)
let orangeBrown = Color(red: 0.80, green: 0.40, blue: 0.00)
let darkBlue = Color(red: 0.00, green: 0.00, blue: 0.60)

struct thermalPillView: View {
    @EnvironmentObject var added_items : modularised_ui
    var body: some View {
        if (added_items.current_view == 0) {
            // Autumn
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 20, height: 125, alignment: .center)
            .background(Color.clear)
            .overlay(
                // Colors are Dependant on OpenCV Color Map
            LinearGradient(gradient: Gradient(colors: [lightBlue, .blue]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        } else if (added_items.current_view == 1) {
            //Bone
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                LinearGradient(gradient: Gradient(colors: [.white, .gray, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 2) {
            // JET
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    // Burgandy, .red, .organge, .yellow, .green, skyBlue, .blue
                    LinearGradient(gradient: Gradient(colors: [.blue, skyBlue, .green, .yellow, .orange, .red, Burgandy]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 3) {
            // Winter
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                LinearGradient(gradient: Gradient(colors: [.green, .red]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        } else if (added_items.current_view == 4) {
            // Rainbow
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.red, .green, .blue]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 5) {
            // OCean
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.white, oceanBrown, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 6) {
            // Summer
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                LinearGradient(gradient: Gradient(colors: [lightBlue, darkGreen]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 7) {
            // Spring
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                LinearGradient(gradient: Gradient(colors: [lightBlue, hotPink]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 8) {
            // Cool
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [hotPink, .yellow]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 9) {
            // HSV
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.purple, hotPink, .red, .yellow, .green, .blue]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 10) {
            // Pink
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.white, grayBlue, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 11) {
            // Hot
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.white, lightBlue, .blue, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 12) {
            // Parula
            // I am up to here!
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                LinearGradient(gradient: Gradient(colors: [lightBlue, .orange, orangeBrown]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 13) {
            // Magma
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.white, .blue, .purple, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 14) {
            // INferno
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                LinearGradient(gradient: Gradient(colors: [.white, .blue, .purple, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }  else if (added_items.current_view == 15) {
            // PLASMA
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [lightBlue, .pink, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        } else if (added_items.current_view == 16) {
            // VIRIDIS
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [lightBlue, orangeBrown, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        } else if (added_items.current_view == 17) {
            // CIVIDIS
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        } else if (added_items.current_view == 18) {
            // TWILIGHT
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.white, darkBlue, .orange, .black, .white]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        } else if (added_items.current_view == 19) {
            // TWILIGHT-SHIFTED
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    // DarkBlue, Light Gray, Burgandy
                    LinearGradient(gradient: Gradient(colors: [darkBlue, .white, .gray, Burgandy]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        } else if (added_items.current_view == 20) {
            // TURBO
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.blue, lightBlue, .green, .orange, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        } else {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 125, alignment: .center)
                .background(Color.clear)
                .overlay(
                    // Colors are Dependant on OpenCV Color Map
                    LinearGradient(gradient: Gradient(colors: [.white, .gray, .black]), startPoint: .top, endPoint: .bottom)).offset(x: 150)
        }
    }
}

struct thermalPillView_Previews: PreviewProvider {
    static var previews: some View {
        thermalPillView()
    }
}
