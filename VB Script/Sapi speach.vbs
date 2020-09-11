Dim David
Set David = CreateObject("SAPI.spVoice")
Set David.Voice = David.GetVoices.Item(2)
David.Rate = 2
David.Volume = 100

David.Speak "Je suis un blutto qui ne fout rien de la journee"