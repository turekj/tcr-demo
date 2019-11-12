import Foundation
@testable import TCRDemo

class URLSessionStub: URLSessionProtocol {

    var invokedDataTask: (URL, (Data?, URLResponse?, Error?) -> Void)?
    var taskSpy = URLSessionDataTaskSpy()

    // MARK: - URLSessionProtocol

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        invokedDataTask = (url, completionHandler)

        return taskSpy
    }
}
