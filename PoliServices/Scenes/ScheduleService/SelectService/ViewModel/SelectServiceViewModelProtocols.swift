protocol SelectServiceViewModelProtocol: AnyObject, SelectServiceCreator {
    
    var serviceFetcher: ServiceFetcherProtocol { get }
    
    var services: ServicesModel { get }
    
    var delegate: SelectServiceViewDelegate? { get set }
    
    func getServices()
}

protocol SelectServiceViewDelegate: AnyObject {
    
    func didGetSelectServices()
    func failedToGetServicesDate()
}

protocol SelectServiceCreator {
    
    func createSelectService(name: String, systemImageName: SystemImageName, imageColor: CustomColor) -> SelectServicesModel
}

extension SelectServiceCreator {
    
    func createSelectService(name: String, systemImageName: SystemImageName, imageColor: CustomColor) -> SelectServicesModel {
        
//        let selectServiceModel = SelectServicesModel(name: name,
//                                                     systemImageName: systemImageName,
//                                                     imageColor: imageColor)
        
        let selectServiceModel = SelectServicesModel(success: true, data: [])
        
        return selectServiceModel
    }
}

