import Foundation

class SelectDateViewModel: SelectDateViewModelProtocol {
    
    private let userDefaults = UserDefaults.standard
    var delegate: SelectDateViewDelegate?
    var poliService: PoliServiceModel
    
    init(poliService: PoliServiceModel) {
        self.poliService = poliService
    }
    
    func saveService(timeIntervalSince1970: Double) {
        
        let durationTimeInterval = timeIntervalSince1970 + poliService.duration * 60
        
        // TODO: store Data using Codable object
        userDefaults.set(poliService.name,
                         forKey: PoliServiceKeys.name.rawValue)
        
        userDefaults.set(durationTimeInterval,
                         forKey: PoliServiceKeys.duration.rawValue)
        
        userDefaults.set(timeIntervalSince1970,
                         forKey: PoliServiceKeys.timeIntervalSince1970.rawValue)
        
        userDefaults.set(poliService.color,
                         forKey: PoliServiceKeys.color.rawValue)
        
        userDefaults.set(poliService.icon,
                         forKey: PoliServiceKeys.icon.rawValue)
        
        
        delegate?.didSavePoliService()
    }
}
