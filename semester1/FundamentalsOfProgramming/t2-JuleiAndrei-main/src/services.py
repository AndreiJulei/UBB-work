from src.repository import Repository

class Service:
    def __init__(self, repository: Repository):
        self.repository = repository

    def add_order(self, driver_id,km):
        """
        Calls the add function in the repository
        :param driver_id: driver id
        :param km: Kilometers
        :return: None
        """
        if not driver_id.isdigit():
            raise ValueError('driver_id must be a number')
        if not km.isdigit():
            raise ValueError('km must be a number')
        if int(km) <1:
            raise ValueError('km must be a greater than 1')
        list_of_drivers=self.repository.get_list_of_drivers()
        ok=False
        for driver in list_of_drivers:
            if int(driver_id) == driver.id():
                ok=True
        if not ok:
            raise ValueError('driver_id must be a valid')
        self.repository.add_order(int(driver_id),int( km))


    def get_list_of_drivers_services(self):
        """
        Calls the get_list_of_drivers function in the repository
        :return: None
        """
        return self.repository.get_list_of_drivers()

    def get_list_of_orders_service(self):
        """
        Calls the get_list_of_orders function in the repository
        :return: None
        """
        return self.repository.get_list_of_orders()

    def compute_services(self, driver_id):
        """
        Calculates the number of km of a driver
        :param driver_id: driver id
        :return: None
        """
        if not driver_id.isdigit():
            raise ValueError('driver_id must be a number')

        list_of_drivers = self.repository.get_list_of_drivers()
        list_of_orders = self.repository.get_list_of_orders()
        sum_of_km=0
        ok=False
        for driver in list_of_drivers:
            if int(driver_id) == driver.id():
                ok=True

        if not ok:
            raise ValueError("driver ID must be a valid")

        for order in list_of_orders:
            if order.driver_id() == int(driver_id):
                sum_of_km += int(order.kilometers())
        return sum_of_km
