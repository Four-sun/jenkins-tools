from pyhive import hive
from pyhive.exc import OperationalError


class Hive_Course1:

    def __init__(self, db_name='case_00'):
        self.conn = hive.connect(host='172.16.100.213', port='10000', database=db_name)
        self.cursor = self.conn.cursor()

    def create_table(self):
        sql = 'show tables'
        # sql = 'CREATE TABLE IF NOT EXISTS case_00.employee(eid int,name String,salary String,destination String)'
        try:
            self.cursor.execute(sql)
        except OperationalError as err:
            print(err)
            return False
        else:
            result = self.cursor.fetchall()
            return result


if __name__ == '__main__':
    hive1 = Hive_Course1().create_table()
    print(hive1)
    print(len(hive1))
