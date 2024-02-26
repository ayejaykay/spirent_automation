import os

try:
    from flet import *
except ImportError:
    os.system("pip install flet")


########################## ZoneTwo ###########################
# Description:  ZoneTwo holds the ListView object which      #
#               outputs status of testing to the user on the #
#               UI.                                          #
# Params:                                                    #
#   - page: reference to Flet page object                    #
# Returns:                                                   #
#   - class reference object                                 #
##############################################################

class ZoneTwo:

    def __init__(self, page) -> None:
        self.page = page
        self.lv = ListView(expand=1, spacing=10, auto_scroll=True)
        
    ######################### build_zone_2 #########################
    # Description:  Sets UI structure for all of ZoneTwo, and      #
    #               assigns each element its corresponding function#
    # Params                                                       #
    #   - None                                                     #
    # Returns                                                      #
    #   - Column()                                                 #
    ################################################################

    def build_zone_2(self):
        return Column(
                [
                Container(
                    content=Column(
                        [
                            Container(
                                content=Column(
                                    controls=[
                                        self.lv
                                    ],
                                ),
                                bgcolor=colors.GREY_100,
                                padding=10,
                                width=(self.page.window_width/2)*0.9,
                                height=(self.page.window_height*0.66), 
                                alignment=alignment.center,
                                border_radius=20,
                                # border=border.all(1, "red")
                                shadow=BoxShadow(
                                    spread_radius=1,
                                    blur_radius=15,
                                    color=colors.RED_100,
                                    blur_style=ShadowBlurStyle.OUTER
                                )
                            ),
                        ]
                    ),
                    width=self.page.window_width/2,
                    height=self.page.window_height*0.66,
                    alignment=alignment.center,
                    padding=padding.only(right=40, top=10),
                    #bgcolor="green"
                ), 
                ],
                # expand=True
        )

