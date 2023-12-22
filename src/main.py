from flet import *
from SpirentTester import *
from WindowManager import *
from ResultsManager import *
import os

__location__ = os.path.dirname(os.path.realpath(__file__))

class ZoneOne:

    def __init__(self, page) -> None:
        self.text_a = TextField(label="Patch A", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_b = TextField(label="Patch B", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_c = TextField(label="Patch C", hint_text="Scan Order Number", height=100, border_color="red")
        self.text_d = TextField(label="Patch D", hint_text="Scan Order Number", height=100, border_color="red")
        self.logo = Image(src=f"{__location__}\\assets\\logo.png", width=300, height=175, fit=ImageFit.CONTAIN)
        self.page = page

    def build_zone_1(self):
        return Column(
                [
                Container(
                    content=Column(
                      controls=[
                          self.text_a,
                          self.text_b,
                          self.text_c,
                          self.text_d,
                          Container(
                              content=Column(
                                  controls=[
                                      self.logo
                                  ]
                              ),
                              width=self.page.window_width/2,
                              height=175,
                              alignment=alignment.center_left,
                            #   bgcolor="red"
                          )
                      ],
                    ),
                    width=self.page.window_width/2,
                    height=self.page.window_height*0.85,
                    # bgcolor="black",
                   )
                ],

                wrap=True,
        )
    



class ZoneTwo:

    def __init__(self, page) -> None:
        self.page = page
        self.lv = ListView(expand=1, spacing=10, auto_scroll=True)
        

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
                ), 
                ],

        )
    
class ZoneThree:

    def __init__(self, page, classname, window) -> None:
        self.page = page
        self.window = window
        self.class_name = classname
        self.window_manager = WindowManager(self.window, self.page)
        self.spirent_tester = SpirentTester()
        self.results_manager = ResultsManager()
        self.test_btn =  ElevatedButton(
                            style=ButtonStyle(
                                bgcolor={
                                    MaterialState.HOVERED: colors.RED_200,
                                    MaterialState.FOCUSED: colors.RED_200,
                                    MaterialState.DEFAULT: colors.RED_50
                                },
                                color={
                                    MaterialState.DEFAULT: colors.RED
                                },
                                overlay_color={
                                    MaterialState.DEFAULT: colors.RED_200
                                },
                                elevation={
                                    "pressed": 0,
                                    "": 10,
                                }
                            ),
                            text="Start Spirent Test", 
                            width=300, 
                            height=100, 
                            on_click=self.btn_click,
                            # color="red", 
                            # bgcolor=colors.GREY_50
                        )

    def btn_click(self, e):
        var_arr = [self.class_name.text_a, self.class_name.text_b, self.class_name.text_c, self.class_name.text_d]
        valid_fields = []

        for i in var_arr:

            if i.value=="":
                pass
            else:
                valid_fields.append(i)

        self.test_btn.text="TESTING"

        self.page.update()
        arr = []
        for i in valid_fields:
            arr = self.spirent_tester.test_device(i.label, i.value, self.window_manager)
            for j in arr:
                self.window_manager.write_message_to_window(j)
            self.results_manager.transmit_data(arr, i.label, i.value)
            arr = []

        

        self.test_btn.text="Start Spirent Test"
        self.page.update()

    def build_zone_3(self):
        return Column(
                [
                Container(
                    content=Column(
                        [
                            Container(
                                content=Column(
                                    controls=[
                                        self.test_btn
                                    ]
                                ),
                                width=300,
                                height=100, 
                                # bgcolor="black",
                                alignment=alignment.center,
                                # padding=40
                            ),
                        ],
                    ),
                    width=self.page.window_width/2,
                    height=self.page.window_height*0.33,
                    # bgcolor="blue",
                    alignment=alignment.center,
                    padding=padding.only(right=20, top=30)
                ),
                ],

            wrap=True,
        )




def main(page: Page):
    page.title = "Spirent Automation"

    z1 = ZoneOne(page)
    z2 = ZoneTwo(page)
    z3 = ZoneThree(page, z1, z2.lv)
   
    page.add(
        Row(
        [
        z1.build_zone_1(),
        Column(
            [
            z2.build_zone_2(),
            z3.build_zone_3(),
            ]
        ),
        ],
        )
    )



    page.update()

if __name__ == "__main__":
    app(target=main)
