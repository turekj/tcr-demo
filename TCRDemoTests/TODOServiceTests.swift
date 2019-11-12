import XCTest
import Foundation
@testable import TCRDemo

class TODOServiceTests: XCTestCase {

    func testFetchesTodos() {
        var todos: [TODO] = []
        let todosFetched = expectation(description: "todos fetched")
        let executor = RequestExecutorSpy()
        executor.stubbedResponse = "todo_response.json".loadResource
        let sut = TODOService(requestExecutor: executor)

        sut.fetchTODOs {
            todos = $0
            todosFetched.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertEqual(200, todos.count)
        XCTAssertEqual(todos.first!.title, "delectus aut autem")
        XCTAssertEqual(todos.first!.id, 1)
        XCTAssertEqual(todos.last!.title, "ipsam aperiam voluptates qui")
        XCTAssertEqual(todos.last!.id, 200)
    }

}
