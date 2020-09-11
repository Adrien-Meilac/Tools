Set voice = CreateObject("SAPI.SpVoice")
voice.Rate = 1
voice.Volume = 90
Say = InputBox("Say Something", "Say Something", "I Love you!")
If (Len(Say) > 0) Then
    voice.Speak Say
End If 