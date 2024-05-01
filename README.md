Threw this together as a quick and dirty way to lock down the SAP Privileges App to a single user.


addToAdminGroup.sh - Can be deployed via Jamf Self Service or run locally to add logged in user to to the  _localPrimaryUser group.

localPrimary.plist - Deploy via Application & Custom Settings in a Jamf Config profile
        Preference Domain - corp.sap.privileges

detectLocalPrimary.sh - Extension Atribute for Jamf to report on if the Primary User has been set.
