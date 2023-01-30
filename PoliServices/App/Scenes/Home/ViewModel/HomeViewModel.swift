import Foundation

class HomeViewModel: HomeViewModelProtocol {
    
    var currentDate: CurrentDate
    var timer: PSTimer = FoundationPSTimer()
    
    weak var delegate: HomeViewModelDelegate?
    weak var scheduledServiceDelegate: ScheduledServiceDelegate?
    
    
    init(
        currentDateProvider: CurrentDate,
        timerProvider: PSTimer
    ) {
        self.currentDate = currentDateProvider
        self.timer = timerProvider
    }
    
    func getDescriptionLabel(_ completion: (String) -> Void) {
        
        let descriptionText = DescriptionModel.description
        
        completion(descriptionText)
    }
    

}

//MARK: - CurrentDate
extension HomeViewModel {
    
    func getCurrentDate() {
        
        currentDate.getCurrentDate { [unowned self] currentDate in
            
            guard let currentDate else {
                self.delegate?.failedToGetCurrentDate()
                return
            }
            
            let currentDateString = "\(currentDate.day) de \(currentDate.month) de \(currentDate.year)"
            
            self.delegate?.didGet(currentDateString)
        }
    }
}

//MARK: - PSTimer
extension HomeViewModel {
    
    func startTimer(duration: Double) {

        timer.start(duration: duration) { [weak self] in
            
            guard let self = self else { return }
            self.checkScheduledPoliService()
        }
    }
}

extension HomeViewModel: ScheduledServiceProtocol {
    
    func checkScheduledPoliService() {
        
        // TODO: add an use case that know how to retrieve data from a local repository
        let poliServiceDateIntervalSince1970 = UserDefaults.standard.double(forKey: ServiceKeys.serviceDate.rawValue)
        
        if poliServiceDateIntervalSince1970 != 0 {
            
            let poliServiceDate = Date(timeIntervalSince1970: poliServiceDateIntervalSince1970)
            let hasService = poliServiceDate >= Date()
            
            if hasService {
                guard let serviceName = UserDefaults.standard.string(forKey: ServiceKeys.serviceName.rawValue) else { return }
                
                let serviceViewModel = PoliServiceViewModel(
                    name: serviceName,
                    date: poliServiceDate.toStandardString()
                )
                
                let timeLeft = poliServiceDate.timeIntervalSinceNow
                startTimer(duration: timeLeft)
                
                scheduledServiceDelegate?.didGetScheduledService(service: serviceViewModel)
            } else {
                UserDefaults.standard.removeObject(forKey: ServiceKeys.serviceDate.rawValue)
                UserDefaults.standard.removeObject(forKey: ServiceKeys.serviceName.rawValue)
                
                scheduledServiceDelegate?.noScheduledService()
            }
        } else {
            scheduledServiceDelegate?.noScheduledService()
        }
    }
}
