protocol Countdown {
    
    func start(duration: Double, action: @escaping () -> Void)
}
