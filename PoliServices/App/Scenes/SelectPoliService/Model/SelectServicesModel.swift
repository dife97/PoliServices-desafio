import Foundation

struct SelectServicesModel: Codable {
    
    let success: Bool
    let data: ServicesModel
}

typealias ServicesModel = [ServiceResponseModel]

struct ServiceResponseModel: Codable {
    
    let id: Int
    let name, icon, color: String
    let duration: Int
}
