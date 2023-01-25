protocol CurrentDateProviderProtocol {
    
    func getCurrentDate(with format: DateFormat,
                        onComplete: @escaping (String) -> Void)
}
