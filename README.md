# FlatAero

FlatAero is an open source project that would allow people to read flatbuffer payloads from the server/files. 
This is built by the help of the amazing community of [PixelogicDev](https://twitch.tv/pixelogicdev).

# Tech
The following project would preferable only import [flatbuffers](https://github.com/google/flatbuffers), meaning we would be building it completely on apples frameworks.
A bit ambitions but I think it can be done until we get to the console^2 part.

Architecture:
- MVP (Model view presenter)

we would be using:
- NSOperations for async code
- Cocoa for UI
- Use PDFs for resources, which makes everything scalable

# Baby steps

Build a macOS app, that would read the fbs file and the input stream and convert it to (JSON/FLAT^1). the initial design can be found in [first](https://github.com/mustiikhalil/FlatAero/designs/first.pdf)
- Import a fbs file and the input stream (bin/mon) files
- build the (JSON/FLAT^1) file from that input stream

# END GOAL:

- Building a macOS application that would be able to create requests to servers 

- Be Able to read flatbuffers binary data and decode it into a readable object (JSON/FLAT^1).

- Able to allow the developer that's using it to create his/her own objects using a built in console^2.


# REFERENCES

### 1: FLAT
FLAT is going to be a decoding style where we would be able to do something like this
```
- start: Monster
   - name: "Fred"
   - friendly: false
   - vec: Vec3
      - x: 1
      - y: 2
      - z: 3
   - color: red
```

### 2: Console
Console would be able to parse (swift || js) to allow the user to build their own objects

challenges: 
 - Create the fbs objects in swift/js and expose them to the enviroment in real time (makes js seem easier for this feature)

# How to Contribute
- Use the [Apple Swift Style Guide](https://swift.org/documentation/api-design-guidelines/). or, try to stay true to the existing code of the project.
- Write a descriptive commit message.
- If your PR consists of multiple commits which are successive improvements / fixes to your first commit, use (git rebase -i)! 