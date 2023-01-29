protocol PoliServicesList {
    
    func getPoliServicesList(onComplete: @escaping (Result<PoliServices, PSError>) -> Void)
}
