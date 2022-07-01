#!/usr/bin/env python3

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.                       #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    xx:00/xx.xx.2022                                                                   #
# Version:      1.8.1 > 1.8.2                                                                      #
####################################################################################################

# Path: /$HOME/.fusion360/bin/setup.py

###############################################################################################################################################################
# DESCRIPTION IN DETAIL                                                                                                                                       #
###############################################################################################################################################################
# With the help of my setup wizard, you will be given a way to install Autodesk Fusion 360 with some extensions on                                            #
# Linux so that you don't have to use Windows or macOS for this program in the future!                                                                        #
#                                                                                                                                                             #
# Also, my setup wizard will guides you through the installation step by step and will install some required packages.                                        #
#                                                                                                                                                             #
# The next one is you have the option of installing the program directly on your system or you can install it on an external storage medium.                  #
#                                                                                                                                                             #
# But it's important to know, you must to purchase the licenses directly from the manufacturer of Autodesk Fusion 360, when you will work with them on Linux! #
###############################################################################################################################################################

import tkinter as tk
from tkinter import ttk

###############################################################################################################################################################
# CREATE A WINDOW FOR THE SETUP WIZARD                                                                                                                        #
###############################################################################################################################################################

# Create this window:
window = tk.Tk()
window.title('Setup Wizard - Autodesk Fusion 360 for Linux')
window.configure(background='white')

# ----------------------------------------------------------------------------------------------- #

# Set the height and width of this window:
window_height = 450
window_width = 750

# Get the screen height and width values:
screen_width = window.winfo_screenwidth()
screen_height = window.winfo_screenheight()

# Write the formula for center this window:
x_cordinate = int((screen_width/2) - (window_width/2))
y_cordinate = int((screen_height/2) - (window_height/2))

# Set the geometry of this window:
window.geometry("{}x{}+{}+{}".format(window_width, window_height, x_cordinate, y_cordinate))

# ----------------------------------------------------------------------------------------------- #

# Set the theme settings for this window:
white = "#ffffff"
dark = "#222222"

notebook_style = ttk.Style()
notebook_style.theme_create( "theme_notebook_tabs", parent="alt", settings={
        "TNotebook": {"configure": {"tabmargins": [2, 5, 2, 0] } },
        "TNotebook.Tab": {
            "configure": {"padding": [5, 1], "background": white },
            "map":       {"background": [("selected", dark)], "foreground": [("selected", white)],
                          "expand": [("selected", [1, 1, 1, 0])] } } } )

notebook_style.theme_use("theme_notebook_tabs")

###############################################################################################################################################################
# CREATE A CONTAINER FOR THE NOTEBOOK-TABS                                                                                                                    #
###############################################################################################################################################################

# Create a Tkinter Notebook widget to create tabs in this window:
notebook = ttk.Notebook(window)
notebook.pack(pady=20,padx=20, expand=True)
ttk.Style().configure("TNotebook", background=white)

# ----------------------------------------------------------------------------------------------- #

# Configure the tabs:
notebook_tab1 = tk.Frame(notebook, width=700, height=400)
notebook_tab2 = tk.Frame(notebook, width=700, height=400)
notebook_tab3 = tk.Frame(notebook, width=700, height=400)
notebook_tab4 = tk.Frame(notebook, width=700, height=400)
notebook_tab5 = tk.Frame(notebook, width=700, height=400)
notebook_tab6 = tk.Frame(notebook, width=700, height=400)
notebook_tab7 = tk.Frame(notebook, width=700, height=400)

notebook_tab1.pack(fill='both', expand=True)
notebook_tab2.pack(fill='both', expand=True)
notebook_tab3.pack(fill='both', expand=True)
notebook_tab4.pack(fill='both', expand=True)
notebook_tab5.pack(fill='both', expand=True)
notebook_tab6.pack(fill='both', expand=True)
notebook_tab7.pack(fill='both', expand=True)

# Add the tabs to Notebook widget:
notebook.add(notebook_tab1, text='Welcome',)
notebook.add(notebook_tab2, text='Configuration')
notebook.add(notebook_tab3, text='Installation')
notebook.add(notebook_tab4, text='Plugins')
notebook.add(notebook_tab5, text='System Info')
notebook.add(notebook_tab6, text='About')
notebook.add(notebook_tab7, text='Help')

###############################################################################################################################################################
# ALL NOTEBOOK_TAB-1-FUNCTIONS ARE ARRANGED HERE:                                                                                                             #
###############################################################################################################################################################

# Create objects into the tab 1 (notebook)

frame1_photo = tk.PhotoImage(file='/home/steve/Vorlagen/welcome.png')
frame1_image_label = ttk.Label(notebook_tab1, image=frame1_photo)
frame1_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

textframe1 = tk.Frame(notebook_tab1)
textframe1.pack(padx=40)

frame1_title1 = tk.Label(textframe1, text="Welcome to the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
frame1_title1.pack(pady=20, anchor="w")

frame1_label1 = tk.Label(textframe1, text="Many thanks to you for deciding to use my setup wizard to be able to use Autodesk Fusion 360 on your computer.", wraplength=430, justify="left")
frame1_label1.pack(pady=5, anchor="w")

frame1_label2 = tk.Label(textframe1, text="This quick setup wizard will help you configure the basic settings and install the program. Furthermore, it is possible to install some tested plugins after the installation.", wraplength=430, justify="left")
frame1_label2.pack(pady=5, anchor="w")

frame1_label3 = tk.Label(textframe1, text="Depending on your current environment, setup may involve:", wraplength=430)
frame1_label3.pack(pady=5, anchor="w")

frame1_label4 = tk.Label(textframe1, text="- Checking your system for minimum installation requirements.", wraplength=430)
frame1_label4.pack(anchor="w")
frame1_label5 = tk.Label(textframe1, text="- It is recommended that you close all other applications before continuing.", wraplength=430)
frame1_label5.pack(anchor="w")

frame1_label6 = tk.Label(textframe1, text="Click Next to continue, or Cancel to exit the Setup Wizard.", wraplength=430)
frame1_label6.pack(pady=20, anchor="w")

buttonframe1 = tk.Frame(notebook_tab1)
buttonframe1.pack(padx=15, pady=15, side='bottom', anchor="e")

frame1_button1 = tk.Button(buttonframe1,text='< Back',width=10,height=1, underline=0, state=tk.DISABLED)
frame1_button1.grid(row=0, column=0, padx=5, pady=5)
frame1_button1.grid_rowconfigure(0, weight=1)
frame1_button2 = tk.Button(buttonframe1,text='Cancel',width=10,height=1, underline=0, command=lambda:window.quit())
frame1_button2.grid(row=0, column=1, padx=5, pady=5)
frame1_button3 = tk.Button(buttonframe1,text='Next >',width=10,height=1, underline=0, command=lambda:notebook.select(notebook_tab2))
frame1_button3.grid(row=0, column=2, padx=5, pady=5)
frame1_button4 = tk.Button(buttonframe1,text='Help',width=10,height=1, underline=0, command=lambda:notebook.select(notebook_tab7))
frame1_button4.grid(row=0, column=3, padx=5, pady=5)

# ----------------------------------------------------------------------------------------------- #

window.mainloop()
