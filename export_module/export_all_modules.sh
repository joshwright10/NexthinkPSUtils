# Script allowinf to export each published portal module as a separate xml file
# File needs execution permissions: sudo chmod +x export_all_modules.sh
#
# syntax : ./export_all_modules.sh
#
#!/bin/ sh

# create an export folder with current date and time
echo "=========================================================================="
export_date=$(date +%Y%m%d_%H%M)
echo "creating export folder:  /home/nexthink/export_module/$export_date"
mkdir $export_date
cd $export_date
echo "=========================================================================="

# Generate modules list to allmodules.txt file
/var/nexthink/portal/rsquery/exportLibraryV6.py -u *rsquery --list --published=true | grep -v " ->" | grep -v " +"|grep "|" |grep -v " name "| awk -F "|" '{gsub(/\s/,"",$3); print $2 $3}' > allmodules.txt

# process export for each module into an independant xml file
while read line
do
 ../export_module.sh $line $export_date
done < allmodules.txt

# end of export
echo done.
echo "=========================================================================="
echo "modules exported to folder: /home/nexthink/export_module/$export_date" 
echo "=========================================================================="
echo ""
