//
//  AQIChartViewController.swift
//  AirProximity
//
//  Created by Shaunak Jagtap on 05/07/21.
//

import Foundation
import UIKit
import Charts

class AQIChartViewController : UIViewController {
    
    var viewModel = AQIChartViewModel()
    var lineChart = LineChartView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.updateChartCallabck = { [weak self] in
            self?.lineChartUpdate()
        }
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
        lineChartUpdate()
    }
    
    private func setupUI() {
        let barHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        title = viewModel.city
        self.view.addSubview(lineChart)
        lineChart.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        lineChart.backgroundColor = .white
    }
        
    @objc func lineChartUpdate() {
        let dataSet = LineChartDataSet(entries: viewModel.arrAQI)
        let data = LineChartData(dataSets: [dataSet])
        lineChart.data = data
        lineChart.chartDescription.text = "Updated Air Quality Index"
        lineChart.notifyDataSetChanged()
    }
}
