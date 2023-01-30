protocol HomeViewModelProtocol: ScheduledServiceProtocol {
    
    // MARK: - Delegate
    var delegate: HomeViewModelDelegate? { get }
    
    // MARK: - CurrentDate
    var currentDate: CurrentDate { get }
    func getCurrentDate()
    
    // MARK: - Timer
    var timer: PSTimer { get }
    func startTimer(duration: Double)
    
    // MARK: - Description Label
    func getDescriptionLabel(_ completion: (String) -> Void)
}

protocol HomeViewModelDelegate: AnyObject {
    
    // MARK: - CurrentDate
    func didGet(_ currentDate: String)
    func failedToGetCurrentDate()
}


protocol ScheduledServiceProtocol {
    
    var scheduledServiceDelegate: ScheduledServiceDelegate? { get }
    
    func checkScheduledPoliService()
}

protocol ScheduledServiceDelegate: AnyObject {
    
    func didGetScheduledService(service: PoliServiceViewModel)
    
    func noScheduledService()
}
