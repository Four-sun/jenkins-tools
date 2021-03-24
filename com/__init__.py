class LargerNumKey(str):
    def __lt__(x, y):
        print(x + y > y + x)
        return x + y > y + x


class Solution:
    def largestNumber(self, nums):
        print(map(str, nums))
        print(sorted(map(str, nums), key=LargerNumKey))
        largest_num = ''.join(sorted(map(str, nums), key=LargerNumKey))
        return '0' if largest_num[0] == '0' else largest_num

case = Solution().largestNumber(nums=['0','9','2'])
print(case)
