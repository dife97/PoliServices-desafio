class CurrentDateUseCase: CurrentDateUseCaseProtocol {
    
    var currentDateProviders: CurrentDateProviderProtocol
    
    init(currentDateProviders: CurrentDateProviderProtocol) {
        self.currentDateProviders = currentDateProviders
    }
    
    func getCurrentDate(with format: DateFormat,
                        onComplete: @escaping (String) -> Void) {
        
        currentDateProviders.getCurrentDate(with: format) { currentDate in
            
            onComplete(currentDate)
        }
    }
}
