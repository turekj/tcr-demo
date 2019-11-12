import Foundation

protocol RequestExecuting {
    func get(url: URL, _ completion: @escaping (Data?) -> Void)
}
