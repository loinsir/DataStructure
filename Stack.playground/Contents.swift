import Foundation

public struct Stack<T> {
    private var storage: [T] = []
    
    public init() { }
    
    public var isEmpty: Bool {
        return storage.isEmpty
    }
    
    public var count: Int {
        return storage.count
    }
    
    public mutating func push(_ element: T) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        storage.popLast()
    }
    
    public var top: T? {
        return storage.last
    }
}

extension Stack: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----top----
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        -----------
        """
    }
}

// Example

var stack = Stack<Int>()

stack.push(5)
stack.push(7)
stack.push(9)

print(stack)

if let poppedElement = stack.pop() {
    assert(9 == poppedElement)
    print("Popped: \(poppedElement)")
    print(stack.top)
}
