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
from tkinter.messagebox import showinfo

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

# Frame 1 - Left-Side:
notebook_tab1_frame_photo = tk.PhotoImage(file='/home/steve/Vorlagen/welcome.png')
notebook_tab1_frame_image_label = ttk.Label(notebook_tab1, image=notebook_tab1_frame_photo)
notebook_tab1_frame_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

# ----------------------------------------------------------------------------------------------- #

# Frame 2 - Right-Side:
notebook_tab1_frame_text = tk.Frame(notebook_tab1)
notebook_tab1_frame_text.pack(padx=40)

notebook_tab1_frame_title = tk.Label(notebook_tab1_frame_text, text="Welcome to the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
notebook_tab1_frame_title.pack(pady=20, anchor="w")

notebook_tab1_frame_label1 = tk.Label(notebook_tab1_frame_text, text="Many thanks to you for deciding to use my setup wizard to be able to use Autodesk Fusion 360 on your computer.", wraplength=430, justify="left")
notebook_tab1_frame_label1.pack(pady=5, anchor="w")
notebook_tab1_frame_label2 = tk.Label(notebook_tab1_frame_text, text="This quick setup wizard will help you configure the basic settings and install the program. Furthermore, it is possible to install some tested plugins after the installation.", wraplength=430, justify="left")
notebook_tab1_frame_label2.pack(pady=5, anchor="w")
notebook_tab1_frame_label3 = tk.Label(notebook_tab1_frame_text, text="Depending on your current environment, setup may involve:", wraplength=430)
notebook_tab1_frame_label3.pack(pady=5, anchor="w")
notebook_tab1_frame_label4 = tk.Label(notebook_tab1_frame_text, text="- Checking your system for minimum installation requirements.", wraplength=430)
notebook_tab1_frame_label4.pack(anchor="w")
notebook_tab1_frame_label5 = tk.Label(notebook_tab1_frame_text, text="- It is recommended that you close all other applications before continuing.", wraplength=430)
notebook_tab1_frame_label5.pack(anchor="w")
notebook_tab1_frame_label6 = tk.Label(notebook_tab1_frame_text, text="Click Next to continue, or Cancel to exit the Setup Wizard.", wraplength=430)
notebook_tab1_frame_label6.pack(pady=20, anchor="w")

# ----------------------------------------------------------------------------------------------- #

# Frame 3 - Right-Side:
notebook_tab1_frame_button = tk.Frame(notebook_tab1)
notebook_tab1_frame_button.pack(padx=15, pady=15, side='bottom', anchor="e")

notebook_tab1_frame_button1 = tk.Button(notebook_tab1_frame_button,text='< Back',width=6,height=1, underline=2, state=tk.DISABLED)
notebook_tab1_frame_button1.grid(row=0, column=0, padx=5, pady=5)
notebook_tab1_frame_button1.grid_rowconfigure(0, weight=1)
notebook_tab1_frame_button2 = tk.Button(notebook_tab1_frame_button,text='Cancel',width=6,height=1, underline=0, command=lambda:window.quit())
notebook_tab1_frame_button2.grid(row=0, column=1, padx=5, pady=5)
notebook_tab1_frame_button3 = tk.Button(notebook_tab1_frame_button,text='Next >',width=6,height=1, underline=0, command=lambda:notebook.select(notebook_tab2))
notebook_tab1_frame_button3.grid(row=0, column=2, padx=5, pady=5)
notebook_tab1_frame_button4 = tk.Button(notebook_tab1_frame_button,text='Help',width=6,height=1, underline=0, command=lambda:notebook.select(notebook_tab7))
notebook_tab1_frame_button4.grid(row=0, column=3, padx=5, pady=5)

###############################################################################################################################################################
# ALL NOTEBOOK_TAB-2-FUNCTIONS ARE ARRANGED HERE:                                                                                                             #
###############################################################################################################################################################

# Frame 1 - Left-Side:
notebook_tab2_frame_photo = tk.PhotoImage(file='/home/steve/Vorlagen/welcome.png')
notebook_tab2_frame_image_label = ttk.Label(notebook_tab2, image=notebook_tab2_frame_photo)
notebook_tab2_frame_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

# ----------------------------------------------------------------------------------------------- #

# Frame 2 - Right-Side:
notebook_tab2_frame_text = tk.Frame(notebook_tab2)
notebook_tab2_frame_text.pack(padx=40, anchor="w")

notebook_tab2_frame_title = tk.Label(notebook_tab2_frame_text, text="Welcome to the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
notebook_tab2_frame_title = tk.Label(notebook_tab2_frame_text, text="Configure the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
notebook_tab2_frame_title.pack(pady=20, anchor="w")

notebook_tab2_frame_label1 = tk.Label(notebook_tab2_frame_text, text="In this step you can change some settings to apply your desired configuration of Autodesk Fusion 360 on your computer.", wraplength=430, justify="left")
notebook_tab2_frame_label1.pack(pady=5, anchor="w")

# ----------------------------------------------------------------------------------------------- #

# Set up the correct Linux Distro:
def show_selected_linux_distro():
    showinfo(
        title='Result',
        message=selected_linux_distro.get()
    )

selected_linux_distro = tk.StringVar()
linux_distros = ['Arch Linux, Manjaro Linux, EndeavourOS, ...', 
'Debian 10, MX Linux 19.4, Raspberry Pi Desktop, ...', 
'Debian 11',
'Fedora 35', 
'Fedora 36', 
'openSUSE Leap 15.2',
'openSUSE Leap 15.3', 
'openSUSE Tumbleweed',
'Red Hat Enterprise Linux 8.x',
'Red Hat Enterprise Linux 9.x',  
'Solus', 
'Ubuntu 18.04, Linux Mint 19.x, ...',
'Ubuntu 20.04, Linux Mint 20.x, Pop!_OS 20.04, ...', 
'Ubuntu 22.04, Pop!_OS 22.04, ...',  
'Void Linux', 
'Gentoo Linux']

notebook_tab2_frame_label2 = ttk.Label(notebook_tab2_frame_text, text="1.) Select your installed Linux distro:")
notebook_tab2_frame_label2.pack(fill='x', padx=5, pady=5)

notebook_tab2_frame_combobox1 = ttk.Combobox(notebook_tab2_frame_text, values=linux_distros, textvariable=selected_linux_distro, width=50)
notebook_tab2_frame_combobox1.pack(fill='x', padx=15, pady=5)
notebook_tab2_frame_combobox1.set('Arch Linux, Manjaro Linux, EndeavourOS, ...') # default selected option
notebook_tab2_frame_combobox1['state'] = 'readonly'

# ----------------------------------------------------------------------------------------------- #

# Frame 3 - Right-Side:
notebook_tab2_frame_button = tk.Frame(notebook_tab2)
notebook_tab2_frame_button.pack(padx=15, pady=15, side='bottom', anchor="e")

notebook_tab2_frame_button1 = tk.Button(notebook_tab2_frame_button,text='< Back',width=6,height=1, underline=2, command=lambda:notebook.select(notebook_tab1))
notebook_tab2_frame_button1.grid(row=0, column=0, padx=5, pady=5)
notebook_tab2_frame_button1.grid_rowconfigure(0, weight=1)
notebook_tab2_frame_button2 = tk.Button(notebook_tab2_frame_button,text='Cancel',width=6,height=1, underline=0, command=lambda:window.quit())
notebook_tab2_frame_button2.grid(row=0, column=1, padx=5, pady=5)
notebook_tab2_frame_button3 = tk.Button(notebook_tab2_frame_button,text='Next >',width=6,height=1, underline=0, command=lambda:notebook.select(notebook_tab3))
notebook_tab2_frame_button3.grid(row=0, column=2, padx=5, pady=5)
notebook_tab2_frame_button4 = tk.Button(notebook_tab2_frame_button,text='Help',width=6,height=1, underline=0, command=lambda:notebook.select(notebook_tab7))
notebook_tab2_frame_button4.grid(row=0, column=3, padx=5, pady=5)

# ----------------------------------------------------------------------------------------------- #

window.mainloop()
