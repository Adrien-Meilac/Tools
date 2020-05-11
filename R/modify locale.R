
registry = readRegistry("Control Panel\\International",
            hive = "HCU")

print(registry$sList)
print(registry$sDecimal)
