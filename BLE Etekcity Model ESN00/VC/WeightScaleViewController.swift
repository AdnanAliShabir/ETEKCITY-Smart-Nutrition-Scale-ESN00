//
//  ListViewController.swift
//  BLE Etekcity Model ESN00
//
//  Created by Development on 23/01/2024.
//

import UIKit
import CoreBluetooth

class WeightScaleViewController: UIViewController {
    
    @IBOutlet weak var BLEBtn: UIButton!
    @IBOutlet weak var WeightLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    var weightScaleManager: WeightScaleManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weightScaleManager = WeightScaleManager()
        weightScaleManager.delegate = self
        updateButtonImage(weightScaleManager.isConnected)
    }
    
    @IBAction func onClickBLEBtn(_ sender: Any) {
        if !weightScaleManager.isWeightScaleConnected() {
            weightScaleManager.connectPeripheral()
        } else {
            weightScaleManager.disconnectPeripheral()
        }
        updateButtonImage(weightScaleManager.isConnected)
        status()
    }
    
    func status() {
        statusLbl.text = weightScaleManager.isConnected ? "Connected!" : "Disconnected!"
    }
    
    func updateButtonImage(_ isConnected: Bool) {
        let imageName = weightScaleManager.isConnected ? "Connected_BLE" : "Disconnected_BLE"
        BLEBtn.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension WeightScaleViewController: WeightScaleManagerDelegate {
    func didUpdateWeight(_ weight: Int) {
        // Handle the updated weight in your view controller
        print("Received weight update: \(weight)")
        WeightLbl.text = "\(weight) g"
    }
    
    func didUpdateWeightConnectionStatus(_ isConnected: Bool) {
        updateButtonImage(isConnected)
        status()
    }
}
