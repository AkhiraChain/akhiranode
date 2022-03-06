height=$(akhiranoded --home $CHAINDIR/.akhiranoded q block | jq -r .block.header.height)
seq $height | parallel -k akhiranoded --home $CHAINDIR/.akhiranoded q block {}
