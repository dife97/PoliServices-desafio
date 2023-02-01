enum PSError: Error {
    case httpError(statusCode: Int)
    case failedToGetHttpUrlResponse
    case networkError(message: String)
    case responseError
    case missingData
    case failedToDecodeData
    case failedToCreateRequest
}
