Dim David
Set David = CreateObject("SAPI.spVoice")
Set David.Voice = David.GetVoices.Item(2)
David.Rate = 2
David.Volume = 100

David.Speak "Je m'appelle Hortense"