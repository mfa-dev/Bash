# Java Time Zone Update for Linux

First Time after download zip file.

Copy zip file on Linux server and unzip file by root user and run patch.sh file

if you need executable command

run : chmod u+x patch.sh

then start by ./patch.sh

So, after start bash script, it will be search all JDKs that you have on your Linux server and check it has need to patch update time zone or not. if has not needed update time zone, you will be see output the message for that java version is not needed update.

In addition, if needed update time zone it do automatically update and end of the process you received the message JAVA version is update Time Zone Successfully.

If you run command again you see message JAVA version is NOT need to update Time Zone. this means is not need again run command because all JDKs ware udpated.
