enum PSError: Error {
    case httpError(statusCode: Int)
    case networkError(message: String)
    case responseError
    case missingData
    case failedToCreateRequest
}
