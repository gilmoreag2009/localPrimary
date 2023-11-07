#!/bin/sh

user_name=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
group_name="_localPrimaryUser"
hidden_gid=10000

#Prompt if they are the only User
PrimaryUser=$(/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -button1 "No" -windowType hud -description "Are you the sole user of this device? By selecting yes, you can lock down your device so that only your account can be elevated." -heading "Howdy!" -title "Privileges Sercurity" -button2 "Yes" -cancelButton 1 -defaultButton 2)

echo $PrimaryUser 

if [[ $PrimaryUser = 2 ]]
then
   # Check if the group already exists
   if dscl . -list /Groups | grep -q "$group_name"; then
     echo "Group $group_name already exists."
   else
     # Create the group
     sudo dseditgroup -o create -q $group_name
     sudo dscl . -create "/Groups/$group_name" PrimaryGroupID $hidden_gid
     echo "Group $group_name created with a hidden GID."
   fi
   # Add the user to the group
   sudo dseditgroup -o edit -a $user_name -t user $group_name
   echo "User $user_name added to group $group_name."
   exit 0
fi
  echo "Do not Do the thing"
exit 0
