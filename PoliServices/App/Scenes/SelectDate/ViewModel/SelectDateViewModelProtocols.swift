protocol SelectDateViewModelProtocol {
    
    var delegate: SelectDateViewDelegate? { get set }
    var serviceName: String { get }
    
    func saveService(timeIntervalSince1970: Double)
}

protocol SelectDateViewDelegate: AnyObject {
    
    func didSavePoliService()
}
