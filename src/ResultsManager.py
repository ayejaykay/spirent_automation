import json


'''
Ideally, we are using this library to send json data to a server where info from testing in the cell would be stored.  
We would want to have this server and database in order to track what is happening with testing in the cell for each unit
We have to ensure that this would not chew up too many resources however, and would need an easy way to access it.

For now we will write the json data simply to a file to save time and demonstrate the functionality
'''

class ResultsManager:

    def __init__(self):
        self.results_arr = []
        self.patch = ""
        self.shop_order = ""

    def transmit_data(self, results_arr, patch, shop_order):
        self.results_arr = results_arr
        self.patch = patch
        self.shop_order = shop_order[:shop_order.find('$')+3]

        json_data = self.build_json()
        self.send_to_server(json_data)
        self.clear_vars()

    def build_json(self):
        data = {}
        data["patch_tested"] =  self.patch
        data["shop_order"] = self.shop_order
        if self.results_arr == ["ALL TESTS PASSED"]:
            data["test_passed"] = True
        else:
            data["test_passed"] = False
        data["test_output"] = self.results_arr
        return json.dumps(data)

    def send_to_server(self, json_data):
        with open(f'..\\temp\\{self.shop_order}.json', 'w') as jsn:
            jsn.write(json_data)

    def clear_vars(self):
        self.results_arr = []
        self.patch = ""
        self.shop_order = ""
