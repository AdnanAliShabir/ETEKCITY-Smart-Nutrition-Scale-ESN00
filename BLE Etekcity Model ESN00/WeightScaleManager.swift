import Foundation
import CoreBluetooth

protocol WeightScaleManagerDelegate: AnyObject {
    func didUpdateWeight(_ weight: Int)
    func didUpdateWeightConnectionStatus(_ isConnected: Bool)
}

class WeightScaleManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    weak var delegate: WeightScaleManagerDelegate?
    var isConnected: Bool = false
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        } else {
            // Handle Bluetooth not available
            print("======= Bluetooth not available ==========")
            isConnected = false
            delegate?.didUpdateWeightConnectionStatus(isConnected)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        let identifier = peripheral.identifier
        print("Discovered peripheral with identifier: \(identifier)")
        print("Discovered peripheral with name: \(peripheral.name ?? "")")
        print("-----------------------------------------------------------------------")
        if peripheral.name == "Etekcity Nutrition Scale" {
            centralManager.stopScan()
            peripheral.delegate = self  // Uncomment this line to set the delegate
            centralManager.connect(peripheral, options: nil)
            self.peripheral = peripheral
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnected = true
        self.peripheral?.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnected = false
    }
    
    func isWeightScaleConnected() -> Bool {
        return isConnected
    }
    func connectPeripheral(){
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        isConnected = true
    }
    func disconnectPeripheral() {
        if let peripheral = self.peripheral {
            centralManager.cancelPeripheralConnection(peripheral)
            isConnected = false
        }
    }
    
    // MARK: - CBPeripheralDelegate
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            print("No services found for peripheral \(peripheral.identifier)")
            return
        }
        
        print("Services for peripheral \(peripheral.identifier):")
        for service in services {
            print("- Service UUID: \(service.uuid)")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {
            print("No characteristics found for service \(service.uuid) on peripheral \(peripheral.identifier)")
            return
        }
        
        print("Characteristics for service \(service.uuid) on peripheral \(peripheral.identifier):")
        for characteristic in characteristics {
            print("- Characteristic UUID: \(characteristic.uuid)")
            
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
            }
            if characteristic.properties.contains(.notify) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Failed to write value to characteristic: \(error.localizedDescription)")
        } else {
            print("Successfully wrote value to characteristic.")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if characteristic.uuid == CBUUID(string: "2C12") {
            print("-----------------------------------------------------------------------")
            guard let data = characteristic.value else { return }
            if data.count == 12 {
                let weightData = data as NSData
                let flag = weightData.subdata(with: NSRange.init(location: 0, length: 1))
                let weight: UInt16 = readInteger(data: weightData as Data, start: 7)
                print("Weight = \(weight / 10) grams")
                let weightInGrams = Int(weight) / 10
                delegate?.didUpdateWeight(weightInGrams)
                delegate?.didUpdateWeightConnectionStatus(isConnected)
            }
        }
    }
    
    func readInteger(data: Data, start: Int) -> UInt16 {
        // Ensure that there is enough data starting from the specified index
        guard start + MemoryLayout<UInt16>.size <= data.count else {
            fatalError("Not enough data to read UInt16 at index \(start)")
        }
        // Extract the UInt16 value from the Data
        var value: UInt16 = 0
        (data as NSData).getBytes(&value, range: NSRange(location: start, length: MemoryLayout<UInt16>.size))
        
        // Convert from little-endian to host byte order if necessary
        return value.bigEndian
    }
}
