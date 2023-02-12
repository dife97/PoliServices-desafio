import Foundation

class SelectDateViewModel: SelectDateViewModelProtocol {
    
    private let userDefaults = UserDefaults.standard
    var delegate: SelectDateViewDelegate?
    var poliService: PoliServiceModel
    var pushNotificationProvider: LocalPushNotification
    
    init(
        poliService: PoliServiceModel,
        pushNotificationProvider: LocalPushNotification
    ) {
        self.poliService = poliService
        self.pushNotificationProvider = pushNotificationProvider
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
        
        registerPushNotification(for: timeIntervalSince1970)
        
        delegate?.didSavePoliService()
    }
    
    func registerPushNotification(for timeIntervalSince1970: Double) {
        
        let title = "Hey, está quase na hora!"
        let body = "Faltam 15 minutos para o seu atendimento de \(poliService.name)"
        
        let pushNotification = PushNotificationModel(
            identifier: poliService.name,
            title: title,
            body: body,
            timeInterval: calculatePushNotificationTimeInterval(for: timeIntervalSince1970)
        )
        
        pushNotificationProvider.register(pushNotification)
    }
    
    func calculatePushNotificationTimeInterval(for timeIntervalSince1970: Double) -> Double {
        
        let fifteenMinutes: Double = 15 * 60
        let now = Date().timeIntervalSince1970
        let notificationTime = timeIntervalSince1970 - now - fifteenMinutes
        
        return notificationTime
    }
}
