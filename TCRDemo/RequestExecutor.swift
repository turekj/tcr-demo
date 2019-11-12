import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

class RequestExecutor: RequestExecuting {
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    // MARK: - RequestExecuting

    func get(url: URL, _ completion: @escaping (Data?) -> Void) {
        let task = session.dataTask(with: url) { data, response, _ in
            if let response = response, response.isSuccess {
                completion(data)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }

    private let session: URLSessionProtocol
}

extension URLResponse {

    var isSuccess: Bool {
        let statusCode = (self as? HTTPURLResponse)?.statusCode ?? 0
        return statusCode == 200
    }

}