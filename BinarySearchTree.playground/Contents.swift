print("-------------building a BST-------------")
var bst = BinarySearchTree<Int>()

for i in 0..<5 {
    bst.insert(i)
}
print(bst) // unbalanced Tree

print("-------------building a BST2-------------")
var bst2 = BinarySearchTree<Int>()
bst2.insert(3)
bst2.insert(1)
bst2.insert(4)
bst2.insert(0)
bst2.insert(2)
bst2.insert(5)
print(bst2)

print("-------------Finding a Node-------------")
if bst2.contains(5) {
    print("Found 5!")
} else {
    print("Couldn't find 5")
}

print("-------------Removing a Node-------------")
print("Tree before removal:")
print(bst2)
bst2.remove(3)
print("Tree after removing root:")
print(bst2)
