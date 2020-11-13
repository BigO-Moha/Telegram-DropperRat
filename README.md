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
*[Todo] automatic file Graber



### Prerequisites

Dart Sdk.


```
use only in Windows platform.
```

### Installing
go to https://dart.dev/get-dart#install.
install dart-SDK

## Usage <a name = "usage"></a>
go to program Directory /source.
* Change const.dart file line 6 with your Own telegram bot api.
* Compile using  [ dart2native bin/drop_it.dart -o bin/myApp.exe].
* -*** Note change your Const.dart programid to your compiled program Name.
* use this command to hide console while app is running [editbin.exe /subsystem:windows {yourapp}.exe]



