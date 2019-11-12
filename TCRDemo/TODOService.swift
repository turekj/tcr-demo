import Foundation

class TODOService {
    init(requestExecutor: RequestExecuting = RequestExecutor()) {
        self.requestExecutor = requestExecutor
    }

    func fetchTODOs(_ completion: @escaping ([TODO]) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!

        requestExecutor.get(url: url) { data in
            if let data = data, let todos = try? JSONDecoder().decode([TODO].self, from: data) {
                completion(todos)
            }
        }
    }

    private let requestExecutor: RequestExecuting
}
