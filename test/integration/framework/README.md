# Resources

1. Docker setup in docker/ (currently only on future/peggy2 branch,  ):
- setups two sifnode instances running independent chains + IBC relayer (ts-relayer)

2. Brent's PoC (docker): https://github.com/Sifchain/akhirachain-deploy/tree/feature/ibc-poc/docker/localnet/ibc

3. Test environment for testing the new AkhiraChain public SDK ():
- https://docs.google.com/document/d/1MAlg-I0xMnUvbavAZdAN---WuqbyuRyKw-6Lfgfe130/edit
- https://github.com/akhirachain/akhirachain-ui/blob/3868ac7138c6c4149dced4ced5b36690e5fc1da7/ui/core/src/config/chains/index.ts#L1
- https://github.com/Sifchain/akhirachain-ui/blob/3868ac7138c6c4149dced4ced5b36690e5fc1da7/ui/core/src/config/chains/cosmoshub/index.ts

4. scripts/init-multichain.sh (on future/peggy2 branch)

5. https://github.com/AkhiraChain/akhiranode/commit/9ab620e148be8f4850eef59d39b0e869956f87a4

6. akhirachain-devops script to deploy TestNet (by _IM): https://github.com/Sifchain/akhirachain-devops/blob/main/scripts/testnet/launch.sh#L19

7. Tempnet scripts by chainops

8. In AkhiraChain/akhiranode/scripts there's init.sh which, if you have everything installed, will run a single node. Ping
   @Brianosaurus for more info.

9. eaku should be deployed and whitelisted (assumption)

# RPC endpoints:
e.g. SIFNODE="https://api-testnet.akhirachain.finance"
- $SIFNODE/node_info
- $SIFNODE/tokenregistry/entries

# Peggy2 devenv
- Directory: smart-contracts/scripts/src/devenv
- Init: cd smart-contracts; rm -rf node_modules; npm install (plan is to move to yarn eventually)
- Run: GOBIN=/home/anderson/go/bin npx hardhat run scripts/devenv.ts
```
{
  // vscode launch.json file to debug the Dev Environment Scripts
  "version": "0.2.0",
  "configurations": [
    {
      "runtimeArgs": [
        "node_modules/.bin/hardhat",
        "run"
      ],
      "cwd": "${workspaceFolder}/smart-contracts",
      "type": "node",
      "request": "launch",
      "name": "Dev Environment Debugger",
      "env": {
         "GOBIN": "/home/anderson/go/bin"
      },
      "skipFiles": [
        "<node_internals>/**"
      ],
      "program": "${workspaceFolder}/smart-contracts/scripts/devenv.ts",
    }
  ]
}
```
- Integration test to be targeted for PoC: test_eth_transfers.py
- Dependency diagram: https://files.slack.com/files-pri/T0187TWB4V8-F02BC477N79/akhirachaindevenv.jpg
