#!/usr/bin/env python3

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.                       #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2024                                                                          #
# Time/Date:    23:30/31.07.2024                                                                   #
# Version:      2.0.0                                                                              #
####################################################################################################

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, GdkPixbuf, GLib
import gettext
import threading
import subprocess

####################################################################################################

# Set the locale directory for gettext (/locale/en_US/LC_MESSAGES/messages.mo, /locale/de_DE/LC_MESSAGES/messages.mo, ...)
language_domain = 'autodesk_fusion'  # Your gettext domain
translation_directory = 'locale'  # Directory containing your .mo files
default_language = 'en_US'  # Default language
languages = {  # Mapping of language names to locale names
    "English - English": 'en_US',
    "German - Deutsch": 'de_DE',
    "Czech - Čeština": 'cs_CZ',
    "French - Français": 'fr_FR',
    "Italian - Italiano": 'it_IT',
    "Japanese - 日本語": 'ja_JP',
    "Korean - 한국인": 'ko_KR',
    "Polish - Polski": 'pl_PL',
    "Portuguese - Português": 'pt_BR',
    "Simplified Chinese - 简体中文": 'zh_CN',
    "Spanish - Español": 'es_ES',
    "Traditional Chinese - 中國人": 'zh_TW',
    "Turkish - Türkçe": 'tr_TR'
}

# Set the locale based on the default language
subprocess.run(['export', f'LANGUAGE={default_language}'], shell=True)
gettext.translation(language_domain, translation_directory, languages=[default_language]).install()

####################################################################################################

# Function to determine if a color is dark
def is_dark(color):
    # Calculate the luminance of the color
    r, g, b = color.red, color.green, color.blue
    luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
    # Return True if luminance is less than a threshold, else False
    return luminance < 0.5

# Get the current Gtk settings
settings = Gtk.Settings.get_default()

# Get the current window
window = Gtk.Window()

# Get the background color of the window
context = window.get_style_context()
background_color = context.get_background_color(Gtk.StateFlags.NORMAL)

# Check if the background color is dark
is_dark_theme = is_dark(background_color)

# Choose the appropriate CSS file based on the theme
css_filename = "fusion360-dark.css" if is_dark_theme else "fusion360-light.css"

# Get the directory of the current script
script_dir = subprocess.run(['dirname', subprocess.run(['realpath', '--', __file__], capture_output=True, text=True).stdout.strip()], capture_output=True, text=True).stdout.strip()

# Construct the path to the CSS file
css_path = subprocess.run(['printf', '%s/styles/%s', script_dir, css_filename], capture_output=True, text=True).stdout.strip()

# Check if the CSS file exists
css_file_exists = subprocess.run(['test', '-f', css_path], capture_output=True).returncode == 0

if css_file_exists:
    # Load the CSS file
    style_provider = Gtk.CssProvider()
    style_provider.load_from_path(css_path)

    # Add the style provider to the default screen
    Gtk.StyleContext.add_provider_for_screen(
        Gdk.Screen.get_default(),
        style_provider,
        Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    )
else:
    print(f"CSS file '{css_filename}' not found in '{css_path}'")

####################################################################################################

class LanguageSelectionWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title=_("Fusion 360 - Linux Installer"))
        self.set_border_width(35)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)

        self.selected_language = None

        # Close button in the top-left corner
        self.close_button_label = _("Close")
        self.close_button = Gtk.Button(label=self.close_button_label)
        self.close_button.connect("clicked", self.on_close_clicked)

        # Next button in the top-right corner
        self.next_button_label = _("Next")
        self.next_button = Gtk.Button(label=self.next_button_label)
        self.next_button.connect("clicked", self.on_next_clicked)

        # Header-Bar Configuration
        header_bar = Gtk.HeaderBar()
        header_bar.props.title = _("Fusion 360 - Linux Installer")
        header_bar.pack_start(self.close_button)
        header_bar.pack_end(self.next_button)
        self.set_titlebar(header_bar)

        svg_file_path = "graphics/welcome.svg"
        pixbuf = GdkPixbuf.Pixbuf.new_from_file_at_size(svg_file_path, 100, 150)

        # Create an image widget and set the Pixbuf
        image = Gtk.Image.new_from_pixbuf(pixbuf)

        # Create a label widget for title
        self.title_label = Gtk.Label()
        self.title_label.set_markup('<span font_size="20000"><b>' + _('Welcome') + '</b></span>')

        # Read languages from file
        self.languages = list(languages.keys())

        language_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        language_box.set_name("box")  # Set the name for CSS styling

        # Create a ListBox to display the languages
        self.listbox = Gtk.ListBox()
        self.listbox.set_selection_mode(Gtk.SelectionMode.SINGLE)

        for language in self.languages:
            row = Gtk.ListBoxRow()
            hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=50)
            label = Gtk.Label(label=language)
            hbox.pack_start(label, True, True, 0)
            row.add(hbox)
            self.listbox.add(row)

        # Add the ListBox to a ScrolledWindow
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.add(self.listbox)

        scrolled_window.set_size_request(300, 200)

        language_box.pack_start(scrolled_window, True, True, 0)

        # Create a VBox to organize widgets vertically
        vbox = Gtk.VBox(spacing=10)
        vbox.pack_start(image, False, False, 5)
        vbox.pack_start(self.title_label, False, False, 0)
        vbox.pack_start(language_box, True, True, 0)

        # Add the VBox to the window
        self.add(vbox)

        # Connect the "row-activated" signal to the callback function
        self.listbox.connect("row-activated", self.on_language_selected)

    def on_language_selected(self, listbox, row):
        selected_language = self.languages[row.get_index()]
        locale_name = languages[selected_language]
        print(f"Selected language: {selected_language} ({locale_name})")

        # Set the locale based on the selected language
        subprocess.run(['export', f'LANGUAGE={locale_name}'], shell=True)
        gettext.translation(language_domain, translation_directory, languages=[locale_name]).install()

        # Refresh buttons to update the language
        self.close_button.set_label(_("Close"))
        self.next_button.set_label(_("Next"))

        # Refresh the window to update the language
        self.title_label.set_markup('<span font_size="20000"><b>' + _('Welcome') + '</b></span>')

        # Update the window title
        self.set_title(_("Fusion 360 - Linux Installer"))

    def on_next_clicked(self, button):
        row = self.listbox.get_selected_row()
        if row:
            selected_language = self.languages[row.get_index()]
            self.selected_language = selected_language
            print("Next button clicked")
            installation_license_window = LicenseAgreementWindow(selected_language)
            installation_license_window.connect("destroy", Gtk.main_quit)
            installation_license_window.show_all()
            self.hide()

    def on_close_clicked(self, button):
        print("Close button clicked")
        Gtk.main_quit()

####################################################################################################

# create class like as InstallationOptionsWindow for LicenseAgreementWindow

class LicenseAgreementWindow(Gtk.Window):
    def __init__(self, selected_language):
        Gtk.Window.__init__(self, title=_("Fusion 360 - Linux Installer"))
        self.set_border_width(35)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)
        self.connect('destroy', Gtk.main_quit)
        self.selected_language = selected_language

        # Previous button in the top-left corner
        self.previous_button_label = _("Previous")
        self.previous_button = Gtk.Button(label=self.previous_button_label)
        self.previous_button.connect("clicked", self.on_previous_clicked)

        # Next button in the top-right corner
        self.next_button_label = _("Next")
        self.next_button = Gtk.Button(label=self.next_button_label)
        self.next_button.connect("clicked", self.on_next_clicked)
        self.next_button.set_sensitive(False)  # Disable the next button by default

        # Header-Bar Configuration
        header_bar = Gtk.HeaderBar()
        header_bar.props.title = _("Fusion 360 - Linux Installer")
        header_bar.pack_start(self.previous_button)
        header_bar.pack_end(self.next_button)
        self.set_titlebar(header_bar)

        # Create a label for the installation options.
        self.title_label = Gtk.Label()
        self.title_label.set_markup('<span font_size="20000"><b>' + _('License Agreement') + '</b></span>')

        # Create a box to hold the radio buttons
        license_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=5)
        license_box.set_halign(Gtk.Align.CENTER)  # Center align the radio_box

        license_box_1 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        license_box_1.set_name("box")  # Set the name for CSS styling

        # Add the ListBox to a ScrolledWindow
        license_text_scrolled_window = Gtk.ScrolledWindow()
        #set the size of the ScrolledWindow
        license_text_scrolled_window.set_size_request(600, 300)

        # Create a box to show the license agreement text
        license_text = Gtk.Label()
        license_text.set_markup('<small>' + _("LICENSE AGREEMENT\n\n"
                            "Name: Autodesk Fusion 360 - Setup Wizard (Linux)\n"
                            "Description: With this Setup Wizard you can install Autodesk Fusion 360 on various Linux distributions.\n"
                            "Author: Steve Zabka\n"
                            "Author URI: https://cryinkfly.com\n"
                            "License: MIT\n"
                            "Copyright (c) 2020-2024\n\n"
                            "Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the „Software“), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\n"
                            "The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\n"
                            "THE SOFTWARE IS PROVIDED „AS IS“, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.") + '</small>')
        license_text.set_line_wrap(True)
        license_text.set_max_width_chars(50)
        license_text.set_name("box-text")

        license_box_2 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)

        # Create a checkbox for the license agreement
        license_agreement = Gtk.CheckButton.new_with_label(_('I have read and agree to the License Agreement.'))
        license_agreement.set_name("box-button")  # Set the name for CSS styling
        license_agreement.set_active(False)
        license_agreement.connect("toggled", self.on_license_agreement_toggled)

        license_text_scrolled_window.add(license_text)
        license_box_1.pack_start(license_text_scrolled_window, False, False, 0)
        license_box_2.pack_start(license_agreement, False, False, 0)

        license_box.pack_start(license_box_1, False, False, 3)
        license_box.pack_start(license_box_2, False, False, 3)

        # Create a VBox to organize widgets vertically
        vbox = Gtk.VBox(spacing=10)
        vbox.pack_start(self.title_label, False, False, 0)
        vbox.pack_start(license_text, False, False, 0)
        vbox.pack_start(license_box, False, False, 0)

        # Add the VBox to the window
        self.add(vbox)
        
    def on_previous_clicked(self, button):
        print("Previous button clicked")

        subprocess.run(['export', f'LANGUAGE={default_language}'], shell=True)
        gettext.translation(language_domain, translation_directory, languages=[default_language]).install()

        language_selection_window = LanguageSelectionWindow()
        language_selection_window.connect("destroy", Gtk.main_quit)
        language_selection_window.show_all()
        self.hide()

    def on_license_agreement_toggled(self, button):
        if button.get_active():
            self.license_agreement_accepted = True
            self.next_button.set_sensitive(True)  # Enable the next button
        else:
            self.license_agreement_accepted = False
            self.next_button.set_sensitive(False)  # Disable the next button

    def on_next_clicked(self, button):
        print("Next button clicked")
        installation_options_selection_window = InstallationOptionsWindow()
        installation_options_selection_window.connect("destroy", Gtk.main_quit)
        installation_options_selection_window.show_all()
        self.hide()

