#!/bin/bash

if [ ! -z "$NODE_ID" ]
then
	echo "Node ID provided via NODE_ID env: $NODE_ID"
	ID_ARG="-id $NODE_ID"
else
	ID_ARG=
fi

if [ -z "$ID_ARG" ] && [ -f "$DATA_DIR/key.bin" ]
then
	echo "Node ID read from key.bin: $(cat $DATA_DIR/key.bin | tail -c 64)"
	ID_ARG="-id $(cat $DATA_DIR/key.bin | tail -c 64)"
fi

GEN_POST_RANGE_ARG=
if [ ! -z "$FROM_FILE" ] && [ ! -z "$TO_FILE" ]; then
	echo "Generating only subset of files:"
	echo "	from: $FROM_FILE"
	echo "	to:   $TO_FILE"
	GEN_POST_RANGE_ARG="-fromFile $FROM_FILE -toFile $TO_FILE"
fi

set -x

clinfo -l

./postcli -printProviders

./postcli \
	-commitmentAtxId=$COMMITMENT_ATX_ID \
	-datadir=$DATA_DIR \
	-numUnits=$NUM_UNITS \
 	-provider=$PROVIDER \
	-maxFileSize=2147483648 \
	$GEN_POST_RANGE_ARG \
	$ID_ARG

sleep inf

