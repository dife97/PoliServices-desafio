protocol PSTimer {
    
    func start(duration: Double, action: @escaping () -> Void)
}