####################################################################################################

class InstallationOptionsWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title=_("Fusion 360 - Linux Installer"))
        self.set_border_width(35)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)
        self.connect('destroy', Gtk.main_quit)

        # Previous button in the top-left corner
        self.previous_button_label = _("Previous")
        self.previous_button = Gtk.Button(label=self.previous_button_label)
        self.previous_button.connect("clicked", self.on_previous_clicked)

        # Next button in the top-right corner
        self.next_button_label = _("Next")
        self.next_button = Gtk.Button(label=self.next_button_label)
        self.next_button.connect("clicked", self.on_next_clicked)

        # Header-Bar Configuration
        header_bar = Gtk.HeaderBar()
        header_bar.props.title = _("Fusion 360 - Linux Installer")
        header_bar.pack_start(self.previous_button)
        header_bar.pack_end(self.next_button)
        self.set_titlebar(header_bar)

        # Create a label for the installation options.
        self.title_label = Gtk.Label()
        self.title_label.set_markup('<span font_size="20000"><b>' + _('Select the installation type:') + '</b></span>')

        # Create a box to hold the radio buttons
        radio_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=5)
        radio_box.set_halign(Gtk.Align.CENTER)  # Center align the radio_box

        radio_box_1 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        radio_box_1.set_name("box")  # Set the name for CSS styling

        # Create a radio button for the express installation.
        express_installation = Gtk.RadioButton.new_with_label_from_widget(None, _('Basic'))
        express_installation.set_name("box-button")  # Set the name for CSS styling
        express_installation.set_active(True)
        express_installation.connect("toggled", self.on_installation_type_toggled)
        express_installation_label = Gtk.Label()
        express_installation_label.set_markup('<small>' + _('Select the Basic installation type for a seamless setup process. This option offers a default configuration, simplifying installation and minimizing setup time. Get Fusion 360 up and running quickly, allowing you to focus on your projects without unnecessary delays.') + '</small>')
        express_installation_label.set_line_wrap(True)
        express_installation_label.set_max_width_chars(50)
        express_installation_label.set_name("box-button-text")
        express_installation_label.set_xalign(0)

        radio_box_2 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        radio_box_2.set_name("box")  # Set the name for CSS styling

        # Create a radio button for the full installation.
        full_installation = Gtk.RadioButton.new_with_label_from_widget(express_installation, _('Complete'))
        full_installation.set_name("box-button")  # Set the name for CSS styling
        full_installation.set_active(False)  # Ensure it is not selected
        full_installation.connect("toggled", self.on_installation_type_toggled)
        full_installation_label = Gtk.Label()
        full_installation_label.set_markup('<small>' + _('Select the Complete installation type to seamlessly install Fusion 360 along with various extensions like OctoPrint for Autodesk® Fusion 360™. These extensions are Linux-tested for optimal compatibility and performance, ensuring a smooth and efficient experience.') + '</small>')
        full_installation_label.set_line_wrap(True)
        full_installation_label.set_max_width_chars(50)
        full_installation_label.set_name("box-button-text")  # Set the name for CSS styling
        full_installation_label.set_xalign(0)

        radio_box_3 = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        radio_box_3.set_name("box")  # Set the name for CSS styling

        # Create a radio button for the custom installation.
        custom_installation = Gtk.RadioButton.new_with_label_from_widget(express_installation, _('Custom'))
        custom_installation.set_name("box-button")  # Set the name for CSS styling
        custom_installation.set_active(False)  # Ensure it is not selected
        custom_installation.connect("toggled", self.on_installation_type_toggled)
        custom_installation_label = Gtk.Label()
        custom_installation_label.set_markup('<small>' + _('Select the Custom installation type to personalize your Fusion 360 setup on Linux. Adjust settings such as the installation directory and select verified extensions for Fusion 360. Although it is more detailed, it ensures a custom configuration that meets your needs.') + '</small>')
        custom_installation_label.set_line_wrap(True)
        custom_installation_label.set_max_width_chars(50)
        custom_installation_label.set_name("box-button-text")  # Set the name for CSS styling
        custom_installation_label.set_xalign(0)

        # Add the radio buttons to the radio boxes
        radio_box_1.pack_start(express_installation, False, False, 0)
        radio_box_1.pack_start(express_installation_label, False, False, 0)
        radio_box_2.pack_start(full_installation, False, False, 0)
        radio_box_2.pack_start(full_installation_label, True, False, 0)
        radio_box_3.pack_start(custom_installation, False, False, 0)
        radio_box_3.pack_start(custom_installation_label, False, False, 0)

        radio_box.pack_start(radio_box_1, False, False, 3)
        radio_box.pack_start(radio_box_2, False, False, 3)
        radio_box.pack_start(radio_box_3, False, False, 3)

        # Create a VBox to organize widgets vertically
        vbox = Gtk.VBox(spacing=10)
        # Assume self.title_label is already defined somewhere in your class
        vbox.pack_start(self.title_label, False, False, 0)
        vbox.pack_start(radio_box, False, False, 0)

        # Add the VBox to the window
        self.add(vbox)

    def on_installation_type_toggled(self, button):
        if button.get_active():
            self.selected_installation_type = button.get_label()
        
    def on_previous_clicked(self, button):
        print("Previous button clicked")
        selected_language = LanguageSelectionWindow().selected_language
        installation_license_window = LicenseAgreementWindow(selected_language)
        installation_license_window.connect("destroy", Gtk.main_quit)
        installation_license_window.show_all()
        self.hide()

    def on_next_clicked(self, button):
        print("Next button clicked")

        if hasattr(self, 'selected_installation_type') and self.selected_installation_type == _('Complete'):
            print(_("Complete installation type selected"))
            home_directory = subprocess.check_output("echo $HOME", shell=True).decode().strip()
            selected_directory = home_directory + "/.fusion360"
            print("Directory selected: " + selected_directory)
            selected_extensions = ["CzechlocalizationforF360,HP3DPrintersforAutodesk®Fusion®,MarkforgedforAutodesk®Fusion®,OctoPrintforAutodesk®Fusion360™,UltimakerDigitalFactoryforAutodeskFusion360™"]
            print("Extensions selected: " + str(selected_extensions))
            installation_progress_window = InstallationProgressWindow(selected_directory, selected_extensions)
            installation_progress_window.connect("destroy", Gtk.main_quit)
            installation_progress_window.show_all()
            self.hide()
        elif hasattr(self, 'selected_installation_type') and self.selected_installation_type == _('Custom'):
            print(_("Custom installation type selected"))
            directory_selection_window = InstallationDirectoryWindow()
            directory_selection_window.connect("destroy", Gtk.main_quit)
            directory_selection_window.show_all()
            self.hide()
        else:
            print(_("Basic installation type selected"))
            home_directory = subprocess.check_output("echo $HOME", shell=True).decode().strip()
            selected_directory = home_directory + "/.fusion360"
            print("Directory selected: " + selected_directory)
            selected_extensions = []
            print("Extensions selected: " + str(selected_extensions))
            installation_progress_window = InstallationProgressWindow(selected_directory, selected_extensions)
            installation_progress_window.connect("destroy", Gtk.main_quit)
            installation_progress_window.show_all()
            self.hide()

