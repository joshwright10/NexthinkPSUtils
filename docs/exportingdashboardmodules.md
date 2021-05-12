# Exporting Nexthink Dashboard Modules

Nexthink Dashboard Modules can be exported via the Nexthink Portal on an individual basis, or via the CLI on the Portal Appliance.


# Exporting via CLI
The bulk export of Dashboard Modules can be done from the CLI using the following code. Login as the user 'nexthink', execute the code, then copy the files to your local device.

    # Prepare the export folder
    export_date=$(date +%Y%m%d_%H%M)
    export_folder="/home/nexthink/export_module/$export_date"
    echo "creating export folder: $export_folder"
    mkdir -p $export_folder
    cd $export_folder

    # Generate modules list to allmodules.txt file
    /var/nexthink/portal/rsquery/exportLibraryV6.py -u *rsquery --list --published=true | grep -v " ->" | grep -v " +"|grep "|" |grep -v " name "| awk -F "|" '{gsub(/\s/,"",$3); print $2 $3}' > allmodules.txt

    # process export for each module into an independent xml file
    while read line
    do
     read -a strarr <<< "$line"
     export_moduleuid="${strarr[0]}"
     export_modulename="${strarr[1]}"
     echo "exporting module $export_moduleuid to $export_folder/module_$export_modulename.xml "
     /var/nexthink/portal/rsquery/exportLibraryV6.py --export --moduleUid="$export_moduleuid" --exportfilename=module_$export_modulename.xml
    done < allmodules.txt

    # end of export
