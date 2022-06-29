from Tkinter import *
import Tkinter as tk					 
import ttk
import tkMessageBox
import webbrowser
import os

root = tk.Tk()
root.title('Setup Wizard - Autodesk Fusion 360 for Linux')
root.configure(background='white')

# Gets the requested values of the height and widht.

mywidth = 750
myheight = 450

# get screen height and width
scrwdth = root.winfo_screenwidth()
scrhgt = root.winfo_screenheight()

# write formula for center screen
xLeft = (scrwdth/2) - (mywidth/2)
yTop = (scrhgt/2) - (myheight/2)

# set geometry 
root.geometry(str(mywidth) + "x" + str(myheight) + "+" + str(xLeft) + "+" + str(yTop))


# ----------------------------------------------------------------------------------------------- #

# Define a callback function
def callback(url):
   webbrowser.open_new_tab(url)

# ----------------------------------------------------------------------------------------------- #

# Create an instance of ttk style
white = "#ffffff"
dark = "#222222"

style = ttk.Style()

style.theme_create( "theme_notebook_tabs", parent="alt", settings={
        "TNotebook": {"configure": {"tabmargins": [2, 5, 2, 0] } },
        "TNotebook.Tab": {
            "configure": {"padding": [5, 1], "background": white },
            "map":       {"background": [("selected", dark)], "foreground": [("selected", white)],
                          "expand": [("selected", [1, 1, 1, 0])] } } } )

style.theme_use("theme_notebook_tabs")

# ----------------------------------------------------------------------------------------------- #

# create a notebook
notebook = ttk.Notebook(root)
notebook.pack(pady=20,padx=20, expand=True)
ttk.Style().configure("TNotebook", background=white)

# create frames
frame1 = ttk.Frame(notebook, width=700, height=400)
frame2 = ttk.Frame(notebook, width=700, height=400)
frame3 = ttk.Frame(notebook, width=700, height=400)
frame4 = ttk.Frame(notebook, width=700, height=400)
frame5 = ttk.Frame(notebook, width=700, height=400)
frame6 = ttk.Frame(notebook, width=700, height=400)
frame7 = ttk.Frame(notebook, width=700, height=400)


frame1.pack(fill='both', expand=True)
frame2.pack(fill='both', expand=True)
frame3.pack(fill='both', expand=True)
frame4.pack(fill='both', expand=True)
frame5.pack(fill='both', expand=True)
frame6.pack(fill='both', expand=True)
frame7.pack(fill='both', expand=True)


# add frames to notebook
notebook.add(frame1, text='Welcome',)
notebook.add(frame2, text='Configuration')
notebook.add(frame3, text='Installation')
notebook.add(frame4, text='Plugins')
notebook.add(frame5, text='System Info')
notebook.add(frame6, text='About')
notebook.add(frame7, text='Help')

###############################################################################################################################################################
# ALL FRAME-1-FUNCTIONS ARE ARRANGED HERE:                                                                                                                    #
###############################################################################################################################################################

# Create objects into the frame 1 (notebook)

frame1_photo = tk.PhotoImage(file='/home/steve/Vorlagen/welcome.png')
frame1_image_label = ttk.Label(frame1, image=frame1_photo)
frame1_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

textframe1 = Frame(frame1)
textframe1.pack(padx=40)

frame1_title1 = Label(textframe1, text="Welcome to the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
frame1_title1.pack(pady=20, anchor="w")

frame1_label1 = Label(textframe1, text="Many thanks to you for deciding to use my setup wizard to be able to use Autodesk Fusion 360 on your computer.", wraplength=430, justify="left")
frame1_label1.pack(pady=5, anchor="w")

frame1_label2 = Label(textframe1, text="This quick setup wizard will help you configure the basic settings and install the program. Furthermore, it is possible to install some tested plugins after the installation.", wraplength=430, justify="left")
frame1_label2.pack(pady=5, anchor="w")

frame1_label3 = Label(textframe1, text="Depending on your current environment, setup may involve:", wraplength=430)
frame1_label3.pack(pady=5, anchor="w")

frame1_label4 = Label(textframe1, text="- Checking your system for minimum installation requirements.", wraplength=430)
frame1_label4.pack(anchor="w")
frame1_label5 = Label(textframe1, text="- It is recommended that you close all other applications before continuing.", wraplength=430)
frame1_label5.pack(anchor="w")

frame1_label6 = Label(textframe1, text="Click Next to continue, or Cancel to exit the Setup Wizard.", wraplength=430)
frame1_label6.pack(pady=20, anchor="w")


buttonframe1 = Frame(frame1)
buttonframe1.pack(padx=15, pady=15, side='bottom', anchor="e")

frame1_button1=Button(buttonframe1,text='< Back',width=10,height=1, underline=0, state=DISABLED)
frame1_button1.grid(row=0, column=0, padx=5, pady=5)
frame1_button1.grid_rowconfigure(0, weight=1)
frame1_button2=Button(buttonframe1,text='Cancel',width=10,height=1, underline=0, command=lambda:root.quit())
frame1_button2.grid(row=0, column=1, padx=5, pady=5)
frame1_button3=Button(buttonframe1,text='Next >',width=10,height=1, underline=0, command=lambda:notebook.select(frame2))
frame1_button3.grid(row=0, column=2, padx=5, pady=5)
frame1_button4=Button(buttonframe1,text='Help',width=10,height=1, underline=0, command=lambda:notebook.select(frame7))
frame1_button4.grid(row=0, column=3, padx=5, pady=5)

###############################################################################################################################################################
# ALL FRAME-2-FUNCTIONS ARE ARRANGED HERE:                                                                                                                    #
###############################################################################################################################################################

frame2_photo = tk.PhotoImage(file='/home/steve/Vorlagen/welcome.png')
frame2_image_label = ttk.Label(frame2, image=frame1_photo)
frame2_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

textframe2 = Frame(frame2)
textframe2.pack(padx=40)

frame2_title1 = Label(textframe2, text="Basic Configuration", font=(24))
frame2_title1.pack(pady=20, anchor="w")

buttonframe2 = Frame(frame2)
buttonframe2.pack(padx=15, pady=15, side='bottom', anchor="e")

frame2_button1=Button(buttonframe2,text='< Back',width=10,height=1, underline=0, command=lambda:notebook.select(frame1))
frame2_button1.grid(row=0, column=0, padx=5, pady=5)
frame2_button1.grid_rowconfigure(0, weight=1)
frame2_button2=Button(buttonframe2,text='Cancel',width=10,height=1, underline=0, command=lambda:root.quit())
frame2_button2.grid(row=0, column=1, padx=5, pady=5)
frame2_button3=Button(buttonframe2,text='Next >',width=10,height=1, underline=0, command=lambda:notebook.select(frame2))
frame2_button3.grid(row=0, column=2, padx=5, pady=5)
frame2_button4=Button(buttonframe2,text='Help',width=10,height=1, underline=0, command=lambda:notebook.select(frame7))
frame2_button4.grid(row=0, column=3, padx=5, pady=5)

root.mainloop()
