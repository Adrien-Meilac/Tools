# -*- coding: utf-8 -*-

from time import sleep
import sys

N=12

for i in range(N):
   sleep(0.5)
   sys.stdout.write(f"\r{i/N*100:.1f} %")
   sys.stdout.flush()