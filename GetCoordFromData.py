#Library https://pypi.org/project/liac-arff/. For read/write arff files
import arff

#Files to be matched :D
NoCoord = "iTest1.arff"
WithCoord = "ceratocystis_test_90_10_rgb_11_fs9_res1-Indexes.arff"

#Arff load of files to be matched
data = arff.load(open(NoCoord))
data2 = arff.load(open(WithCoord))

#Convert dicc to list. Only the data
listNoCoord = list(data.values())[3]
listWithCoord = list(data2.values())[3]

#Initialize of the list that combine the matches
listMatched = list()

#Loop to search one register of listNoCoord in listWithCoord
for l in listNoCoord:
    first_or_default = next((x for x in listWithCoord if x[3] == l[0] and x[4] == l[1] and x[5] == l[2]), None)
    if first_or_default is not None:
        #list to be appended to the listMatched. Contains the number of image, coord x, coord y, real class, predicted class
        abc = [first_or_default[0], first_or_default[1], first_or_default[2], l[-1], l[-1]]
        listMatched.append(abc)

#Write of a .txt file with the listMatched
with open('imageCoordTo'+NoCoord+'.txt', 'w') as f:
    for item in listMatched:
        f.write("%4.0f\t%4.0f\t%4.0f\t%s\t%s\n" % (item[0], item[1], item[2], item[3], item[4]))