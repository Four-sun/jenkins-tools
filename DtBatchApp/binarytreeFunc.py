# !/usr/bin/env python
# --- coding: utf-8 ---
# @Time : 2021/8/2 7:18 下午
# @Author : FanShu
# @Site : 
# @File : binarytreeFunc.py
# @Software: PyCharm

from binarytree import tree, bst, heap


class TreeNode:
    def __init__(self, val, left=None, right=None):
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

    def reverseTaskList(self, res, task):
        if res is not None:
            reverse_list = []
            tree_res = self.binaryTreePaths(res)
            for i in range(len(tree_res)):
                b = tree_res[i].split('->')
                res_list = []
                for j in range(len(b)):
                    res_list.append(task[int(b[j])])
                reverse_list.append(res_list)
            return reverse_list


my_tree = tree(height=2, is_perfect=True)
print(my_tree)
# solu = Solution()
# res_bst = solu.binaryTreePaths(my_tree)
# print(res_bst)

my_bst = bst(height=2, is_perfect=True)

my_heap = heap(height=5, is_max=True, is_perfect=False)
# print(my_tree)
# print(my_tree.inorder)

task_list = [9517, 9519, 9521, 9523, 9525, 9527, 9531]

solu = Solution()
res_bst = solu.reverseTaskList(my_bst, task_list)
print(res_bst)

