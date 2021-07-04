//
//  HomeViewController.swift
//  AirProximity
//
//  Created by Shaunak Jagtap on 05/07/21.
//

import UIKit
class HomeViewController: UIViewController {
   
    private var airQualityTableView: UITableView!
    private let airQualityViewModel = AirQualityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        airQualityViewModel.startAQIEvents()
        airQualityViewModel.aqiCallback = { [weak self] in
            self?.airQualityTableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    private func setupUI() {
        let barHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        title = Constants.homeVC
        airQualityTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        airQualityTableView.register(AQIndexTableViewCell.self, forCellReuseIdentifier: "AQIndexTableViewCell")
        airQualityTableView.dataSource = self
        airQualityTableView.delegate = self
        airQualityTableView.separatorColor = .clear
        airQualityTableView.backgroundColor = .black
        self.view.backgroundColor = .white
        self.view.addSubview(airQualityTableView)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(airQualityViewModel.airQualityData[indexPath.row])")
        
        let vc = AQIChartViewController()
        let viewModel = AQIChartViewModel()
        vc.viewModel = viewModel
        airQualityViewModel.aqiDelegate = viewModel
        airQualityViewModel.selectedCity = airQualityViewModel.airQualityData[indexPath.row].city
        viewModel.city = airQualityViewModel.selectedCity
        self.navigationController?.pushViewController(vc, animated: false)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airQualityViewModel.airQualityData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AQIndexTableViewCell", for: indexPath as IndexPath) as? AQIndexTableViewCell, airQualityViewModel.airQualityData.count > indexPath.row {
            cell.configureCell(data: airQualityViewModel.airQualityData[indexPath.row])
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