####################################################################################################

class InstallationDirectoryWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title=_("Fusion 360 - Linux Installer"))
        self.set_border_width(35)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)
        self.connect('destroy', Gtk.main_quit)

        # Previous button in the top-left corner
        self.previous_button_label = _("Previous")
        self.previous_button = Gtk.Button(label=self.previous_button_label)
        self.previous_button.connect("clicked", self.on_previous_clicked)

        # Next button in the top-right corner
        self.next_button_label = _("Next")
        self.next_button = Gtk.Button(label=self.next_button_label)
        self.next_button.connect("clicked", self.on_next_clicked)

        # Header-Bar Configuration
        header_bar = Gtk.HeaderBar()
        header_bar.props.title = _("Fusion 360 - Linux Installer")
        header_bar.pack_start(self.previous_button)
        header_bar.pack_end(self.next_button)
        self.set_titlebar(header_bar)

        # Create a label for the installation options.
        self.title_label = Gtk.Label()
        self.title_label.set_markup('<span font_size="20000"><b>' + _('Select the installation directory:') + '</b></span>')
        self.title_label.set_line_wrap(True)
        self.title_label.set_max_width_chars(50)

        directory_box_1 = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        directory_box_1.set_halign(Gtk.Align.CENTER)
        directory_box_1.set_name("box")  # Set the name for CSS styling

        # Create Label for description
        self.description_label = Gtk.Label()
        self.description_label.set_markup('<small>' + _("By default, Fusion 360 installs in your home directory, but if you prefer a "
                                                        "different location, you can specify the desired installation directory here. \n\n"
                                                        "This allows for better organization and management of your software installations, especially "
                                                        "if you have multiple users or limited space in your home directory.") + '</small>')
        self.description_label.set_line_wrap(True)
        self.description_label.set_max_width_chars(50)
        self.description_label.set_name("box-text")

        # Get the current user's home directory
        home_directory = subprocess.check_output("echo $HOME", shell=True).decode().strip()

        directory_box_2 = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL)
        directory_box_2.set_halign(Gtk.Align.CENTER)

        # Create a button to browse for the installation directory
        self.browse_button = Gtk.Button(label=_("Browse"))
        self.browse_button.set_name("box-button")  # Set the name for CSS styling
        self.browse_button.connect("clicked", self.on_browse_clicked)
        self.browse_button.set_hexpand(False)  # Set the button to not expand horizontally
        self.browse_button.set_halign(Gtk.Align.CENTER)  # Center align the button horizontally

        # Create an entry field for the installation directory
        self.installation_directory_entry = Gtk.Entry()
        self.installation_directory_entry.set_name("box-button")  # Set the name for CSS styling
        self.installation_directory_entry.set_text(home_directory + "/.fusion360")
        self.installation_directory_entry.set_hexpand(False)
        self.installation_directory_entry.set_halign(Gtk.Align.CENTER)

        # Create a refesh button to reset the installation directory to the default with a symbolic icon
        self.refresh_button = Gtk.Button()
        self.refresh_button.set_image(Gtk.Image.new_from_icon_name("view-refresh-symbolic", Gtk.IconSize.BUTTON))
        self.refresh_button.set_tooltip_text(_("Reset to default"))
        self.refresh_button.connect("clicked", self.on_refresh_clicked)
        self.refresh_button.set_hexpand(False)  # Set the button to not expand horizontally

        # Minimum width of the entry field
        self.installation_directory_entry.set_size_request(300, 0)

        # Align the entry field content to the center
        self.installation_directory_entry.set_alignment(0.5)

        # Entry not selected by default
        self.installation_directory_entry.set_can_focus(False)

        directory_box_1.pack_start(self.description_label, False, False, 10)
        directory_box_2.pack_start(self.browse_button, False, False, 5)
        directory_box_2.pack_start(self.installation_directory_entry, False, False, 5)
        directory_box_2.pack_start(self.refresh_button, False, False, 5)

        # Create a VBox to organize widgets vertically
        vbox = Gtk.VBox(spacing=10)
        vbox.pack_start(self.title_label, False, False, 0)
        vbox.pack_start(directory_box_1, False, False, 10)
        vbox.pack_start(directory_box_2, False, False, 0)

        # Add the VBox to the window
        self.add(vbox)

    def on_browse_clicked(self, button):
        print("Browse button clicked")
        # Open a file chooser dialog to select the installation directory
        dialog = Gtk.FileChooserDialog(title=_("Select the installation directory"), parent=self, action=Gtk.FileChooserAction.SELECT_FOLDER)
        dialog.add_buttons(Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL, Gtk.STOCK_OPEN, Gtk.ResponseType.OK)
        response = dialog.run()

        if response == Gtk.ResponseType.OK:
            print("Select clicked")
            directory = dialog.get_filename()

            # Refresh the selected directory in the entry field
            self.installation_directory_entry.set_text(directory)

            # Save the selected directory for later use and if the user goes back from the InstallationExtensionsWindow to this window
            self.selected_directory = directory

        elif response == Gtk.ResponseType.CANCEL:
            print("Cancel clicked")

        dialog.destroy()

    def on_refresh_clicked(self, button):
        print("Refresh button clicked")
        # Get the current user's home directory
        home_directory = subprocess.check_output("echo $HOME", shell=True).decode().strip()
        self.installation_directory_entry.set_text(home_directory + "/.fusion360")

    def on_previous_clicked(self, button):
        print("Previous button clicked")
        
        installation_options_selection_window = InstallationOptionsWindow()
        installation_options_selection_window.connect("destroy", Gtk.main_quit)
        installation_options_selection_window.show_all()
        self.hide()

    def on_next_clicked(self, button):
        print("Next button clicked")
        selected_directory = self.installation_directory_entry.get_text()
        print("Directory selected: " + selected_directory)

        extensions_selection_window = InstallationExtensionsWindow(selected_directory)
        extensions_selection_window.connect("destroy", Gtk.main_quit)
        extensions_selection_window.show_all()
        self.hide()

