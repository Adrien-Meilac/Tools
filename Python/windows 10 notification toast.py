# -*- coding: utf-8 -*-

from win10toast import ToastNotifier
toaster = ToastNotifier()
toaster.show_toast("Sample Notification","Python is awesome!!!", duration = 0, icon_path = None) 
