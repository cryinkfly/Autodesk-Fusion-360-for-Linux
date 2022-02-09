#!/usr/bin/env python3

####################################################################################################
# Name:         Autodesk Fusion 360 - Speechtoolkit (Linux & Windows)                              #
# Description:  With this file you can controll Autodesk Fusion 360 via voice assistant.           #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    10:15/09.02.2022                                                                   #
# Version:      0.0.1                                                                              #
####################################################################################################

import argparse
import os
import queue
import sounddevice as sd
import vosk
import sys
import json
import subprocess


q = queue.Queue()

def int_or_str(text):
    """Helper function for argument parsing."""
    try:
        return int(text)
    except ValueError:
        return text

def callback(indata, frames, time, status):
    """This is called (from a separate thread) for each audio block."""
    if status:
        print(status, file=sys.stderr)
    q.put(bytes(indata))

parser = argparse.ArgumentParser(add_help=False)
parser.add_argument(
    '-l', '--list-devices', action='store_true',
    help='show list of audio devices and exit')
args, remaining = parser.parse_known_args()
if args.list_devices:
    print(sd.query_devices())
    parser.exit(0)
parser = argparse.ArgumentParser(
    description=__doc__,
    formatter_class=argparse.RawDescriptionHelpFormatter,
    parents=[parser])
parser.add_argument(
    '-f', '--filename', type=str, metavar='FILENAME',
    help='audio file to store recording to')
parser.add_argument(
    '-m', '--model', type=str, metavar='MODEL_PATH',
    help='Path to the model')
parser.add_argument(
    '-d', '--device', type=int_or_str,
    help='input device (numeric ID or substring)')
parser.add_argument(
    '-r', '--samplerate', type=int, help='sampling rate')
args = parser.parse_args(remaining)

