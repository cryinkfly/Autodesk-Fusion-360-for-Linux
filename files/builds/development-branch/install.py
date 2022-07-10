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
from tkinter.messagebox import askokcancel, showinfo, WARNING
import os

###############################################################################################################################################################
# CREATE A WINDOW FOR THE SETUP WIZARD HERE:                                                                                                                  #
###############################################################################################################################################################

# Set up the color:
white = "#ffffff"
dark = "#222222"

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

###############################################################################################################################################################
# CREATE A ROOT-CONTAINER FOR THE NOTEBOOK-TABS HERE:                                                                                                         #
###############################################################################################################################################################

notebook_style1 = ttk.Style()
notebook_style1.theme_create( "theme_notebook_tabs", parent="alt", settings={
        "TNotebook": {"configure": {"tabmargins": [2, 5, 2, 0] } },
        "TNotebook.Tab": {
            "configure": {"padding": [5, 1], "background": white },
            "map":       {"background": [("selected", dark)], "foreground": [("selected", white)],
                          "expand": [("selected", [1, 1, 1, 0])] } } } )

notebook_style1.theme_use("theme_notebook_tabs")

notebook_style1 = ttk.Style(window)
notebook_style1.configure('lefttab.TNotebook', background=white, tabposition='nw')
notebook1 = ttk.Notebook(window, style='lefttab.TNotebook')

# Configure the tabs:
notebook1_tab1 = tk.Frame(notebook1, width=700, height=400)
notebook1_tab2 = tk.Frame(notebook1, width=700, height=400)
notebook1_tab3 = tk.Frame(notebook1, width=700, height=400)
notebook1_tab4 = tk.Frame(notebook1, width=700, height=400)
notebook1_tab5 = tk.Frame(notebook1, width=700, height=400)
notebook1_tab6 = tk.Frame(notebook1, width=700, height=400)

# Add the tabs to Notebook widget:
notebook1.add(notebook1_tab1, text='Welcome',)
notebook1.add(notebook1_tab2, text='Installation')
notebook1.add(notebook1_tab3, text='Plugins')
notebook1.add(notebook1_tab4, text='System Info')
notebook1.add(notebook1_tab5, text='About')
notebook1.add(notebook1_tab6, text='Help')

notebook1.pack(pady=20,padx=20, expand=True)


###############################################################################################################################################################
# ALL NOTEBOOK_TAB-1-FUNCTIONS ARE ARRANGED HERE:                                                                                                             #
###############################################################################################################################################################

# Frame 1 - Left-Side:
notebook1_tab1_frame_photo = tk.PhotoImage(file='/home/steve/Vorlagen/welcome.png')
notebook1_tab1_frame_image_label = ttk.Label(notebook1_tab1, image=notebook1_tab1_frame_photo)
notebook1_tab1_frame_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

# ----------------------------------------------------------------------------------------------- #

# Frame 2 - Right-Side:
notebook1_tab1_frame_text = tk.Frame(notebook1_tab1)
notebook1_tab1_frame_text.pack(padx=40)

