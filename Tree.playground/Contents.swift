import Foundation

let beverages = TreeNode("Beverages")

let hot = TreeNode("Hot")
let cold = TreeNode("Cold")
beverages.add(hot)
beverages.add(cold)

func makeBeverageTree() -> TreeNode<String> {
    let tree = TreeNode("Beverages")
    
    let hot = TreeNode("hot")
    let cold = TreeNode("cold")

    let tea = TreeNode("tea")
    let coffee = TreeNode("coffee")
    let chocolate = TreeNode("cocoa")
    let blackTea = TreeNode("black")
    let greenTea = TreeNode("green")
    let chaiTea = TreeNode("chai")
    let soda = TreeNode("soda")
    let milk = TreeNode("milk")
    let gingerAle = TreeNode("ginger ale")
    let bitterLemon = TreeNode("bitter lemon")
    
    tree.add(hot)
    tree.add(cold)
    
    hot.add(tea)
    hot.add(coffee)
    hot.add(chocolate)
    
    cold.add(soda)
    cold.add(milk)
    
    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)
    
    soda.add(gingerAle)
    soda.add(bitterLemon)
    return tree
}

print("--Example of: depth-first traversal--")
let tree = makeBeverageTree()
tree.forEachDepthFirst(visit: { print($0.value) } )

print("--Exmaple of: level-order traversal--")
tree.forEachLevelOrder { print($0.value) }


print("--Exmaple of: searching for a node--")
if let searchResult1 = tree.search("ginger ale") {
    print("Found node: \(searchResult1.value)")
}
if let searchResult2 = tree.search("WKD Blue") {
    print(searchResult2.value)
} else {
    print("Couldn't find WKD Blue")
}
