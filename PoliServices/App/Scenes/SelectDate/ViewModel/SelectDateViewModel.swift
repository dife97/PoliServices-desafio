import Foundation

class SelectDateViewModel: SelectDateViewModelProtocol {
    
    private let userDefaults = UserDefaults.standard
    
    var delegate: SelectDateViewDelegate?
    
    let serviceName: String
    let duration: Double
    
    init(
        serviceName: String,
        duration: Double
    ) {
        self.serviceName = serviceName
        self.duration = duration
    }
    
    func saveService(timeIntervalSince1970: Double) {
        
        let durationTimeInterval = timeIntervalSince1970 + duration * 60
        
        userDefaults.set(serviceName,
                         forKey: PoliServiceKeys.name.rawValue)
        
        userDefaults.set(durationTimeInterval,
                         forKey: PoliServiceKeys.duration.rawValue)
        
        userDefaults.set(timeIntervalSince1970,
                         forKey: PoliServiceKeys.timeIntervalSince1970.rawValue)
        
        delegate?.didSavePoliService()
    }
}
