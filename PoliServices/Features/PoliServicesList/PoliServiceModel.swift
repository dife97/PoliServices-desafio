struct PoliServiceModel: Codable {
    let name: String
    let icon: String
    let color: String
    let duration: Double
}

typealias PoliServices = [PoliServiceModel]

struct RemotePoliServiceModel: Codable {
    let success: Bool
    let data: [RemotePoliService]
}

struct RemotePoliService: Codable {
    let id: Int
    let name, icon, color: String
    let duration: Int
}
