//
//  AQIndexTableViewCell.swift
//  AirProximity
//
//  Created by Shaunak Jagtap on 05/07/21.
//

import UIKit

class AQIndexTableViewCell: UITableViewCell {
    var txtCityName = UILabel()
    var valueLbl = UILabel()
    var qualityValue = UILabel()
    var bgView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
        
    func configureCell(data: AirQualityElement) {
        setupUI()
        valueLbl.text = "AQI:" + String(format: "%.2f", data.aqi)
        let date = Date(timeIntervalSince1970: (Double(Date().currentTimeMillis()) / 1000.0))
        let airQuality = AirQualityGrade.getAirQualityFor(aqi: data.aqi)
        txtCityName.text = data.city + ": \(airQuality.getAirQualityLevel())"
        txtCityName.numberOfLines = 0
        qualityValue.text = "Updated \(Date().timeAgoSince(date))"
        bgView.layer.borderColor = airQuality.getLabelColor().cgColor
        valueLbl.textColor = airQuality.getLabelColor()
        txtCityName.textColor = airQuality.getLabelColor()
        qualityValue.textColor = airQuality.getLabelColor()
    }
    
    func setupUI() {
        
        txtCityName.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        valueLbl.font = UIFont(name:"Helvetica Neue", size: 14.0)
        qualityValue.font = UIFont(name:"Helvetica Neue", size: 14.0)
        
        bgView.backgroundColor = .black
        self.backgroundColor = .black
        bgView.layer.borderWidth = 2
        bgView.layer.cornerRadius = 8
        qualityValue.textAlignment = .right
        contentView.backgroundColor = .clear
        
        self.translatesAutoresizingMaskIntoConstraints = false
        txtCityName.translatesAutoresizingMaskIntoConstraints = false
        valueLbl.translatesAutoresizingMaskIntoConstraints = false
        qualityValue.translatesAutoresizingMaskIntoConstraints = false
        bgView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(bgView)
        bgView.addSubview(txtCityName)
        bgView.addSubview(valueLbl)
        bgView.addSubview(qualityValue)
        
        let views: [String: Any] = [
            "cityName": txtCityName,
            "valueLbl": valueLbl,
            "qualityValue": qualityValue,
            "bgView": bgView]
        
        var constraints: [NSLayoutConstraint] = []
        
        
        let nameLabelVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[cityName]-(>=5)-[valueLbl]-5-|",
            metrics: nil,
            views: views)
        constraints += nameLabelVerticalConstraints
        
        let countryLabelVerticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[cityName]-(>=5)-[qualityValue]-5-|",
            metrics: nil,
            views: views)
        constraints += countryLabelVerticalConstraint
        
        let topRowHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[cityName]-10-|",
            metrics: nil,
            views: views)
        constraints += topRowHorizontalConstraints
        
        let bottomRowHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[valueLbl]-10-[qualityValue]-10-|",
            metrics: nil,
            views: views)
        constraints += bottomRowHorizontalConstraints
        
        let bgViewVerticalConstraint = NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-10-[bgView]-10-|",
        metrics: nil,
        views: views)
        constraints += bgViewVerticalConstraint
        
        let bgViewHorizontalConstraint = NSLayoutConstraint.constraints(
        withVisualFormat: "H:|-10-[bgView]-10-|",
        metrics: nil,
        views: views)
        constraints += bgViewHorizontalConstraint
        
        NSLayoutConstraint.activate(constraints)
        
        valueLbl.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.horizontal)
        qualityValue.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
        
        qualityValue.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal);
    }

}


enum AirQualityGrade {
    case good, satisfactory, moderate, poor, veryPoor, severe
    
    static func getAirQualityFor(aqi : Double) -> AirQualityGrade {
        if aqi < 51 {
            return .good
        }
        else if aqi < 101 {
            return .satisfactory
        }
        else if aqi < 201 {
            return .moderate
        }
        else if aqi < 301 {
            return .poor
        }
        else if aqi < 401 {
            return .veryPoor
        }
        else {
            return .severe
        }
    }
    
    func getLabelColor() -> UIColor {
        switch self {
        case .good:
            return UIColor(red: 70.0/255.0, green: 155.0/255.0, blue: 62.0/255.0, alpha: 1.0)
        case .satisfactory:
            return UIColor(red: 148/255, green: 192/255, blue: 66/255, alpha: 1.0)
        case .moderate:
            return UIColor(red: 254/255, green: 250/255, blue: 40/255, alpha: 1.0)
        case .poor:
            return UIColor(red: 236/255, green: 138/255, blue: 40/255, alpha: 1.0)
        case .veryPoor:
            return UIColor(red: 225/255, green: 40/255, blue: 39/255, alpha: 1.0)
        case .severe:
            return UIColor(red: 157/255, green: 28/255, blue: 27/255, alpha: 1.0)
        }
    }
    
    func getAirQualityLevel() -> String {
        switch self {
        case .good:
            return "Good"
        case .satisfactory:
            return "Satisfactory"
        case .moderate:
            return "Moderate"
        case .poor:
            return "Poor"
        case .veryPoor:
            return "Very Poor"
        case .severe:
            return "Severe"
        }
    }
}

