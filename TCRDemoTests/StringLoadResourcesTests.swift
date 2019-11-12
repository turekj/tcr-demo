import Foundation
import XCTest

extension String {
    var loadResource: String {
        let url = Bundle.testBundle.resourceURL?.appendingPathComponent(self)

        if let url = url, let data = try? Data(contentsOf: url), let text = String(data: data, encoding: .utf8) {
            return text
        }

        return ""
    }
}

extension Bundle {

    static var testBundle: Bundle {
        Bundle(for: StringLoadResourcesTests.self)
    }
}

class StringLoadResourcesTests: XCTestCase {

    func testCanLoadResources() {
        let resource = "todo_response.json".loadResource

        XCTAssertTrue(resource.contains("delectus aut autem"))
        XCTAssertTrue(resource.contains("qui ullam ratione quibusdam voluptatem quia omnis"))
    }

}
