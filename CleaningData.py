#!/usr/bin/env python
# -*- coding: utf-8 -*-
import csv
import os 

filePath = os.path.dirname(os.path.realpath(__file__))

nameFileOpen = "Pagina_Fiscal_2016.txt"
nameFileSaveOK = "Pagina_Fiscal_2016.csv"
nameFileSaveException = "Pagina_Fiscal_2016-Exception.csv"

arq = open(filePath + "/Data/" + nameFileOpen, 'r')
writerOK = csv.writer(open(filePath + "/" + nameFileSaveOK, 'w'), delimiter=';')
writerEx = csv.writer(open(filePath + "/" + nameFileSaveException, 'w'), delimiter=';')

text = arq.readlines()
count = 0
for line in text:
	count += 1
	attrLine = line.split(';')
	a = attrLine[len(attrLine)-1].replace('\n', '')
	attrLine[len(attrLine)-1] = a

	if count == 1:        
		print("Checking columns: " + attrLine[20] + " - " + attrLine[21] + " - " + attrLine[22])
		writerOK.writerow(attrLine)
		writerEx.writerow(attrLine)

	if count % 1000 == 0:
		print("Values from line: " + str(count))

	if count > 1:
		if attrLine[20] != '' and attrLine[21] != '' and attrLine[22] != '':
			fpa = float(attrLine[20].replace(',', '.'))
			fpb = float(attrLine[21].replace(',', '.'))
			fpc = float(attrLine[22].replace(',', '.'))
			if fpa > 0.0 and fpa <= 1.0 and fpb > 0.0 and fpb <= 1.0 and fpc > 0.0 and fpc <= 1.0 :
				writerOK.writerow(attrLine)
			else:
				writerEx.writerow(attrLine)
		else:
			writerEx.writerow(attrLine)
print("Finished!!!")
arq.close()