####################################################################################################

class InstallationExtensionsWindow(Gtk.Window):
    def __init__(self, selected_directory):
        Gtk.Window.__init__(self, title=_("Fusion 360 - Linux Installer"))
        self.set_default_size(650, 450)
        self.set_border_width(35)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)
        self.connect('destroy', Gtk.main_quit)

        self.selected_directory = selected_directory

        # Previous button in the top-left corner
        self.previous_button_label = _("Previous")
        self.previous_button = Gtk.Button(label=self.previous_button_label)
        self.previous_button.connect("clicked", self.on_previous_clicked)

        # Next button in the top-right corner
        self.next_button_label = _("Next")
        self.next_button = Gtk.Button(label=self.next_button_label)
        self.next_button.connect("clicked", self.on_next_clicked)

        # Header-Bar Configuration
        header_bar = Gtk.HeaderBar()
        header_bar.props.title = _("Fusion 360 - Linux Installer")
        header_bar.pack_start(self.previous_button)
        header_bar.pack_end(self.next_button)
        self.set_titlebar(header_bar)

        # Create a label for the installation options.
        self.title_label = Gtk.Label()
        self.title_label.set_markup('<span font_size="20000"><b>' + _('Please select the extensions.') + '</b></span>')

        # Create a scrolled window where the user can select the extensions to install with Fusion 360 on Linux
        extensions_scrolled_window = Gtk.ScrolledWindow()
        extensions_scrolled_window.set_size_request(600, 300)

        # Create a box to hold the extensions
        extensions_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        extensions_box.set_halign(Gtk.Align.CENTER)

        # List of extensions with their descriptions
        extensions = [
            (_('Czech localization for F360'), _('With the help of this free extension, the user can also use the Czech language in Fusion 360.')),
            (_('HP 3D Printers for Autodesk® Fusion®'), _('This extension allows you to connect Autodesk Fusion 360 with HP SmartStream software and send jobs directly to the HP software.')),
            (_('Markforged for Autodesk® Fusion®'), _('This extension allows you to connect Autodesk Fusion 360 with Markforged software (https://www.eiger.io).')),
            (_('OctoPrint for Autodesk® Fusion 360™'), _('With this extension you can send the G-code of your created 3D models directly to the OctoPrint server via Autodesk Fusion 360.')),
            (_('Ultimaker Digital Factory for Autodesk Fusion 360™'), _('This is a connector between Autodesk® Fusion 360™ and the Ultimaker Digital Factory site and its services.'))
        ]

        self.extension_checkbuttons = []

        # Create check buttons with labels for each extension
        for ext_name, ext_description in extensions:
            box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
            box.set_name("box")

            check_button = Gtk.CheckButton.new_with_label(ext_name)
            check_button.set_name("box-button")
            check_button.set_active(False)
            self.extension_checkbuttons.append(check_button)

            label = Gtk.Label()
            label.set_markup('<small>' + ext_description + '</small>')
            label.set_line_wrap(True)
            label.set_max_width_chars(50)
            label.set_name("box-button-text")
            label.set_xalign(0)

            box.pack_start(check_button, False, False, 0)
            box.pack_start(label, False, False, 0)
            extensions_box.pack_start(box, False, False, 3)

        extensions_scrolled_window.add(extensions_box)

        # Create a VBox to organize widgets vertically
        vbox = Gtk.VBox(spacing=10)
        vbox.pack_start(self.title_label, False, False, 0)
        vbox.pack_start(extensions_scrolled_window, False, False, 0)

        # Add the VBox to the window
        self.add(vbox)

    def on_previous_clicked(self, button):
        print("Previous button clicked")

        directory_selection_window = InstallationDirectoryWindow()
        directory_selection_window.connect("destroy", Gtk.main_quit)
        directory_selection_window.show_all()
        self.hide()

    def on_next_clicked(self, button):
        print("Next button clicked")
        
        self.selected_extensions = [cb.get_label() for cb in self.extension_checkbuttons if cb.get_active()]

        installation_progress_window = InstallationProgressWindow(self.selected_directory, self.selected_extensions)
        installation_progress_window.connect("destroy", Gtk.main_quit)
        installation_progress_window.show_all()
        self.hide()


