class database:
    def set_setting_map(self, dirty=False, **kwargs):
        task_detail = {'settingMap': ''}
        if dirty:
            task_detail['settingMap'] = {
                "speed": -1,
                "channel": 1,
                "record": kwargs['record'],
                "isSaveDirty": True,
                "lifeDay": 90,
                "tableName": kwargs['tableName']
            }
        else:
            task_detail['settingMap'] = {
                "speed": -1,
                "channel": 1,
                "record": 100,
                "isSaveDirty": False
            }
        return task_detail

kw = {'record': 100, 'tableName': 'fanshu'}
case = database().set_setting_map(dirty=True, **kw)
print(case)
