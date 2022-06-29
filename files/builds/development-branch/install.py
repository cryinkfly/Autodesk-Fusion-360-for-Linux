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

# Create objects into the frames (notebook)
photo = tk.PhotoImage(file='/home/steve/Vorlagen/welcome.png')
image_label = ttk.Label(frame1, image=photo)
image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

textframe = Frame(frame1)
textframe.pack(padx=40)

title1 = Label(textframe, text="Welcome to the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
title1.pack(pady=20, anchor="w")

label1 = Label(textframe, text="Many thanks to you for deciding to use my setup wizard to be able to use Autodesk Fusion 360 on your computer. This quick setup wizard will help you configure the basic settings and install the program. Furthermore, it is possible to install some tested plugins after the installation.", wraplength=430, justify="left")
label1.pack(pady=5, anchor="w")

label2 = Label(textframe, text="Depending on your current environment, setup may involve:", wraplength=450)
label2.pack(pady=5, anchor="w")

label3 = Label(textframe, text="- Checking your system for minimum installation requirements.", wraplength=450)
label3.pack(anchor="w")
label4 = Label(textframe, text="- It is recommended that you close all other applications before continuing.", wraplength=450)
label4.pack(anchor="w")

label5 = Label(textframe, text="Click Next to continue, or Cancel to exit the Setup Wizard.", wraplength=450)
label5.pack(pady=20, anchor="w")

buttonframe = Frame(frame1)
buttonframe.pack(padx=15, pady=15, side='bottom', anchor="e")

button1=Button(buttonframe,text='< Back',width=10,height=1, underline=0, state=DISABLED)
button1.grid(row=0, column=0, padx=5, pady=5)
button1.grid_rowconfigure(0, weight=1)
button2=Button(buttonframe,text='Cancel',width=10,height=1, underline=0, command=lambda:root.quit())
button2.grid(row=0, column=1, padx=5, pady=5)
button3=Button(buttonframe,text='Next >',width=10,height=1, underline=0, command=lambda:notebook.select(frame2))
button3.grid(row=0, column=2, padx=5, pady=5)
button4=Button(buttonframe,text='Help',width=10,height=1, underline=0, command=lambda:notebook.select(frame7))
button4.grid(row=0, column=3, padx=5, pady=5)

root.mainloop()
