import XCTest
import Foundation
@testable import TCRDemo

class RequestExecutorTests: XCTestCase {

    func testRequestExecutorPerformsSuccessfulGetRequest() {
        let session = URLSessionStub()
        let sut = RequestExecutor(session: session)

        let url = URL(string: "http://google.com")!
        var responseData: Data?

        sut.get(url: url) { data in
            responseData = data
        }

        let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)

        session.invokedDataTask?.1(Data("Hello world".utf8), urlResponse, nil)

        XCTAssertNotNil(session.invokedDataTask)
        XCTAssertNotNil(responseData)
        XCTAssertEqual(String(data: responseData!, encoding: .utf8), "Hello world")
        XCTAssertEqual(session.taskSpy.resumeCallCount, 1)
    }

    func testRequestExecutorChecksResponseStatusCode() {
        let session = URLSessionStub()
        let sut = RequestExecutor(session: session)

        let url = URL(string: "http://google.com")!
        var responseData: Data?

        sut.get(url: url) { data in
            responseData = data
        }

        let urlResponse = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)

        session.invokedDataTask?.1(Data("Hello world".utf8), urlResponse, nil)

        XCTAssertNotNil(session.invokedDataTask)
        XCTAssertNil(responseData)
        XCTAssertEqual(session.taskSpy.resumeCallCount, 1)
    }

}