class Driver:
    def __init__(self,id:int,name:str):
        self._id = id
        self._name = name

    def id(self):
        return self._id
    def name(self):
        return self._name

    def str(self):
        return f"{self._id}, {self._name}"

class Orders:
    def __init__(self,driver_id:int,kilometers:int):
        self._driver_id = driver_id
        self._kilometers = kilometers

    def driver_id(self):
        return self._driver_id

    def kilometers(self):
        return self._kilometers
    def str(self):
        return f"{self.driver_id()}, {self.kilometers()}"

