import Foundation

protocol ApiRequestProtocol {

    var method: HTTPMethod { get }
    var endpoint: String { get }
    var body: Data? { get }
    var parameters: [String: Any]? { get }
}

extension ApiRequestProtocol {

    var baseURL: String { "https://9a1c098c-8f75-47ad-a938-ad3f9179490a.mock.pstmn.io/" }

    var url: URL? { URL(string: baseURL + endpoint) }
}

