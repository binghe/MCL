#!/bin/sh

# This doesn't try to fix type/creator info for random MCL text files
# that aren't needed to build MCL.

find . -name '*isp' -exec /Developer/Tools/SetFile -t TEXT -c CCL2 {} \;
/Developer/Tools/SetFile -t TEXT -c 'MPS ' pmcl/*.[chsr]
/Developer/Tools/SetFile -t HELP -c CCL2 'MCL Help'

# Copy the resource fork of argument 1 from the file in .resource-forks
# in which it was saved; use arguments 2 and 3 to set type/creator.
function joinfile {
 cat ".resource-forks/$1" > "$1/rsrc"
 /Developer/Tools/SetFile -t $2 -c $3 "$1"
}

joinfile OpenTransportSupport "shlb" "cfrg"
joinfile pmcl-kernel "shlb" "????"
joinfile PPCCL "APPL" "CCL2"
joinfile pmcl/siow_resources "RSRC" "RSED"
joinfile examples/contextual-menu-cursor.rsrc "RSRC" "RSED"
joinfile library/"MCL Background.rsrc" "RSRC" "RSED"
joinfile library/cursors.rsrc "RSRC" "RSED"



