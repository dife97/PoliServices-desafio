import Foundation

class HomeViewModel: HomeViewModelProtocol {
    
    var providers: HomeViewModelProviders
    weak var delegate: HomeViewModelDelegate?
    weak var scheduledServiceDelegate: ScheduledServiceDelegate?
    
    init(providers: HomeViewModelProviders) {
        self.providers = providers
    }
    
    func getAboutUsDescription() {
        providers.aboutUs.getAboutUsDescription { description in
            delegate?.didGetAboutUs(descriptionText: description)
        }
    }
}

//MARK: - CurrentDate
extension HomeViewModel {
    
    func getCurrentDate() {
        providers.currentDate.getCurrentDate { [unowned self] currentDate in
            
            guard let currentDate else {
                self.delegate?.failedToGetCurrentDate()
                return
            }
            
            let currentDateString = "\(currentDate.day) de \(currentDate.month) de \(currentDate.year)"
            
            self.delegate?.didGet(currentDateString)
        }
    }
}

//MARK: - Countdown
extension HomeViewModel {
    
    func startTimer(duration: Double) {
        
        providers.countdown.start(duration: duration) { [weak self] in
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
                let poliServiceTimeInterval = UserDefaults.standard.double(forKey: PoliServiceKeys.timeIntervalSince1970.rawValue)
                let poliServiceDate = Date(timeIntervalSince1970: poliServiceTimeInterval)
                let timeLeftToDate = Int(poliServiceDate.timeIntervalSinceNow)
                var statusMessage: String
                
                switch timeLeftToDate {
                case ..<0:
                    statusMessage = "Em andamento"
                
                case 0...3600:
                    let leftTime = Int(timeLeftToDate / 60) + 1
                    
                    if leftTime == 1 {
                        statusMessage = "Falta \(leftTime) minuto para o atendimento"
                    } else {
                        statusMessage = "Faltam \(leftTime) minutos para o atendimento"
                    }
                    
                case 3600...12*60*60:
                    let hours = Int(timeLeftToDate / 3600)
                    let minutes = Int(timeLeftToDate) % 3600 / 60
                    
                    if minutes == 0 {
                        if hours == 1 {
                            statusMessage = "Falta \(hours) hora para o atendimento"
                            break
                        } else {
                            statusMessage = "Faltam \(hours) horas para o atendimento"
                            break
                        }
                    }
                    
                    if hours == 1 {
                        if minutes == 1 {
                            statusMessage = "Falta \(hours) hora e \(minutes) minuto para o atendimento"
                            break
                        } else {
                            statusMessage = "Falta \(hours) hora e \(minutes) minutos para o atendimento"
                            break
                        }
                    } else {
                        if minutes == 1 {
                            statusMessage = "Faltam \(hours) horas e \(minutes) minuto para o atendimento"
                            break
                        } else {
                            statusMessage = "Faltam \(hours) horas e \(minutes) minutos para o atendimento"
                            break
                        }
                    }
                    
                case 12*60*60...24*60*60:
                    statusMessage = "Falta menos de um dia para o atendimento"
                    
                default:
                    statusMessage = "Falta mais de um dia para o atendimento"
                }
                
                guard let serviceName = UserDefaults.standard.string(forKey: PoliServiceKeys.name.rawValue) else { return }
                guard let hexColor = UserDefaults.standard.string(forKey: PoliServiceKeys.color.rawValue) else { return }
                guard let icon = UserDefaults.standard.string(forKey: PoliServiceKeys.icon.rawValue) else { return }
                
                let serviceViewModel = PoliServiceViewModel(
                    name: serviceName,
                    date: poliServiceDate.toStandardString(),
                    statusMessage: statusMessage,
                    hexColor: hexColor,
                    icon: icon
                )
                
                let timeLeftToDeadline: Double = deadlineDate.timeIntervalSinceNow
                startTimer(duration: timeLeftToDeadline)
                
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