try:
    if args.model is None:
        args.model = "model"
    if not os.path.exists(args.model):
        print ("Please download a model for your language from https://alphacephei.com/vosk/models")
        print ("and unpack as 'model' in the current folder.")
        parser.exit(0)
    if args.samplerate is None:
        device_info = sd.query_devices(args.device, 'input')
        # soundfile expects an int, sounddevice provides a float:
        args.samplerate = int(device_info['default_samplerate'])

    model = vosk.Model(args.model)

    if args.filename:
        dump_fn = open(args.filename, "wb")
    else:
        dump_fn = None

    with sd.RawInputStream(samplerate=args.samplerate, blocksize = 8000, device=args.device, dtype='int16', channels=1, callback=callback):
            print('#' * 80)
            print('Press Ctrl+C to stop the recording')
            print('#' * 80)

            rec = vosk.KaldiRecognizer(model, args.samplerate)
            while True:
                data = q.get()
                if rec.AcceptWaveform(data):

                    # Get JSON
                    vc = json.loads(rec.Result())

					# Here you get more informations about the shortcut configuration in Autodesk Fusion 360: 
					# - https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-F0491540-0324-470A-B651-2238D0EFAC30
					# - https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-E8541F92-A2DA-4CBF-A708-5374679B3F35

                    # --------------------------------------------------------------------------------------------------------------------------
                    # Controll Autodesk Fusion 360 via voice assistant - Shortcuts:
                    # --------------------------------------------------------------------------------------------------------------------------
                    
                    # System Keyboard Shortcuts:
                                       
                    if vc['text'] == "fusion new project":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+n"])
                        # Command: File > New Design
                    if vc['text'] == "fusion open project":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+o"])
                        # Command: File > Open
                    if vc['text'] == "fusion save project":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+s"])
                        # Command: File > Save (Version)
                    if vc['text'] == "fusion recovery save project":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+shift+s"])
                        # Command: Recovery Save
                    if vc['text'] == "fusion new tab":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+tab"])
                        # Command: Cycle open document tabs
                    if vc['text'] == "fusion refresh data panel":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "F5"])
                        # Command: Refresh data panel
                    
                    # --------------------------------------------------------------------------------------------------------------------------
                    
                    # General Keyboard Shortcuts:
                                       
                    if vc['text'] == "fusion four view ports":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "shift+1"])
                        # Command: Display 4 viewports
                    if vc['text'] == "fusion for view ports":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "shift+1"])
                        # Command: Display 4 viewports
                    if vc['text'] == "fusion visual style four":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+4"])
                        # Command: Visual Styles (Shaded)
                    if vc['text'] == "fusion visual style for":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+4"])
                        # Command: Visual Styles (Shaded)
                    if vc['text'] == "fusion visual style five":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+5"])
                        # Command: Visual Styles (Shaded with hidden edges)
                    if vc['text'] == "fusion visual style six":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+6"])
                        # Command: Visual Styles (Shaded with visible edges only)
                    if vc['text'] == "fusion visual style seven":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+7"])
                        # Command: Visual Styles (Wireframe)
                    if vc['text'] == "fusion visual style eight":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+8"])
                        # Command: Visual Styles (Wireframe with hidden edges)
                    if vc['text'] == "fusion visual style nine":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+9"])
                        # Command: Visual Styles (Wireframe with visible edges only)
                    if vc['text'] == "fusion fullscreen":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+shift+f"])
                        # Command: Full-screen mode
                    if vc['text'] == "fusion view cube":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+alt+v"])
                        # Command: Show/hide ViewCube
                    if vc['text'] == "fusion view browser":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+alt+b"])
                        # Command: Show/hide browser
                    if vc['text'] == "fusion view activity":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+alt+a"])
                        # Command: Show/hide activity
                    if vc['text'] == "fusion view terminal":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+alt+c"])
                        # Command: Show/hide text commands (Terminal)
                    if vc['text'] == "fusion view toolbar":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+shift+w"])
                        # Command: Show/hide toolbar
                    if vc['text'] == "fusion view navigation bar":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+alt+n"])
                        # Command: Show/hide navigation bar
                    if vc['text'] == "fusion view data panel":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+alt+p"])
                        # Command: Show/hide data panel
                    if vc['text'] == "fusion view reset":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+alt+r"])
                        # Command: Reset to default layout
                    if vc['text'] == "fusion toolbox":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "s"])
                        # Command: Toolbox (Current workspace) | For examble: Design Workspace, Sketch Environment, ...
                    
                    # --------------------------------------------------------------------------------------------------------------------------
                    
                    # Cube Keyboard Shortcuts:
                    
                    if vc['text'] == "fusion cube home":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/cube_view_home.sh"])
                        # Command: Switch the view of your model - Home
                    if vc['text'] == "fusion cube left":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/cube_view_left.sh"])
                        # Command: Switch the view of your model - Left
                    if vc['text'] == "fusion cube right":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/cube_view_right.sh"])
                        # Command: Switch the view of your model - Right
                    if vc['text'] == "fusion cube top":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/cube_view_top.sh"])
                        # Command: Switch the view of your model - Top
                    
                    # --------------------------------------------------------------------------------------------------------------------------
                                        
                    # Design Workspace Shortcuts:
                    
                    if vc['text'] == "fusion appearance":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "a"])
                        # Command: Appearance
                    if vc['text'] == "fusion as built joint":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "shift+j"])
                        # Command: As-built Joint
                    if vc['text'] == "fusion compute all":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+b"])
                        # Command: Compute All
                    if vc['text'] == "fusion delete":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "Delete"])
                        # Command: Delete
                    if vc['text'] == "fusion extrude":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "e"])
                        # Command: Extrude                   
                    if vc['text'] == "fusion freeform selection":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "2"])
                        # Command: Freeform Selection
                    if vc['text'] == "fusion hole":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "h"])
                        # Command: Hole
                    if vc['text'] == "fusion joint":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "j"])
                        # Command: Joint
                    if vc['text'] == "fusion measure":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "i"])
                        # Command: Measure
                    if vc['text'] == "fusion model fillet":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "f"])
                        # Command: Model Fillet
                    if vc['text'] == "fusion move":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "m"])
                        # Command: Move
                    if vc['text'] == "fusion paint selection":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "3"])
                        # Command: Paint Selection
                    if vc['text'] == "fusion press pull":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "q"])
                        # Command: Press Pull
                    if vc['text'] == "fusion scripts and add ins":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "shift+s"])
                        # Command: Scripts and Add-ins
                    if vc['text'] == "fusion toggle component color cycling":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "shift+n"])
                        # Command: Toggle Component Color Cycling
                    if vc['text'] == "fusion toggle visibility":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "v"])
                        # Command: Toggle Visibility
                    if vc['text'] == "fusion window selection":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "1"])
                        # Command: Window Selection
                    
                    # --------------------------------------------------------------------------------------------------------------------------
                    
                    # Sketch Environment Shortcuts:
                    
                    if vc['text'] == "fusion two point rectangle":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "r"])
                        # Command: 2-point Rectangle
                    if vc['text'] == "fusion center diameter circle":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "c"])
                        # Command: Center Diameter Circle
                    if vc['text'] == "fusion line":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "l"])
                        # KeCommand: Line
                    if vc['text'] == "fusion normal construction":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "x"])
                        # Command: Normal / Construction
                    if vc['text'] == "fusion offset":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "o"])
                        # Command: Offset
                    if vc['text'] == "fusion project":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "p"])
                        # Command: Project (New Sketch)
                    if vc['text'] == "fusion sketch dimension":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "d"])
                        # Command: Sketch Dimension
                    if vc['text'] == "fusion trim":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "t"])
                        # Command: Trim
                    
                    # --------------------------------------------------------------------------------------------------------------------------
                    
                    # Canvas Selection Shortcuts:
                    
                    if vc['text'] == "fusion copy":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+c"])
                        # Command: Copy
                    if vc['text'] == "fusion cut":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+x"])
                        # Command: Cut             
                    if vc['text'] == "fusion paste":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+v"])
                        # Command: Paste
                    if vc['text'] == "fusion redo":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+y"])
                        # Command: Redo
                    if vc['text'] == "fusion undo":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "ctrl+z"])
                        # Command: Undo
                    
                    # --------------------------------------------------------------------------------------------------------------------------
                    
                    # Direct Mesh Editing Shortcuts:
                    
                    if vc['text'] == "fusion expand to face group":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "alt+g"])
                        # Command: Expand To Face Group
                    if vc['text'] == "fusion expand to connected":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "alt+c"])
                        # Command: Expand To Connected             
                    if vc['text'] == "fusion grow selection":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "shift+up"])
                        # Command: Grow Selection
                    if vc['text'] == "fusion shrink selection":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "shift+down"])
                        # Command: Shrink Selection
                    if vc['text'] == "fusion invert":
                        subprocess.run(["/home/steve/.config/fusion-360/scripts/speechtoolkit/keypress.sh", "alt+n"])
                        # Command: Invert
                    
                    # --------------------------------------------------------------------------------------------------------------------------                   
                    
					# Still in Progress!
					

                    
 
                else:
                    print(rec.PartialResult())
                if dump_fn is not None:
                    dump_fn.write(data)

except KeyboardInterrupt:
    print('\nDone')
    parser.exit(0)
except Exception as e:
    parser.exit(type(e).__name__ + ': ' + str(e))
