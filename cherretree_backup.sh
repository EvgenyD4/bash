#!/bin/bash
if ping -c 1 192.168.0.100 &> /dev/null;
 then cd /data/cherretree
      find . -type f \( -iname "*.ctb" -or -iname "*.ctd" \) \
       -printf %P\\0 | rsync -vh -e ssh --files-from=- --from0 . \
       user@192.168.0.100:/Backup/user/
fi
