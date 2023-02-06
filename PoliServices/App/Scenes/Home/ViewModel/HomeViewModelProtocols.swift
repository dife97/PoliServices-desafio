protocol HomeViewModelProtocol: ScheduledServiceProtocol {
    
    // MARK: - Delegate
    var delegate: HomeViewModelDelegate? { get }
    
    // MARK: - Providers
    var providers: HomeViewModelProviders { get }
    
    // MARK: - CurrentDate
    func getCurrentDate()
    
    // MARK: - Timer
    func startTimer(duration: Double)
    
    // MARK: - About Us Description
    func getAboutUsDescription()
}

protocol HomeViewModelDelegate: AnyObject {
    
    // MARK: - CurrentDate
    func didGet(_ currentDate: String)
    func failedToGetCurrentDate()
    
    // MARK: - About Us Description
    func didGetAboutUs(descriptionText: String)
}


protocol ScheduledServiceProtocol {
    
    var scheduledServiceDelegate: ScheduledServiceDelegate? { get }
    
    func checkScheduledPoliService()
}

protocol ScheduledServiceDelegate: AnyObject {
    
    func didGetScheduledService(service: PoliServiceViewModel)
    
    func noScheduledService()
}
