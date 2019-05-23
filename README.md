# App-iOS
MOPCON App for iOS


### Develop Tool
This project develop with Swift (latest version), so before getting start, we should check [Xcode](https://developer.apple.com/xcode/) has been installed in our Mac.

* Xcode recommend 10.2 or above

#### Contert To Latest Swift Version
```bash
# In Xcode
Edit -> Convert -> To Current Swift Syntax...
```

#### Pods Installation & Update

this project uses [CocoaPods](https://cocoapods.org/) to manage third party libraries. We can use commands below to intsall or update third party libraries.

```bash
# pods installation
$ pod install

# pods update
$ pod update
```

if CocoaPods isn't installed in our Mac, we should install first:
```bash
$ sudo gem install cocoapods
```

### Environment Variable

before getting start, please set env variable to develop machine

```bash
export MOPCON_DES_KEY="xxx"
```

### Security Files
the security files was encrypted into `secrets.tar.enc` use follow commands to decrypt it.


##### Derypt
```bash
openssl des-cbc -d -k $MOPCON_DES_KEY -in secrets.tar.enc -out secrets.tar

# extract tar file.
tar xvf ./secrets.tar

# move file
mv GoogleService-Info.plist ./Mopcon/
```
or, if we want to make encrypt file, here is the commands:
##### Encrypt
```bash
tar -czvf secrets.tar files_you_want_to_encrypt

openssl des-cbc -e -K $MOPCON_DES_KEY -in secrets.tar -out secrets.tar.enc
```

### Start Develop

after setting all tool and commands, now we can start develop. Please open `Mopcon.xcworkspace` file.

### Folder Structure

```
.
├── Mopcon                 			# Mopcon folder
│	├── appcenter-post-clone.sh 		# App-Center CI/CD config
│	├── BoothMission.json       		# Mission game json, it should be extracted from secrets.tar.enc
│	├── Mopcon.xcodeproj    			# Xcode Project file
│	├── Mopcon.xcworkspace  			# Xcode Workspace file, open to start this project
│	├── Mopcon    								
│	│	  ├── API						# All api services defined in here    
│	│	  ├── Assets.xcassets			# Image files   
│	│	  ├── Base.lproj				# Launch view
│	│	  ├── Controller				# View controllers and controllers
│	│	  ├── Helper					# Helper classes  
│	│	  ├── Model						# Data models
│	│	  ├── Mopcon.xcdatamodeld				
│	│	  ├── Storyboard				# UI Storyboards
│	│	  ├── View						# UI Views 
│	│	  ├── AppDelegate.swift										
│	│	  ├── GoogleService-Info.plist	# Firebase config								
│	│	  ├── Info.plist										
│	│	  └── Mopcon.entitlements									
│	├── MopconUITests		    		# UI Test files
│	├── Pods							# Thrid-party libraries
│	├── Podfile		    				# Config file of Pods
│	├── Podfile.lock					# Pods lock file
│	├── Quiz.json          				# Mission game json, it should be extracted from secrets.tar.enc
│	└── secrets.tar.enc        			# Encryped secrets files
├── README.me						    # Readme file
└── .gitignore              			# Git ignore file
```

### Coding Style 

the coding style refers to following link, all the developer should follow it.

https://github.com/raywenderlich/swift-style-guide

### Git Flow

We use the simplified git-flow to improve team development speed. Unlike the standard git-flow, we don't have a release branch.

![Imgur](https://i.imgur.com/VtzQ17K.png)

When a feature branch is finished, you must submit a **Pull Request** to develop branch.

Don't forget assign your partner to review it.



### Contributing

Check out the [issues](https://github.com/MOPCON/App-iOS/issues) and see how you can help out.