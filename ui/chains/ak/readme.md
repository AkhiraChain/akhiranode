For reference when playing with cosmos cain

# Create liquidity pool catk:aku

```
./akhiranoded tx clp create-pool \
 --from akasha \
 --symbol catk \
 --nativeAmount 500 \
 --externalAmount 500
```

# Create liquidity pool cbtk:aku

```
./akhiranoded tx clp create-pool \
 --from akasha \
 --symbol cbtk \
 --nativeAmount 500 \
 --externalAmount 500
```

# Verify pool created

```
./akhiranoded query clp pools
```

# Execute swap

```
./akhiranoded tx clp swap \
 --from shadowfiend \
 --sentSymbol catk \
 --receivedSymbol cbtk \
 --sentAmount 20
```
