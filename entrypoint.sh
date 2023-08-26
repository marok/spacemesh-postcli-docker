#!/bin/bash

ID_ARG=

if [ -f "$DATA_DIR/key.bin" ]; then
	ID_ARG="-id $(cat $DATA_DIR/key.bin | tail -c 64)"
fi

set -x

clinfo -l

./postcli -printProviders

./postcli \
	-commitmentAtxId=$COMMITMENT_ATX_ID \
	-datadir=$DATA_DIR \
	-numUnits=$NUM_UNITS \
 	-provider=$PROVIDER \
	$ID_ARG
