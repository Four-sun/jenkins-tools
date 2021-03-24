import time

id = [x for x in range(0, 10000)]
price = [x for x in range(20000, 30000)]
products = list(zip(id, price))


def find_product_price(products, product_id):
    for id, price in products:
        if id == product_id:
            return price
    return None

def find_unique_price_using_set(products):
    unique_list = set()
    for _, price in products:
        if price not in unique_list:
            unique_list.add(price)
    return len(unique_list)

def find_unique_price_using_list(products):
    unique_list = []
    for _, price in products:
        if price not in unique_list:
            unique_list.append(price)
    return len(unique_list)


start_time = time.perf_counter()
find_unique_price_using_list(products)
end_time = time.perf_counter()
print("time elapse using list: {}".format(end_time - start_time))


start_time_set = time.perf_counter()
find_unique_price_using_set(products)
end_time_set = time.perf_counter()
print("time elapse using set: {}".format(end_time_set - start_time_set))



# products = [
#     (143121312, 100),
#     (432314553, 30),
#     (32421912367, 150),
#     (324212367, 150)
# ]

# products = {
#     (143121312, 100),
#     (432314553, 30),
#     (32421912367, 150)
# }

# print('The price of product 432314553 is {}'.format(find_product_price(products, 432314553)))
# print('The price of product 432314553 is {}'.format(find_unique_price_using_list(products)))

# # 输出
# The
# price
# of
# product
# 432314553 is 30