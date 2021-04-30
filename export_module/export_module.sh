# =============================================================
# Script allowing to export a module of dashboard from the portal 
# Requires to have listed existing modules
# This script is designed to be called from export_all_modules.sh
# argument 1: UID of the module to export
# argument 2: name of  module (without space)
# argument 3: folder into which the module is exported  e.g. 20200320_1630
# =============================================================
#
#!/bin/ sh

#echo "###############################"

echo "exporting module $1 to $pwd$3/module_$2.xml "
/var/nexthink/portal/rsquery/exportLibraryV6.py --export --moduleUid="$1" --exportfilename=module_$2.xml

