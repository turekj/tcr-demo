import Foundation

class URLSessionDataTaskSpy: URLSessionDataTask {

    var resumeCallCount = 0

    override func resume() {
        resumeCallCount += 1
    }
}
