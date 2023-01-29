protocol PoliServicesList {
    
    func getPoliServicesList(onComplete: @escaping (Result<PoliServiceModel, PSError>) -> Void)
}
