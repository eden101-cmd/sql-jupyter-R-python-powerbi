import PySimpleGUI as sg

label_1 = sg.Text("enter feet")
input_1 = sg.InputText(key = "feet")

label_2 = sg.Text("enter inches")
input_2 = sg.InputText(key = "inches")

convert_button = sg.Button("convert")
output_label = sg.Text("", key="output")

window = sg.Window("Convertor",layout = [[label_1,input_1],
                                               [label_2,input_2,],[convert_button,output_label]])

while True:
    event,values = window.read()
    feet = float(values["feet"])
    inches = float(values["inches"])

    result = feet*0.3048 + inches*0.0254
    window["output"].update(value=f"{result} m", text_color="white")

window.close()

# event,values = window.read()#ממיר למילון
