import Foundation

public protocol Queue {
    associatedtype T
    mutating func enqueue(_ element: T) -> Bool
    mutating func dequeue() -> T?
    var isEmpty: Bool { get }
    var peek: T? { get }
}
