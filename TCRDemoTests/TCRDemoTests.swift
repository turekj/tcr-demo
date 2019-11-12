import XCTest
import Foundation
@testable import TCRDemo

class TODOService {
    init(requestExecutor: RequestExecuting = RequestExecutor()) {
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

    private let requestExecutor: RequestExecuting
}

class TODOServiceTests: XCTestCase {

    func testFetchesTodos() {
        var todos = ""
        let todosFetched = expectation(description: "todos fetched")
        let executor = RequestExecutorSpy()
        executor.stubbedResponse = "delectus aut autem qui ullam ratione quibusdam voluptatem quia omnis"
        let sut = TODOService(requestExecutor: executor)

        sut.fetchTODOs {
            todos = $0
            todosFetched.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertTrue(todos.contains("delectus aut autem"))
        XCTAssertTrue(todos.contains("qui ullam ratione quibusdam voluptatem quia omnis"))
    }

}
