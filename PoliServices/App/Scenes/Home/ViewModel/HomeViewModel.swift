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
        let deadline = UserDefaults.standard.double(forKey: PoliServiceKeys.duration.rawValue)

        if deadline != 0 {
            let deadlineDate = Date(timeIntervalSince1970: deadline)
            let hasService = deadlineDate >= Date()
            
            if hasService {
                guard let serviceName = UserDefaults.standard.string(forKey: PoliServiceKeys.name.rawValue) else { return }
                let poliServiceTimeInterval = UserDefaults.standard.double(forKey: PoliServiceKeys.timeIntervalSince1970.rawValue)
                let poliServiceDate = Date(timeIntervalSince1970: poliServiceTimeInterval)
                guard let hexColor = UserDefaults.standard.string(forKey: PoliServiceKeys.color.rawValue) else { return }
                
                let serviceViewModel = PoliServiceViewModel(
                    name: serviceName,
                    date: poliServiceDate.toStandardString(),
                    statusMessage: "Diego Lindo",
                    hexColor: hexColor
                )
                
                let timeLeft = deadlineDate.timeIntervalSinceNow
                startTimer(duration: timeLeft)
                
                scheduledServiceDelegate?.didGetScheduledService(service: serviceViewModel)
            } else {
                UserDefaults.standard.removeObject(forKey: PoliServiceKeys.name.rawValue)
                UserDefaults.standard.removeObject(forKey: PoliServiceKeys.duration.rawValue)
                UserDefaults.standard.removeObject(forKey: PoliServiceKeys.timeIntervalSince1970.rawValue)
                UserDefaults.standard.removeObject(forKey: PoliServiceKeys.color.rawValue)
                UserDefaults.standard.removeObject(forKey: PoliServiceKeys.icon.rawValue)
                
                scheduledServiceDelegate?.noScheduledService()
            }
        } else {
            scheduledServiceDelegate?.noScheduledService()
        }
    }
}
