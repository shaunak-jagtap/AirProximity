//
//  AQIChartViewModel.swift
//  AirProximity
//
//  Created by Shaunak Jagtap on 05/07/21.
//

import Foundation
import Charts

class AQIChartViewModel : AirQualityDelegate {
    var arrAQI = [ChartDataEntry]()
    var updateChartCallabck : AQICallback?
    var city = ""

    func updateAQIForCity(aqi: Double) {
        print("aqi : \(aqi)")
        let aqi1 = ChartDataEntry(x: Double(arrAQI.count), y: aqi)
        arrAQI.append(aqi1)
        DispatchQueue.main.async {
            self.updateChartCallabck?()
        }
    }
}
