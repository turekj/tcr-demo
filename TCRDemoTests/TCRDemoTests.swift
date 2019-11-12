import XCTest
import Foundation
@testable import TCRDemo

func fetchTODOs(_ completion: @escaping (String) -> Void) {
    let url = "https://jsonplaceholder.typicode.com/todos"

    let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
        if let data = data, let result = String(data: data, encoding: .utf8) {
            completion(result)
        }
    }

    task.resume()
}

class TODOFetcherTests: XCTestCase {

    func testFetchesTodos() {
        var todos = ""
        let todosFetched = expectation(description: "todos fetched")

        fetchTODOs {
            todos = $0
            todosFetched.fulfill()
        }

        waitForExpectations(timeout: 5)
        XCTAssertTrue(todos.contains("delectus aut autem"))
        XCTAssertTrue(todos.contains("qui ullam ratione quibusdam voluptatem quia omnis"))
    }

}