notebook1_tab1_frame_title = tk.Label(notebook1_tab1_frame_text, text="Welcome to the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
notebook1_tab1_frame_title.pack(pady=20, anchor="w")

notebook1_tab1_frame_label1 = tk.Label(notebook1_tab1_frame_text, text="Many thanks to you for deciding to use my setup wizard to be able to use Autodesk Fusion 360 on your computer.", wraplength=430, justify="left")
notebook1_tab1_frame_label1.pack(pady=5, anchor="w")
notebook1_tab1_frame_label2 = tk.Label(notebook1_tab1_frame_text, text="This quick setup wizard will help you configure the basic settings and install the program. Furthermore, it is possible to install some tested plugins after the installation.", wraplength=430, justify="left")
notebook1_tab1_frame_label2.pack(pady=5, anchor="w")
notebook1_tab1_frame_label3 = tk.Label(notebook1_tab1_frame_text, text="Depending on your current environment, setup may involve:", wraplength=430)
notebook1_tab1_frame_label3.pack(pady=5, anchor="w")
notebook1_tab1_frame_label4 = tk.Label(notebook1_tab1_frame_text, text="- Checking your system for minimum installation requirements.", wraplength=430)
notebook1_tab1_frame_label4.pack(anchor="w")
notebook1_tab1_frame_label5 = tk.Label(notebook1_tab1_frame_text, text="- It is recommended that you close all other applications before continuing.", wraplength=430)
notebook1_tab1_frame_label5.pack(anchor="w")
notebook1_tab1_frame_label6 = tk.Label(notebook1_tab1_frame_text, text="Click Next to continue, or Cancel to exit the Setup Wizard.", wraplength=430)
notebook1_tab1_frame_label6.pack(pady=20, anchor="w")

# ----------------------------------------------------------------------------------------------- #

# Frame 3 - Right-Side:
notebook1_tab1_frame_button = tk.Frame(notebook1_tab1)
notebook1_tab1_frame_button.pack(padx=15, pady=15, side='bottom', anchor="e")

notebook1_tab1_frame_button1 = tk.Button(notebook1_tab1_frame_button,text='< Back',width=6,height=1, underline=2, state=tk.DISABLED)
notebook1_tab1_frame_button1.grid(row=0, column=0, padx=5, pady=5)
notebook1_tab1_frame_button1.grid_rowconfigure(0, weight=1)
notebook1_tab1_frame_button2 = tk.Button(notebook1_tab1_frame_button,text='Cancel',width=6,height=1, underline=0, command=lambda:window.quit())
notebook1_tab1_frame_button2.grid(row=0, column=1, padx=5, pady=5)
notebook1_tab1_frame_button3 = tk.Button(notebook1_tab1_frame_button,text='Next >',width=6,height=1, underline=0, command=lambda:notebook.select(notebook_tab2))
notebook1_tab1_frame_button3.grid(row=0, column=2, padx=5, pady=5)
notebook1_tab1_frame_button4 = tk.Button(notebook1_tab1_frame_button,text='Help',width=6,height=1, underline=0, command=lambda:notebook.select(notebook_tab7))
notebook1_tab1_frame_button4.grid(row=0, column=3, padx=5, pady=5)

###############################################################################################################################################################
# CREATE A CONTAINER FOR THE NOTEBOOK-TAB2-TABS HERE:                                                                                                         #
###############################################################################################################################################################

notebook_style2 = ttk.Style(notebook1_tab2)
notebook_style2.configure('bottomtab.TNotebook', tabposition='se')

notebook2 = ttk.Notebook(notebook1_tab2, style='bottomtab.TNotebook')
notebook2_tab1 = tk.Frame(notebook2)
notebook2_tab2 = tk.Frame(notebook2)
notebook2_tab3 = tk.Frame(notebook2)
notebook2_tab4 = tk.Frame(notebook2)
notebook2.add(notebook2_tab1, text='1')
notebook2.add(notebook2_tab2, text='2')
notebook2.add(notebook2_tab3, text='3')
notebook2.add(notebook2_tab4, text='4')
notebook2.pack(expand=True)

###############################################################################################################################################################
# ALL NOTEBOOK_TAB-2-FUNCTIONS ARE ARRANGED HERE:                                                                                                             #
###############################################################################################################################################################

# Frame 1 - Left-Side:
notebook2_tab2_frame_photo = tk.PhotoImage(file='/home/steve/Vorlagen/welcome.png')
notebook2_tab2_frame_image_label = ttk.Label(notebook2_tab1, image=notebook2_tab2_frame_photo)
notebook2_tab2_frame_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

# ----------------------------------------------------------------------------------------------- #

# Frame 2 - Right-Side:
notebook2_tab2_frame_text = tk.Frame(notebook2_tab1)
notebook2_tab2_frame_text.pack(padx=40, anchor="w")

notebook2_tab2_frame_title = tk.Label(notebook2_tab2_frame_text, text="Welcome to the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
notebook2_tab2_frame_title = tk.Label(notebook2_tab2_frame_text, text="Configure the Autodesk Fusion 360 for Linux Setup Wizard", font=(24))
notebook2_tab2_frame_title.pack(pady=20, anchor="w")

notebook2_tab2_frame_label1 = tk.Label(notebook2_tab2_frame_text, text="In this step you can change some settings to apply your desired configuration of Autodesk Fusion 360 on your computer.", wraplength=430, justify="left")
notebook2_tab2_frame_label1.pack(pady=5, anchor="w")

# ----------------------------------------------------------------------------------------------- #

def setup_selected_linux_distro():
    if selected_linux_distro.get() == 'Arch Linux, Manjaro Linux, EndeavourOS, ...':
      showinfo(
        title='Configure - Linux Distro',
        message="Arch Linux, Manjaro Linux, EndeavourOS, ... will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Debian 10, MX Linux 19.4, Raspberry Pi Desktop, ...':
      showinfo(
        title='Configure - Linux Distro',
        message="Debian 10, MX Linux 19.4, Raspberry Pi Desktop, ... will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Debian 11':
      showinfo(
        title='Configure - Linux Distro',
        message="Debian 11 will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Fedora 35':
      showinfo(
        title='Configure - Linux Distro',
        message="Fedora 35 will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Fedora 36':
      showinfo(
        title='Configure - Linux Distro',
        message="Fedora 36 will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'openSUSE Leap 15.2':
      showinfo(
        title='Configure - Linux Distro',
        message="openSUSE Leap 15.2 will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'openSUSE Leap 15.3':
      showinfo(
        title='Configure - Linux Distro',
        message="openSUSE Leap 15.3 will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'openSUSE Tumbleweed':
      showinfo(
        title='Configure - Linux Distro',
        message="openSUSE Tumbleweed will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Red Hat Enterprise Linux 8.x':
      showinfo(
        title='Configure - Linux Distro',
        message="Red Hat Enterprise Linux 8.x will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Red Hat Enterprise Linux 9.x':
      showinfo(
        title='Configure - Linux Distro',
        message="Red Hat Enterprise Linux 9.x will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Solus':
      showinfo(
        title='Configure - Linux Distro',
        message="Solus will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Ubuntu 18.04, Linux Mint 19.x, ...':
      showinfo(
        title='Configure - Linux Distro',
        message="Ubuntu 18.04, Linux Mint 19.x, ... will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Ubuntu 20.04, Linux Mint 20.x, Pop!_OS 20.04, ...':
      showinfo(
        title='Configure - Linux Distro',
        message="Ubuntu 20.04, Linux Mint 20.x, Pop!_OS 20.04, ... will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Ubuntu 22.04, Pop!_OS 22.04, ...':
      showinfo(
        title='Configure - Linux Distro',
        message="Ubuntu 22.04, Pop!_OS 22.04, ... will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Void Linux':
      showinfo(
        title='Configure - Linux Distro',
        message="Void Linux will be set up ...")
      os.system("firefox")
    elif selected_linux_distro.get() == 'Gentoo Linux':
      showinfo(
        title='Configure - Linux Distro',
        message="Gentoo Linux will be set up ...")
      os.system("firefox")


def show_selected_linux_distro():
    MsgBox = tk.messagebox.askquestion ('Save Configuration','Do you want to continue with your settings?',icon = 'question')
    if MsgBox == 'yes':
       setup_selected_linux_distro()
    else:
        tk.messagebox.showinfo('Return Configuration','You will be returned to the settings and can change them again or Cancel the installation.')



# ----------------------------------------------------------------------------------------------- #

# Show a list of supported Linux Distro's
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

notebook2_tab2_frame_label2 = ttk.Label(notebook2_tab2_frame_text, text="1.) Select your installed Linux distro:")
notebook2_tab2_frame_label2.pack(fill='x', padx=5, pady=5)

notebook2_tab2_frame_combobox1 = ttk.Combobox(notebook2_tab2_frame_text, values=linux_distros, textvariable=selected_linux_distro, width=50)
notebook2_tab2_frame_combobox1.pack(fill='x', padx=15, pady=5)
notebook2_tab2_frame_combobox1.set('Arch Linux, Manjaro Linux, EndeavourOS, ...') # default selected option
notebook2_tab2_frame_combobox1['state'] = 'readonly'

# ----------------------------------------------------------------------------------------------- #

# Frame 3 - Right-Side:
notebook2_tab2_frame_button = tk.Frame(notebook2_tab1)
notebook2_tab2_frame_button.pack(padx=15, pady=15, side='bottom', anchor="e")

notebook2_tab2_frame_button1 = tk.Button(notebook2_tab2_frame_button,text='< Back',width=6,height=1, underline=2, command=lambda:notebook.select(notebook_tab1))
notebook2_tab2_frame_button1.grid(row=0, column=0, padx=5, pady=5)
notebook2_tab2_frame_button1.grid_rowconfigure(0, weight=1)
notebook2_tab2_frame_button2 = tk.Button(notebook2_tab2_frame_button,text='Cancel',width=6,height=1, underline=0, command=lambda:window.quit())
notebook2_tab2_frame_button2.grid(row=0, column=1, padx=5, pady=5)
notebook2_tab2_frame_button3 = tk.Button(notebook2_tab2_frame_button,text='Next >',width=6,height=1, underline=0, command=show_selected_linux_distro)
notebook2_tab2_frame_button3.grid(row=0, column=2, padx=5, pady=5)
notebook2_tab2_frame_button4 = tk.Button(notebook2_tab2_frame_button,text='Help',width=6,height=1, underline=0, command=lambda:notebook.select(notebook_tab7))
notebook2_tab2_frame_button4.grid(row=0, column=3, padx=5, pady=5)

window.mainloop()
