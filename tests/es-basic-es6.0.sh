#!/bin/bash
# This file is part of the rsyslog project, released under ASL 2.0
export ES_DOWNLOAD=elasticsearch-6.0.0.tar.gz
. $srcdir/diag.sh download-elasticsearch
. $srcdir/diag.sh stop-elasticsearch
. $srcdir/diag.sh start-elasticsearch

#  Starting actual testbench
. $srcdir/diag.sh init
# . $srcdir/diag.sh es-init
. $srcdir/diag.sh startup es-basic.conf
. $srcdir/diag.sh injectmsg  0 10000
. $srcdir/diag.sh shutdown-when-empty
. $srcdir/diag.sh wait-shutdown 
. $srcdir/diag.sh es-getdata 10000 19200
# stop elasticsearch engine in any case
. $srcdir/diag.sh stop-elasticsearch

. $srcdir/diag.sh seq-check  0 9999
. $srcdir/diag.sh exit
