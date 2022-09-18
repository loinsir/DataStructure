import Foundation

// Node Implementation

public class Node<T> {
    public var value: T
    public var next: Node?
    
    public init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next) + " "
    }
}

// Node example

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

print(node1)

// LinkedList Implementation

public struct LinkedList<T> {
    public var head: Node<T>?
    public var tail: Node<T>?
    
    public init() { }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public mutating func push(_ value: T) {
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: T) {
        copyNodes()
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail?.next = Node(value: value, next: nil)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<T>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult // lets callers ignore the return value of this method without the compiler jumping up and down warning you about it.
    public mutating func insert(_ value: T, after node: Node<T>) -> Node<T> {
        copyNodes()
        guard tail !== node else { // functionally equivalent append method.
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func pop() -> T? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> T? {
        copyNodes()
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next { // Keep searching for a next node until current.next is nil.
            prev = current
            current = next
        }
        
        prev.next = nil // disconnect
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<T>) -> T? {
        guard let node = copyNodes(returningCopyOf: node) else { return nil }
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

// example of inserting

var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)

print("Before inserting: \(list)")
var middleNode = list.node(at: 1)!
for _ in 1...4 {
    middleNode = list.insert(-1, after: middleNode)
}
print("After inserting: \(list)")

// example of popping.

var list2 = LinkedList<Int>()
list2.push(3)
list2.push(2)
list2.push(1)

print("Before popping list: \(list2)")
let poppedValue = list2.pop()
print("After popping list: \(list2)")
print("Popped value: " + String(describing: poppedValue))

// example of removing.

var list3 = LinkedList<Int>()
list3.push(3)
list3.push(2)
list3.push(1)

print("Before removing last node: \(list3)")
let removedValue = list3.removeLast()

print("After removing last node: \(list3)")
print("Removed value: " + String(describing: removedValue))

var list4 = LinkedList<Int>()
list4.push(3)
list4.push(2)
list4.push(1)

print("Before removing at particular index: \(list4)")
let index = 1
let node = list4.node(at: index - 1)!
let removedValue2 = list4.remove(after: node)

print("After removing at index \(index): \(list4)")
print("Removed value: " + String(describing: removedValue2))

extension LinkedList: Collection {
    
    public struct Index: Comparable {
        
        public var node: Node<T>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch(lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else { return false }
            
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
        
    }
    
    public var startIndex: Index {
        Index(node: head)
    }
    
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> T {
        position.node!.value
    }
    
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else { return } // Check whether or not the underlying node objects are shared. (값 복사가 이뤄졌는지 체크
        
        guard var oldNode = head else { return }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
    private mutating func copyNodes(returningCopyOf node: Node<T>?) -> Node<T>? {
        guard !isKnownUniquelyReferenced(&head) else { return nil } // Check whether or not the underlying node objects are shared. (값 복사가 이뤄졌는지 체크)
        
        guard var oldNode = head else { return nil }
        
        head = Node(value: oldNode.value)
        var newNode = head
        var nodeCopy: Node<T>?
        
        while let nextOldNode = oldNode.next {
            if oldNode === node {
                nodeCopy = newNode
            }
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        return nodeCopy
    }
}

var list5 = LinkedList<Int>()
for i in 0...9 {
    list5.append(i)
}

print("List: \(list5)")
print("First element: \(list5[list5.startIndex])")
print("Array containing first 3 elements: \(Array(list5.prefix(3)))")
print("Array containing last 3 elements: \(Array(list5.suffix(3)))")

let sum = list5.reduce(0, +)
print("Sum of all values: \(sum)")

// Value Semantics
var list6 = LinkedList<Int>()
list6.append(1)
list6.append(2)
var list7 = list6
print("List6: \(list6)")
print("List7: \(list7)")
// Unfortunately, linked list does not have value semantics. Because of Node. Node is Class.
print("After appending 3 to List7")
list7.append(3)
print("List6: \(list6)")
print("List7: \(list7)")

