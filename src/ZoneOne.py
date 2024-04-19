from dict import *
import os

try:
    from flet import *
except ImportError:
    os.system("pip install flet")

__location__ = os.path.dirname(os.path.realpath(__file__))


###################### ZoneOne ######################
# Description: UI zone which coveres the text boxes #
#              and the logo in bottom left corner.  #
# Params:                                           #
#   - page: Reference to Flet page object           #
# Returns:                                          #
#   - Class reference                               #
#####################################################

class ZoneOne:

    def __init__(self, page, patch_letter) -> None:
        self.patch_letter = patch_letter
        self.text_a = TextField(label=f"Patch {self.patch_letter}", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_b = TextField(label=f"Patch {self.patch_letter}", hint_text="Scan Serial Number", height=100, border_color="red")
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
        for i in range(8):
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
                    content=Row(
                    [
                      Container(
                        content=Column(
                            controls=[
                                self.port_status_row_a,
                                self.text_a,
                                self.text_b,
                            ],
                            spacing=10,
                            expand=True,
                        ),
                    #   bgcolor="orange",
                      height=self.page.window_height*0.4,
                      width=self.page.window_width*0.45,
                      ),
                    ],
                    ),
                width=self.page.window_width/2,
                height=self.page.window_height*0.65,
                # padding=padding.only(top=100),
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
                expand=True,
                # wrap=True,
        )
 