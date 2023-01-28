protocol AvailablePoliServices {
    
    func get(onComplete: @escaping (Result<AvailablePoliServicesModel, Error>) -> Void)
}
