import sys, os
from mutagen.id3 import ID3, POPM

print sys.argv[1]
audio = ID3(sys.argv[1])
#print audio["POPM"]
#audio.pprint()
audio.add(POPM('',255))
#audio.update_to_v23()
audio.save()

#print sys.argv