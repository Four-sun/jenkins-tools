# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/8/2 5:00 下午
# @Author : FanShu
# @Site : 
# @File : BtreeMap.py
# @Software: PyCharm
# Definition for a binary tree node.
# -*- coding: utf-8 -*-


class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

    def add_left(self, left_node):
        self.left = left_node

    def add_right(self, right_node):
        self.right = right_node


class Solution:
    def __init__(self):
        self.res = []

    def dfs(self, prefix, root):
        if root.left is None and root.right is None:
            self.res.append(prefix)
        else:
            if root.left is not None:
                self.dfs(prefix+'->'+str(root.left.val), root.left)
            if root.right is not None:
                self.dfs(prefix+'->'+str(root.right.val), root.right)

    def binaryTreePaths(self, root: TreeNode):
        if root is not None:
            self.dfs(str(root.val), root)
        return self.res


if __name__ == '__main__':
    tree = TreeNode(1)
    left_1 = TreeNode(2)
    right_2 = TreeNode(5)
    left_2 = TreeNode(4)
    right_1 = TreeNode(3)

    left_1.add_left(left_2)
    left_1.add_right(right_2)

    tree.add_left(left_1)
    tree.add_right(right_1)

    solu = Solution()
    res = solu.binaryTreePaths(tree)
    print(res)