####################################################################################################

class InstallationProgressWindow(Gtk.Window):
    def __init__(self, selected_directory, selected_extensions):
        Gtk.Window.__init__(self, title=_("Fusion 360 - Linux Installer"))
        self.set_default_size(650, 450)
        self.set_border_width(35)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)
        self.connect('destroy', Gtk.main_quit)

        print("Selected directory: " + selected_directory)
        print("Selected extensions: " + str(selected_extensions))
        self.selected_extensions = selected_extensions
        self.selected_directory = selected_directory

        # Abort button in the top-left corner
        self.abort_button_label = _("Abort")
        self.abort_button = Gtk.Button(label=self.abort_button_label)
        self.abort_button.connect("clicked", self.on_abort_clicked)

        # Next button in the top-right corner
        self.next_button_label = _("Next")
        self.next_button = Gtk.Button(label=self.next_button_label)
        self.next_button.connect("clicked", self.on_next_clicked)
        self.next_button.set_sensitive(False)  # Deactivate the Next button

        # Header-Bar Configuration
        header_bar = Gtk.HeaderBar()
        header_bar.props.title = _("Fusion 360 - Linux Installer")
        header_bar.pack_start(self.abort_button)
        header_bar.pack_end(self.next_button)
        self.set_titlebar(header_bar)

        # Create a label for the installation options
        self.title_label = Gtk.Label()
        self.title_label.set_markup('<span font_size="20000"><b>Please wait ...</b></span>')

        # Create a vertical box to contain progress boxes
        self.main_progresses_vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.main_progresses_vbox.set_halign(Gtk.Align.CENTER)

        # Create progress boxes with updated descriptions
        self.create_progress_box(_("Step 1: Preparing files for installation ..."), "install_part1")
        self.create_progress_box(_("Step 2: Setting up Wine for installation ..."), "install_part2")
        self.create_progress_box(_("Step 3: Installing Autodesk Fusion ..."), "install_part3")
        self.create_progress_box(_("Step 4: Installing Autodesk Fusion extensions ..."), "install_part4")
        self.create_progress_box(_("Step 5: Completing the installation ..."), "install_part5")

        # Create a VBox to organize widgets vertically
        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        vbox.pack_start(self.title_label, False, False, 30)
        vbox.pack_start(self.main_progresses_vbox, False, False, 0)

        # Add the VBox to the window
        self.add(vbox)

        # Start the installation process
        self.run_installation_part1()

    def create_progress_box(self, label_text, name):
        # Create a horizontal box for the installation progress
        progress_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        progress_box.set_halign(Gtk.Align.CENTER)
        progress_box.set_name(name)  # Set the name for the progress box

        # Create a label for the installation progress
        progress_label = Gtk.Label()
        progress_label.set_markup('<small>' + label_text + '</small>')
        progress_label.set_line_wrap(True)
        progress_label.set_max_width_chars(50)
        progress_label.set_name("box-button-text")
        progress_label.set_xalign(0)

        # Create a stack to hold the spinner and the completed icon
        stack = Gtk.Stack()
        stack.set_name(name + "_stack")

        # Create a spinner for the installation progress
        spinner = Gtk.Spinner()
        spinner.start()
        stack.add_named(spinner, "spinner")

        # Create a completed icon for the installation progress
        icon = Gtk.Image.new_from_icon_name("emblem-default", Gtk.IconSize.BUTTON)
        stack.add_named(icon, "icon")

        # Add the label and stack to the progress box
        progress_box.pack_start(progress_label, False, False, 0)
        progress_box.pack_start(stack, False, False, 0)

        # Add the progress box to the main progress VBox
        self.main_progresses_vbox.pack_start(progress_box, False, False, 3)

    def run_installation_part1(self):
        threading.Thread(target=self.run_command, args=("install_part1",)).start()

    def run_installation_part2(self):
        threading.Thread(target=self.run_command, args=("install_part2",)).start()

    def run_installation_part3(self):
        threading.Thread(target=self.run_command, args=("install_part3",)).start()

    def run_installation_part4(self):
        threading.Thread(target=self.run_command, args=("install_part4",)).start()

    def run_installation_part5(self):
        threading.Thread(target=self.run_command, args=("install_part5",)).start()
        # Activate the Next button
        self.next_button.set_sensitive(True)
        # Deactivate the Abort button
        self.abort_button.set_sensitive(False)
        # GLib use 5 seconds to run the function on_next_clicked
        GLib.timeout_add_seconds(5, self.on_next_clicked, self.next_button)

    def run_command(self, part_name):
        argument1 = part_name
        argument2 = self.selected_directory
        argument3 = str(self.selected_extensions).replace(" ", "").replace("[", "").replace("]", "").replace("'", "")

        command = f"./data/autodesk_fusion_installer.sh {argument1} {argument2} {argument3}"
        subprocess.call(command, shell=True)

        # Update GUI from the main thread
        GLib.idle_add(self.complete_part, part_name, self.get_next_function(part_name))

    def get_next_function(self, part_name):
        functions = {
            "install_part1": self.run_installation_part2,
            "install_part2": self.run_installation_part3,
            "install_part3": self.run_installation_part4,
            "install_part4": self.run_installation_part5
        }
        return functions.get(part_name, None)

    def complete_part(self, part_name, next_function=None):
        print(f"Completing {part_name}")  # Debugging line
        # Get the progress box by its name
        progress_box = next((child for child in self.main_progresses_vbox.get_children() if child.get_name() == part_name), None)

        if progress_box is None:
            print(f"Error: No progress box found with name {part_name}")
            return

        stack = progress_box.get_children()[1]

        # Stop the spinner and switch to the completed icon
        spinner = stack.get_child_by_name("spinner")
        spinner.stop()
        stack.set_visible_child_name("icon")

        # Call the next installation part function, if provided
        if next_function:
            next_function()

    def on_abort_clicked(self, button):
        print("Abort button clicked")
        threading.Thread(target=self.run_command, args=("abort",)).start()
        Gtk.main_quit()
        
    def on_next_clicked(self, button):
        print("Next button clicked")
        installation_progress_solved_window = InstallationSolvedWindow()
        installation_progress_solved_window.connect("destroy", Gtk.main_quit)
        installation_progress_solved_window.show_all()
        self.hide()

