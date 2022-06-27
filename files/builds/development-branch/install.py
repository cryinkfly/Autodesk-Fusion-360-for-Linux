from Tkinter import *
import Tkinter as tk					 
import ttk
import tkMessageBox
import os

root = tk.Tk()
root.title('Setup Wizard - Autodesk Fusion 360 for Linux')

# gets the requested values of the height and widht.
mywidth = 550
myheight = 450

# get screen height and width
scrwdth = root.winfo_screenwidth()
scrhgt = root.winfo_screenheight()

# write formula for center screen
xLeft = (scrwdth/2) - (mywidth/2)
yTop = (scrhgt/2) - (myheight/2)

# set geometry 
root.geometry(str(mywidth) + "x" + str(myheight) + "+" + str(xLeft) + "+" + str(yTop))

# create a notebook
notebook = ttk.Notebook(root)
notebook.pack(pady=20,padx=20, expand=True)

# create frames
frame1 = ttk.Frame(notebook, width=500, height=400)
frame2 = ttk.Frame(notebook, width=500, height=400)
frame3 = ttk.Frame(notebook, width=500, height=400)
frame4 = ttk.Frame(notebook, width=500, height=400)
frame5 = ttk.Frame(notebook, width=500, height=400)


frame1.pack(fill='both', expand=True)
frame2.pack(fill='both', expand=True)
frame3.pack(fill='both', expand=True)
frame4.pack(fill='both', expand=True)
frame5.pack(fill='both', expand=True)


# add frames to notebook
notebook.add(frame1, text='Welcome',)
notebook.add(frame2, text='Installation')
notebook.add(frame3, text='Settings')
notebook.add(frame4, text='Help')
notebook.add(frame5, text='About')

# create labels into the frames (notebook)
label1 = Label(frame1, text="Python is an easy language")
label1.pack()
label2 = Label(frame1, text="...")
label2.pack()

root.mainloop()
