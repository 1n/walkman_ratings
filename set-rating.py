from mutagen.id3 import ID3, POPM
audio = ID3("./testfile/07Promises.mp3")
#print audio["POPM"]
#audio.pprint()
audio.add(POPM('',255))
audio.update_to_v23()
audio.save()