protocol SelectDateViewModelProtocol {
    
    var delegate: SelectDateViewDelegate? { get set }
    var poliService: PoliServiceModel { get }
    
    func saveService(timeIntervalSince1970: Double)
}

protocol SelectDateViewDelegate: AnyObject {
    
    func didSavePoliService()
}
