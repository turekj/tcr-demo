@testable import TCRDemo
import Foundation

class RequestExecutorSpy: RequestExecuting {
    var invokedGetWithURL: URL?
    var stubbedResponse: String?

    // MARK: - RequestExecuting

    func get(url: URL, _ completion: @escaping (Data?) -> Void) {
        invokedGetWithURL = url
        completion(stubbedResponse.flatMap { $0.data(using: .utf8) })
    }
}
