import os

try:
    from flet import *
except ImportError:
    os.system("pip install flet")


###################### ZoneOne ######################
# Description: UI zone which coveres the text boxes #
#              and the logo in bottom left corner.  #
# Params:                                           #
#   - page: Reference to Flet page object           #
# Returns:                                          #
#   - Class reference                               #
#####################################################

class ZoneOne:

    def __init__(self, page) -> None:
        self.text_a = TextField(label="Patch A", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_b = TextField(label="Patch B", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_c = TextField(label="Patch C", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_d = TextField(label="Patch D", hint_text="Scan Order Number", height=100, border_color="red")
        self.logo = Image(src=f"{__location__}\\assets\\logo.png", width=300, height=175, fit=ImageFit.CONTAIN)
        self.page = page
        self.status_bubbles = []
        self.fill_bubble_arr()
        self.port_status_row_a = Row(
            [
                self.status_bubbles[0],
                Text("//1/1"),
                self.status_bubbles[1],
                Text("//1/2"),
                self.status_bubbles[2],
                Text("//1/3"),
                self.status_bubbles[3],
                Text("//1/4"),
                self.status_bubbles[4],
                Text("//1/5"),
                self.status_bubbles[5],
                Text("//1/6"),   
                self.status_bubbles[6],
                Text("//1/7"),
                self.status_bubbles[7],
                Text("//1/8"),
            ],
            spacing=5,
        )

        self.port_status_row_b = Row(
            [
                self.status_bubbles[8],
                Text("//1/1"),
                self.status_bubbles[9],
                Text("//1/2"),
                self.status_bubbles[10],
                Text("//1/3"),
                self.status_bubbles[11],
                Text("//1/4"),
                self.status_bubbles[12],
                Text("//1/5"),
                self.status_bubbles[13],
                Text("//1/6"),   
                self.status_bubbles[14],
                Text("//1/7"),
                self.status_bubbles[15],
                Text("//1/8"),
            ],
            spacing=5,
        )

        self.port_status_row_c = Row(
            [
                self.status_bubbles[16],
                Text("//1/1"),
                self.status_bubbles[17],
                Text("//1/2"),
                self.status_bubbles[18],
                Text("//1/3"),
                self.status_bubbles[19],
                Text("//1/4"),
                self.status_bubbles[20],
                Text("//1/5"),
                self.status_bubbles[21],
                Text("//1/6"),   
                self.status_bubbles[22],
                Text("//1/7"),
                self.status_bubbles[23],
                Text("//1/8"),
            ],
            spacing=5,
        )

        self.port_status_row_d = Row(
            [
                self.status_bubbles[24],
                Text("//1/1"),
                self.status_bubbles[25],
                Text("//1/2"),
                self.status_bubbles[26],
                Text("//1/3"),
                self.status_bubbles[27],
                Text("//1/4"),
                self.status_bubbles[28],
                Text("//1/5"),
                self.status_bubbles[29],
                Text("//1/6"),   
                self.status_bubbles[30],
                Text("//1/7"),
                self.status_bubbles[31],
                Text("//1/8"),
            ],
            spacing=5,
        )

    ##################### fill_bubble_array() #####################
    # Description:  The port status bubbles are identified using  #
    #               an array, where each port address corresponds #
    #               to an index in an array. The index for each   #
    #               is static, and set by the "spirent_ports"     #
    #               dictionary in dict.py.  We will read the port #
    #               as "//10.11.3.1/X/Y" which will map to an     #
    #               index which correspond to that object on the  #
    #               UI.                                           #
    # Params:                                                     #
    #   - None                                                    #
    # Returns:                                                    #
    #   - None                                                    #
    ###############################################################

    def fill_bubble_arr(self):
        for i in range(32):
            self.status_bubbles.append(Icon(name=icons.CIRCLE_OUTLINED, color=colors.BLACK, size=20))

    ######################## set_online() #########################
    # Description:  Turns the port green if it is online when the #
    #               function is called in file_rw().              #
    # Params:                                                     #
    #   - index:    value obtained from "spirent_ports" list that #
    #               maps port string to array index.              #
    # Returns:                                                    #
    #   - None                                                    #
    ###############################################################

    def set_online(self, index):
        self.status_bubbles[index].name = icons.CIRCLE_ROUNDED
        self.status_bubbles[index].color = colors.GREEN
        self.page.update()

    ######################## set_offline() #########################
    # Description:  Turns the port blank if it is offline when the #
    #               function is called in file_rw().               #
    # Params:                                                      #
    #   - index:    value obtained from "spirent_ports" list that  #
    #               maps port string to array index.               #
    # Returns:                                                     #
    #   - None                                                     #
    ################################################################

    def set_offline(self, index):
        self.status_bubbles[index].name = icons.CIRCLE_OUTLINED
        self.status_bubbles[index].color = colors.BLACK
        self.page.update()

    ########################## build_zone_1 ########################
    # Description:  Sets UI structure for all of ZoneOne, and      #
    #               assigns each element its corresponding function#
    # Params:                                                      #
    #   - None                                                     #
    # Returns:                                                     #
    #   - Column()                                                 #
    ################################################################

    def build_zone_1(self):
        return Column(
                [
                Container(
                    content=Column(
                      controls=[
                          self.port_status_row_a,
                          self.text_a,
                          self.port_status_row_b,
                          self.text_b,
                          self.port_status_row_c,
                          self.text_c,
                          self.port_status_row_d,
                          self.text_d,
                      ],
                      spacing=0,
                    ),
                    width=self.page.window_width/2,
                    height=self.page.window_height*0.65,
                    padding=padding.only(top=10),
                    # bgcolor="black",
                   ),
                Container(
                    content=Column(
                        controls=[
                            self.logo
                        ]
                    ),
                    width=self.page.window_width/3,
                    height=175,
                    alignment=alignment.top_left,
                    # bgcolor="red"
                )
                ],
                expand=True
                # wrap=True,
        )
 