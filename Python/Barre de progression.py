# -*- coding: utf-8 -*-
import sys 
import time

    
def progressBar(name, value, endvalue, bar_length = 50, width = 20):
        percent = float(value) / endvalue
        arrow = '-' * int(round(percent*bar_length) - 1) + '>'
        spaces = ' ' * (bar_length - len(arrow))
        sys.stdout.write("\r{0: <{1}} : [{2}]{3}%".format(\
                         name, width, arrow + spaces, int(round(percent*100))))
        sys.stdout.flush()
        if value == endvalue:     
             sys.stdout.write('\n\n')
             
for i in range(101):
    progressBar("essai", i, 100)
    time.sleep(0.1)
    
sys.stdout.write("\n\n")
    
stream = sys.stdout
for i in range(137):
    stream.write('\b' * (len(str(i)) + 10))
    stream.write("Message : " + str(i))
    stream.flush()
    time.sleep(0.1)
