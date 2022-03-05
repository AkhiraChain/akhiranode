height=$(akiranoded --home $CHAINDIR/.akiranoded q block | jq -r .block.header.height)
seq $height | parallel -k akiranoded --home $CHAINDIR/.akiranoded q block {}
