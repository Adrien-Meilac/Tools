# -*- coding: utf-8 -*-

from win32com.client import Dispatch
s = Dispatch("SAPI.SpVoice")

for a in s.GetVoices():
    print(a.GetDescription())
    
s.Volume = 60
s.GetVoices().Item(2)
s.SetVoice(s.GetVoices().Item(2)) # s.GetVoices().Item(2).GetDescription()
s.Speak("Je m'appelle David, que puis je faire pour vous ?")