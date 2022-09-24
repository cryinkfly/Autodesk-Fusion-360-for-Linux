#!/usr/bin/env python3

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.                       #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    xx:xx/xx.xx.2022                                                                   #
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

###############################################################################################################################################################
# IMPORT MODULE IN PYTHON FOR THE SETUP WIZARD HERE:                                                                                                          #
###############################################################################################################################################################

# Import in python is similar to #include header_file in C/C++. 
# Python modules can get access to code from another module by importing the file/function using import. 
# The import statement is the most common way of invoking the import machinery, but it is not the only way.

# The tkinter package (“Tk interface”) is the standard Python interface to the Tcl/Tk GUI toolkit.
import tkinter as tk

# The basic idea for tkinter.ttk is to separate, to the extent possible, the code implementing a widget’s behavior from the code implementing its appearance.
from tkinter import ttk

# The tkinter.messagebox module provides a template base class as well as a variety of convenience methods for commonly used configurations.
from tkinter.messagebox import askokcancel, showinfo, WARNING

# The ImageTk module contains support to create and modify Tkinter BitmapImage and PhotoImage objects from PIL images.
from PIL import Image, ImageTk

# The OS module in Python gives you access to some functions of the operating system.
import os

###############################################################################################################################################################
# SET UP THE COLOR SHEME FOR THE SETUP WIZARD HERE:                                                                                                           #
###############################################################################################################################################################

# Color Palette by SUSE Linux & openSUSE
# Link: https://brand.suse.com/brand-system/color-palette

color1 = "#FE7C3F" # Persimmon
color2 = "#0C322C" # Pine Green
color3 = "#EFEFEF" # Fog
color4 = "#30BA78" # Jungle Green

###############################################################################################################################################################
# SET UP HEIGHT AND WIDTH OF THE SETUP WIZARD WINDOW HERE:                                                                                                    #
###############################################################################################################################################################

window_height = 450
window_width = 750

###############################################################################################################################################################
# CREATE A WINDOW FOR THE SETUP WIZARD HERE:                                                                                                                  #
###############################################################################################################################################################

window = tk.Tk()
window.title('Setup Wizard - Autodesk Fusion 360 for Linux')
window.configure(bg=color1)
window.iconphoto(False, tk.PhotoImage(file='./images/fusion360.png'))

###############################################################################################################################################################
# CONFIGURE THE WINDOW OF THE SETUP WIZARD HERE:                                                                                                              #
###############################################################################################################################################################

# Get the screen height and width values:
screen_width = window.winfo_screenwidth()
screen_height = window.winfo_screenheight()

# Write the formula for center this window:
x_cordinate = int((screen_width/2) - (window_width/2))
y_cordinate = int((screen_height/2) - (window_height/2))

# Set the geometry of this window:
window.geometry("{}x{}+{}+{}".format(window_width, window_height, x_cordinate, y_cordinate))

###############################################################################################################################################################
# CREATE A COLOR SHEME FOR THE ROOT-CONTAINER OF THE NOTEBOOK-TABS HERE:                                                                                      #
###############################################################################################################################################################

notebook_style_root = ttk.Style()
notebook_style_root.theme_create( "theme_notebook_tabs_root", parent="alt", settings={
        "TNotebook": {"configure": {"tabmargins": [2, 5, 2, 0] } },
        "TNotebook.Tab": {
            "configure": {"padding": [5, 1], "background": color3 },
            "map":       {"background": [("selected", color2)], "foreground": [("selected", color3)],
                          "expand": [("selected", [1, 1, 1, 0])] } } } )

notebook_style_root.theme_use("theme_notebook_tabs_root")
notebook_style_root = ttk.Style(window)
notebook_style_root.configure('lefttab.TNotebook', background=color1, tabposition='nw')

###############################################################################################################################################################
# CREATE A ROOT-CONTAINER FOR THE NOTEBOOK-TABS HERE:                                                                                                         #
###############################################################################################################################################################

# The purpose of a Notebook widget is to provide an area where the user can select pages of content by clicking on tabs at the top of the area.
notebook_root = ttk.Notebook(window, style='lefttab.TNotebook')

# Configure the tabs:
notebook_root_tab1 = tk.Frame(notebook_root, width=700, height=400, bg=color3)
notebook_root_tab2 = tk.Frame(notebook_root, width=700, height=400, bg=color3)
notebook_root_tab3 = tk.Frame(notebook_root, width=700, height=400, bg=color3)
notebook_root_tab4 = tk.Frame(notebook_root, width=700, height=400, bg=color3)
notebook_root_tab5 = tk.Frame(notebook_root, width=700, height=400, bg=color3)
notebook_root_tab6 = tk.Frame(notebook_root, width=700, height=400, bg=color3)

