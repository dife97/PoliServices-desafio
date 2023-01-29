protocol SelectServiceViewModelProtocol: AnyObject {
    
    
    // MARK: - PoliServices List
    var poliServicesList: PoliServicesList { get }
    func getPoliServicesList()
    
    
    
    var poliServices: PoliServices { get }
    var delegate: SelectPoliServiceViewDelegate? { get set }
    
}

protocol SelectPoliServiceViewDelegate: AnyObject {
    
    func didGetPoliServicesList()
    func failedToGetPoliServicesList()
}
