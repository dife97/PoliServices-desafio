protocol HomeViewModelProtocol: ScheduledServiceProtocol {
    
    // MARK: - CurrentDate
    var currentDate: CurrentDateUseCaseProtocol { get }
    
    func getCurrentDate(onComplete: @escaping  (String) -> Void)
    
    // MARK: - Timer
    var customTimer: CustomTimerProtocol { get }

    func getDescriptionLabel(_ completion: (String) -> Void)

    func startTimer()
}


protocol ScheduledServiceProtocol {
    
    var scheduledServiceDelegate: ScheduledServiceDelegate? { get }
    
    func getScheduledService()
}

protocol ScheduledServiceDelegate: AnyObject {
    
    func didGetScheduledService(service: ServiceModel)
    
    func noScheduledService()
}
