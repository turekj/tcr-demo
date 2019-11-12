import XCTest
import Foundation
@testable import TCRDemo

class RequestExecutor {
    init(session: URLSession = .shared) {
        self.session = session
    }

    func get(url: URL, _ completion: @escaping (Data?) -> Void) {
        let task = session.dataTask(with: url) { data, _, _ in
            completion(data)
        }

        task.resume()
    }

    private let session: URLSession
}

class TODOService {
    init(requestExecutor: RequestExecutor = RequestExecutor()) {
        self.requestExecutor = requestExecutor
    }

    func fetchTODOs(_ completion: @escaping (String) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!

        requestExecutor.get(url: url) { data in
            if let data = data, let result = String(data: data, encoding: .utf8) {
                completion(result)
            }
        }
    }

    private let requestExecutor: RequestExecutor
}

class TODOServiceTests: XCTestCase {

    func testFetchesTodos() {
        var todos = ""
        let todosFetched = expectation(description: "todos fetched")
        let sut = TODOService()

        sut.fetchTODOs {
            todos = $0
            todosFetched.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertTrue(todos.contains("delectus aut autem"))
        XCTAssertTrue(todos.contains("qui ullam ratione quibusdam voluptatem quia omnis"))
    }

}
