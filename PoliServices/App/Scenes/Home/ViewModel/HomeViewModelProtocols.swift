protocol HomeViewModelProtocol: ScheduledServiceProtocol {
    
    // MARK: - Delegate
    var delegate: HomeViewModelDelegate? { get }
    
    // MARK: - CurrentDate
    var currentDate: CurrentDate { get }
    func getCurrentDate()
    
    // MARK: - Timer
    var customTimer: CustomTimerProtocol { get }

    func getDescriptionLabel(_ completion: (String) -> Void)

    func startTimer()
}

protocol HomeViewModelDelegate: AnyObject {
    
    // MARK: - CurrentDate
    func didGet(_ currentDate: String)
    func failedToGetCurrentDate()
}


protocol ScheduledServiceProtocol {
    
    var scheduledServiceDelegate: ScheduledServiceDelegate? { get }
    
    func getScheduledService()
}

protocol ScheduledServiceDelegate: AnyObject {
    
    func didGetScheduledService(service: ServiceModel)
    
    func noScheduledService()
}
