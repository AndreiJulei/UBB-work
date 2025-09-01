from src.domain import Driver
from src.domain import Orders
import random

class Repository:
    def __init__(self,drivers_file:str,order_file:str):
        """
        Initialise the repository
        :param drivers_file: File name
        :param order_file: file name
        """
        self.drivers_file = drivers_file
        self.order_file = order_file
        self.drivers = []
        self.order = []
        self.load_from_file_drivers()
        self.load_from_file_orders()

    def get_list_of_drivers(self):
        """
        Return list of drivers
        :return: List of drivers
        """
        return self.drivers

    def get_list_of_orders(self):
        """
        Return list of orders
        :return: list of orders
        """
        return self.order

    def load_from_file_drivers(self):
        """
        Loads drivers from file
        :return: None
        """
        try:
            with open(self.drivers_file, "r") as file:
                lines = file.readlines()
                for line in lines:
                    line = line.strip()
                    if line == "":
                        continue
                    id,name=line.split(",")
                    if not any(d == int(id) for d in self.get_list_of_drivers()):
                        self.add_driver(Driver(int(id),name))
        except FileNotFoundError:
            pass

    def load_from_file_orders(self):
        """
        Loads orders from file
        :return: None
        """
        try:
            with open(self.order_file, "r") as file:
                lines = file.readlines()
                for line in lines:
                    line = line.strip()
                    if line == "":
                        continue
                    id,km=line.split(",")
                    if not any(d.driver_id == int(id) for d in self.get_list_of_orders()):
                        self.add_order(int(id),int(km))
        except FileNotFoundError:
            pass

    def generate_drivers(self):
        """
        generates drivers
        :return: None
        """
        names=["Alex","Ion"]
        for name in names:
            id=random.randint(1,100)
            self.drivers.append(Driver(id,name))
            self.save_to_file_drivers()

    def add_driver(self,driver:Driver):
        """
        adds driver to repository
        :param driver:
        :return:
        """
        self.drivers.append(driver)
        self.save_to_file_drivers()

    def add_order(self,driver_id:int,kilometers:int):
        """
        adds order to repository
        :param driver_id: driver id
        :param kilometers: Kilometers
        :return: None
        """
        self.order.append(Orders(driver_id,kilometers))
        self.save_to_file_orders()

    def save_to_file_orders(self):
        """
        Saves orders to file
        :return: None
        """
        # Open the file in write mode and rewrite the contents
        with open(self.order_file, "w") as file:
            for order in self.get_list_of_orders():
                file.write(f"{order.driver_id()},{order.kilometers()}\n")

    def save_to_file_drivers(self):
        """
                Saves drivers to file
                :return: None
                """
        with open(self.drivers_file, "w") as file:
            for driver in self.get_list_of_drivers():
                file.write(f"{driver.id()},{driver.name()}\n")