####################################################################################################

class InstallationSolvedWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title=_("Fusion 360 - Linux Installer"))
        self.set_default_size(400, 150)
        self.set_border_width(35)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)
        self.connect('destroy', Gtk.main_quit)

        # Header-Bar Configuration
        header_bar = Gtk.HeaderBar()
        self.set_titlebar(header_bar)

        # Create a label for the installation options.
        self.title_label = Gtk.Label()
        self.title_label.set_markup('<span font_size="20000"><b>' + _('You are all set!') + '</b></span>')

        # Create a label for thank you message
        self.thank_you_label = Gtk.Label()
        self.thank_you_label.set_markup(_('<b>' + _('Thank you for installing Fusion 360 on Linux.') + '</b>'))
        self.thank_you_label.set_line_wrap(True)
        self.thank_you_label.set_max_width_chars(10)

        # Create a Button to close the application
        self.close_button_label = _("Start using Fusion 360")
        self.close_button = Gtk.Button(label=self.close_button_label)
        self.close_button.set_hexpand(False)  # Set the button to not expand horizontally
        self.close_button.set_halign(Gtk.Align.CENTER)  # Center align the button horizontally
        self.close_button.connect("clicked", self.on_close_clicked)

        # Create a VBox to organize widgets vertically
        vbox = Gtk.VBox(spacing=10)
        vbox.pack_start(self.title_label, False, False, 0)
        vbox.pack_start(self.thank_you_label, False, False, 0)
        vbox.pack_start(self.close_button, False, False, 0)

        # Add the VBox to the window
        self.add(vbox)

    def on_close_clicked(self, button):
        print("Close button clicked")
        # Run a linux command to start Fusion 360 and close this python application in the same time
        subprocess.run(["xdg-open", "https://cryinkfly.com/sponsoring/"])
        Gtk.main_quit()
        
        # Go to the next window ... (Select the extensions)

####################################################################################################
# Run the application
####################################################################################################

# Open the language selection window.
language_selection_window = LanguageSelectionWindow()
language_selection_window.connect("destroy", Gtk.main_quit)
language_selection_window.show_all()
Gtk.main()
