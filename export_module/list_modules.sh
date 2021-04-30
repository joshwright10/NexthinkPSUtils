# Script allowing to generate a list of the published modules from a Nexthink portal
# file needs to have execution permissions: sudo chmod +x list_modules.sh 
# syntax : sudo ./list_modules.sh
#
#!/bin/ sh

echo
echo "==============================="
echo "list of published modules:"
echo "==============================="
echo 
cd /var/nexthink/portal/rsquery/



./exportLibraryV6.py -u *rsquery --list --published=true | grep -v " ->" | grep -v " +"|grep "|" |grep -v " name "| awk -F "|" '{ print $2 $3}'

echo "###############################"
echo
