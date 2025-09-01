from src.services import Service
from src.repository import Repository

class UI:
    def __init__(self,service: Service):
        self.service =service
        self.options={
            "1":self.add_order,
            "2":self.display_driver_info,
            "3" :self.compute
        }

    def compute(self):
        id_of_driver=input("Enter id of a driver: ")
        km=self.service.compute_services(id_of_driver)
        salary=km*2.5
        print(f"{id_of_driver}, {salary}")

    def add_order(self):
        id=input("Enter ID: ")
        kilometers=input("Enter kilometers: ")
        self.service.add_order(id,kilometers)


    def display_driver_info(self):
        list_of_drivers=self.service.get_list_of_drivers_services()
        list_of_orders=self.service.get_list_of_orders_service()
        for driver in list_of_drivers:
            print(f"driver {driver.str()} with orders: ")
            list_of_driver_order=[]
            ok=False
            for order in list_of_orders:
                if driver.id() == order.driver_id():
                    print(order.str())
                    ok=True
            if not ok:
                print("No orders")
    def print_options(self):
        print("1. Add an order")
        print("2. Display driver info")
        print("3. calculate salary")

    def run(self):
        while True:
            self.print_options()
            option = input("Choose an option: ")
            if option in self.options:
                try:
                    self.options[option]()
                except ValueError as ve:
                    print(ve)
            else: print("Invalid option")



def main():
    repository = Repository("driver.txt","orders.txt")

    if not repository.get_list_of_drivers():
        repository.generate_drivers()

    service = Service(repository)
    ui = UI(service)
    ui.run()

if __name__ == "__main__":
    main()