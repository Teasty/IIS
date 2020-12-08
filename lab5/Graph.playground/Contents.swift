import XCTest

class IteratorRealWorld: XCTestCase {
    
    func test() {
        
        let tree = Tree(1)
        tree.left = Tree(2)
        tree.right = Tree(3)
        tree.left?.left = Tree(4)
        tree.left?.right = Tree(5)
        tree.right?.left = Tree(6)
        tree.right?.right = Tree(7)
        
        print("Tree traversal: DepthFirst")
        clientCode(iterator: tree.iterator(.DepthFirst))
        
        print("\nTree traversal: BreadthFirst")
        clientCode(iterator: tree.iterator(.BreadthFirst))
    }
    
    func clientCode<T>(iterator: AnyIterator<T>) {
        while case let item? = iterator.next() {
            print(item)
        }
    }
}

class Tree<T> {
    
    var value: T
    var left: Tree<T>?
    var right: Tree<T>?
    
    init(_ value: T) {
        self.value = value
    }
    
    typealias Block = (T) -> ()
    
    enum IterationType {
        case DepthFirst
        case BreadthFirst
    }
    
    func iterator(_ type: IterationType) -> AnyIterator<T> {
        var items = [T]()
        switch type {
        case .DepthFirst:
            depthFirst { items.append($0) }
        case .BreadthFirst:
            breadthFirst { items.append($0) }
        }
        return AnyIterator(items.makeIterator())
    }
    
    private func depthFirst(_ body: Block) {
        body(value)
        left?.depthFirst(body)
        right?.depthFirst(body)
    }
    
    private func breadthFirst(_ body: Block) {
        body(value)
        if let l = left?.value, let r = right?.value {
            body(l)
            body(r)
            left?.breadth(body)
            right?.breadth(body)
        }
    }
    
    private func breadth(_ body: Block) {
        if let l = left?.value, let r = right?.value {
            body(l)
            body(r)
            left?.breadth(body)
            right?.breadth(body)
        }
    }
}
let i = IteratorRealWorld()
i.test()
