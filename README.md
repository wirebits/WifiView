# WifiView
A tool which show the all wifi interfaces (on-board and adapters) with drivers and mode.

<h1>Setup</h1>
1. Check the vendor and product by type the following command :<br><br>

```
lsusb -vv
```

It show in the column of <b>idVendor</b> and <b>idProduct</b><br>
<h1>Tested Systems</h1>
The tool is currently tested on : <br>
1. Raspberry Pi OS<br>
The testing is going on different systems.

<h1>Install and Run</h1>
1. Download or Clone the Repository.<br>
2. Move to the folder and give executable permission to the file by type the following command :<br><br>

```
chmod 700 WifiView.sh
```

3. Run the file by type :<br>

```
./WifiView.sh
```

<h1>Key Features</h1>
<b>1. Simple and clean interface.</b><br>
<b>2. Show : <ol><li>Wifi Interface</li><li>Driver of the wireless adapter</li><li>Mode</li><li>Internet Access</li></ol></b>