# Add the tabs to Notebook widget:
notebook_root.add(notebook_root_tab1, text='Welcome')
notebook_root.add(notebook_root_tab2, text='Installation')
notebook_root.add(notebook_root_tab3, text='Plugins')
notebook_root.add(notebook_root_tab4, text='System Info')
notebook_root.add(notebook_root_tab5, text='About')
notebook_root.add(notebook_root_tab6, text='Help')
notebook_root.pack(pady=20,padx=20, expand=True)

###############################################################################################################################################################
# CREATE ELEMENTS INTO NOTEBOOK_ROOT_TAB1 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Frame 1 - Left-Side:
notebook_root_tab1_frame_photo = tk.PhotoImage(file='./images/welcome.png')
notebook_root_tab1_frame_image_label = ttk.Label(notebook_root_tab1, image=notebook_root_tab1_frame_photo)
notebook_root_tab1_frame_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

# ----------------------------------------------------------------------------------------------- #

# Frame 2 - Right-Side:
notebook_root_tab1_frame_text = tk.Frame(notebook_root_tab1, background=color3)
notebook_root_tab1_frame_text.pack(padx=40)
notebook_root_tab1_frame_title = tk.Label(notebook_root_tab1_frame_text, text="Welcome to the Autodesk Fusion 360 for Linux Setup Wizard", font=(24), background=color3, foreground=color2)
notebook_root_tab1_frame_title.pack(pady=20, anchor="w")
notebook_root_tab1_frame_label1 = tk.Label(notebook_root_tab1_frame_text, text="Many thanks to you for deciding to use my setup wizard to be able to use Autodesk Fusion 360 on your computer.", wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab1_frame_label1.pack(pady=5, anchor="w")
notebook_root_tab1_frame_label2 = tk.Label(notebook_root_tab1_frame_text, text="This quick setup wizard will help you configure the basic settings and install the program. Furthermore, it is possible to install some tested plugins after the installation.", wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab1_frame_label2.pack(pady=5, anchor="w")
notebook_root_tab1_frame_label3 = tk.Label(notebook_root_tab1_frame_text, text="Depending on your current environment, setup may involve:", wraplength=430, background=color3, foreground=color2)
notebook_root_tab1_frame_label3.pack(pady=5, anchor="w")
notebook_root_tab1_frame_label4 = tk.Label(notebook_root_tab1_frame_text, text="- Checking your system for minimum installation requirements.", wraplength=430, background=color3, foreground=color2)
notebook_root_tab1_frame_label4.pack(anchor="w")
notebook_root_tab1_frame_label5 = tk.Label(notebook_root_tab1_frame_text, text="- It is recommended that you close all other applications before continuing.", wraplength=430, background=color3, foreground=color2)
notebook_root_tab1_frame_label5.pack(anchor="w")
notebook_root_tab1_frame_label6 = tk.Label(notebook_root_tab1_frame_text, text="Click Next to continue, or Cancel to exit the Setup Wizard.", wraplength=430, background=color3, foreground=color2)
notebook_root_tab1_frame_label6.pack(pady=10, anchor="w")
notebook_root_tab1_frame_label7 = ttk.Label(notebook_root_tab1_frame_text, text="Select Language:", background=color3, foreground=color2)
notebook_root_tab1_frame_label7.pack(side='left', pady=5, padx=(0, 10))

# --------------------------------------------------- #

# This function changes the language settings:
def change_language(event):
 if selected_language.get() == 'Čeština':
   print("Čeština selected!")
 elif selected_language.get() == 'English':
   print("English selected!")
 elif selected_language.get() == 'Deutsch':
   print("Deutsch selected!")
 elif selected_language.get() == 'Español':
   print("Español selected!")
 elif selected_language.get() == 'Français':
   print("Français selected!")
 elif selected_language.get() == 'Italiano':
   print("Italiano selected!")
 elif selected_language.get() == '日本':
   print("日本 selected!")
 elif selected_language.get() == '한국인':
   print("한국인 selected!")
 elif selected_language.get() == '中国人':
   print("中国人 selected!")

# --------------------------------------------------- #

# Show a list of supported languages:
selected_language = tk.StringVar()
languages = ['Čeština',
'English', 
'Deutsch', 
'Español',
'Français',
'Italiano', 
'日本',
'한국인',
'中国人']

# --------------------------------------------------- #

combobox = ttk.Style()
combobox.configure("custom.TCombobox", fieldbackground=color3, background=color3, foreground=color2, selectforeground=color2, selectbackground=color3)

# --------------------------------------------------- #

notebook_root_tab1_frame_combobox1 = ttk.Combobox(notebook_root_tab1_frame_text, values=languages, textvariable=selected_language, width=8, justify='center', style="custom.TCombobox")
notebook_root_tab1_frame_combobox1.pack(side='left', fill='x')
notebook_root_tab1_frame_combobox1.set('English') # default selected option
notebook_root_tab1_frame_combobox1['state'] = 'readonly'
notebook_root_tab1_frame_combobox1.bind("<<ComboboxSelected>>", change_language)


# ----------------------------------------------------------------------------------------------- #

# Frame 3 - Right-Side:
notebook_root_tab1_frame_button_area = tk.Frame(notebook_root_tab1, background=color3)
notebook_root_tab1_frame_button_area.pack(padx=15, pady=15, side='bottom', anchor="e")
notebook_root_tab1_frame_button_back = tk.Button(notebook_root_tab1_frame_button_area,text='< Back',width=6,height=1, underline=2, state=tk.DISABLED, background=color2, foreground=color3)
notebook_root_tab1_frame_button_back.grid(row=0, column=0, padx=5, pady=5)
notebook_root_tab1_frame_button_back.grid_rowconfigure(0, weight=1)
notebook_root_tab1_frame_button_cancel = tk.Button(notebook_root_tab1_frame_button_area,text='Cancel',width=6,height=1, underline=0, command=lambda:window.quit(), background=color2, foreground=color3)
notebook_root_tab1_frame_button_cancel.grid(row=0, column=1, padx=5, pady=5)
notebook_root_tab1_frame_button_next = tk.Button(notebook_root_tab1_frame_button_area,text='Next >',width=6,height=1, underline=0, command=lambda:notebook_root.select(notebook_root_tab2), background=color2, foreground=color3)
notebook_root_tab1_frame_button_next.grid(row=0, column=2, padx=5, pady=5)
notebook_root_tab1_frame_button_help = tk.Button(notebook_root_tab1_frame_button_area,text='Help',width=6,height=1, underline=0, command=lambda:notebook_root.select(notebook_root_tab6), background=color2, foreground=color3)
notebook_root_tab1_frame_button_help.grid(row=0, column=3, padx=5, pady=5)

###############################################################################################################################################################
# CREATE ELEMENTS INTO NOTEBOOK_ROOT_TAB2 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Frame 1 - Left-Side:
notebook_root_tab2_frame_photo = tk.PhotoImage(file='./images/welcome.png')
notebook_root_tab2_frame_image_label = ttk.Label(notebook_root_tab2, image=notebook_root_tab2_frame_photo)
notebook_root_tab2_frame_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

# ----------------------------------------------------------------------------------------------- #

# Frame 2 - Right-Side:
notebook_root_tab2_frame_text = tk.Frame(notebook_root_tab2, background=color3)
notebook_root_tab2_frame_text.pack(padx=40, anchor="w")
notebook_root_tab2_frame_title = tk.Label(notebook_root_tab2_frame_text, text="Configure the Autodesk Fusion 360 for Linux Setup Wizard", font=(24), background=color3, foreground=color2)
notebook_root_tab2_frame_title.pack(pady=20, anchor="w")
notebook_root_tab2_frame_label1 = tk.Label(notebook_root_tab2_frame_text, text="In this step you can change some settings to apply your desired configuration of Autodesk Fusion 360 on your computer.", wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab2_frame_label1.pack(pady=5, anchor="w")

###############################################################################################################################################################
# CREATE ELEMENTS INTO NOTEBOOK_ROOT_TAB3 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Frame 1 - Left-Side:
notebook_root_tab3_frame_photo = tk.PhotoImage(file='./images/welcome.png')
notebook_root_tab3_frame_image_label = ttk.Label(notebook_root_tab3, image=notebook_root_tab3_frame_photo)
notebook_root_tab3_frame_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

# ----------------------------------------------------------------------------------------------- #

# Frame 2 - Right-Side:
notebook_root_tab3_frame_text = tk.Frame(notebook_root_tab3, background=color3)
notebook_root_tab3_frame_text.pack(padx=40, anchor="w")
notebook_root_tab3_frame_title = tk.Label(notebook_root_tab3_frame_text, text="Configure the plugins", font=(24), background=color3, foreground=color2)
notebook_root_tab3_frame_title.pack(pady=20, anchor="w")
notebook_root_tab3_frame_label1 = tk.Label(notebook_root_tab3_frame_text, text="In this step you can see a list of available and tested plugins for Autodesk Fusion 360. It is recommended if you want to add additional functionality to your workflow.", wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab3_frame_label1.pack(pady=5, anchor="w")

###############################################################################################################################################################
# CREATE ELEMENTS INTO NOTEBOOK_ROOT_TAB4 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Frame 1 - Left-Side:
notebook_root_tab4_frame_photo = tk.PhotoImage(file='./images/welcome.png')
notebook_root_tab4_frame_image_label = ttk.Label(notebook_root_tab4, image=notebook_root_tab4_frame_photo)
notebook_root_tab4_frame_image_label.pack(padx=20, pady=20, side='left', fill='both', expand=True)

# ----------------------------------------------------------------------------------------------- #

# Frame 2 - Right-Side:
notebook_root_tab4_frame_text = tk.Frame(notebook_root_tab4, background=color3)
notebook_root_tab4_frame_text.pack(padx=40, anchor="w")
notebook_root_tab4_frame_title = tk.Label(notebook_root_tab4_frame_text, text="System Information", font=(24), background=color3, foreground=color2)
notebook_root_tab4_frame_title.pack(pady=20, anchor="w")
notebook_root_tab4_frame_label1 = tk.Label(notebook_root_tab4_frame_text, text="In this step you can see a list of available and tested plugins for Autodesk Fusion 360. It is recommended if you want to add additional functionality to your workflow.", wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label1.pack(pady=5, anchor="w")

# ----------------------------------------------------------------------------------------------- #

system_hostname = os.uname()[1]

system_os = os.popen('source /etc/os-release && echo "$PRETTY_NAME"').read()

system_kernel = os.uname()[2]

system_cpu = os.popen('cat /proc/cpuinfo | grep "model name" | uniq | cut -d":" -f2-').read()

system_gpu = os.popen('glxinfo | grep "Device"').read()

system_shell = os.popen('echo $SHELL && $SHELL --version').read()

system_resolution = os.popen('').read()

system_de = os.popen('').read()

system_wm = os.popen('').read()

system_wm_theme = os.popen('s').read()

system_theme = os.popen('').read()

system_icons = os.popen('').read()



# ----------------------------------------------------------------------------------------------- #

notebook_root_tab4_frame_label2 = tk.Label(notebook_root_tab4_frame_text, text="Hostname: " + system_hostname, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label2.pack(anchor="w")
notebook_root_tab4_frame_label3 = tk.Label(notebook_root_tab4_frame_text, text="OS: " + str(system_os), wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label3.pack(anchor="w")
notebook_root_tab4_frame_label4 = tk.Label(notebook_root_tab4_frame_text, text="Kernel: " + system_kernel, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label4.pack(anchor="w")
notebook_root_tab4_frame_label5 = tk.Label(notebook_root_tab4_frame_text, text="CPU:" + system_cpu, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label5.pack(anchor="w")
notebook_root_tab4_frame_label6 = tk.Label(notebook_root_tab4_frame_text, text="GPU: " + system_gpu, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label6.pack(anchor="w")
notebook_root_tab4_frame_label7 = tk.Label(notebook_root_tab4_frame_text, text="Shell: " + system_shell, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label7.pack(anchor="w")
notebook_root_tab4_frame_label8 = tk.Label(notebook_root_tab4_frame_text, text="Resolution: " + system_resolution, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label8.pack(anchor="w")
notebook_root_tab4_frame_label9 = tk.Label(notebook_root_tab4_frame_text, text="DE: " + system_de, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label9.pack(anchor="w")
notebook_root_tab4_frame_label10 = tk.Label(notebook_root_tab4_frame_text, text="WM: " + system_wm, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label10.pack(anchor="w")
notebook_root_tab4_frame_label11 = tk.Label(notebook_root_tab4_frame_text, text="WM-Theme: " + system_wm_theme, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label11.pack(anchor="w")
notebook_root_tab4_frame_label12 = tk.Label(notebook_root_tab4_frame_text, text="Theme: " + system_theme, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label12.pack(anchor="w")
notebook_root_tab4_frame_label13 = tk.Label(notebook_root_tab4_frame_text, text="Icons: " + system_icons, wraplength=430, justify="left", background=color3, foreground=color2)
notebook_root_tab4_frame_label13.pack(anchor="w")




###############################################################################################################################################################
# CREATE A TKINTER MAINLOOP FOR THE SETUP WIZARD HERE:                                                                                                        #
###############################################################################################################################################################

# The method "mainloop" plays a vital role in Tkinter as it is a core application that waits for events and helps in updating the GUI or in simple terms, we can say it is event-driven programming.
# If no mainloop() is used then nothing will appear on the window Screen.
# This method takes all the objects that were created and have interactions response.

window.mainloop()
