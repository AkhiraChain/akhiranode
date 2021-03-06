module.exports = async (cb) => {
    const Web3 = require("web3");
    const BigNumber = require("bignumber.js")
    const HDWalletProvider = require("@truffle/hdwallet-provider");
    try {
        const contract = await artifacts.require("BridgeToken");

        /*******************************************
         *** Constants
         ******************************************/
        const NETWORK_ROPSTEN =
            process.argv[4] === "--network" && process.argv[5] === "ropsten";
        let account, token
        if (NETWORK_ROPSTEN) {
            account = process.argv[6].toString();
            token = (process.argv[7] || 'eth').toString();
        } else {
            account = process.argv[4].toString();
            token = (process.argv[5] || 'eth').toString();
        }

        if (!account) {
            console.log("Please provide an Ethereum address to check their balance")
            return
        }
        /*******************************************
         *** Web3 provider
         *** Set contract provider based on --network flag
         ******************************************/
        let provider;
        if (NETWORK_ROPSTEN) {
            provider = new HDWalletProvider(
                process.env.ETHEREUM_PRIVATE_KEY,
                process.env['WEB3_PROVIDER']
            );
        } else {
            provider = new Web3.providers.HttpProvider(process.env.LOCAL_PROVIDER);
        }

        const web3 = new Web3(provider);
        contract.setProvider(web3.currentProvider);
        /*******************************************
         *** Contract interaction
         ******************************************/
        let balanceWei, balanceEth
        if (token === 'eth') {
            balanceWei = await web3.eth.getBalance(account)
            balanceEth = web3.utils.fromWei(balanceWei)
            console.log(`Eth balance for ${account} is ${balanceEth} Eth (${balanceWei} Wei)`)
            return cb();
        }


        const tokenInstance = await contract.at(token)
        const name = await tokenInstance.name()
        const symbol = await tokenInstance.symbol()
        const decimals = await tokenInstance.decimals()
        balanceWei = new BigNumber(await tokenInstance.balanceOf(account))
        balanceEth = balanceWei.div(new BigNumber(10).pow(decimals.toNumber()))
        console.log(JSON.stringify({balance: balanceWei, symbol: symbol, name: name}) + "\n");
        return cb();
    } catch (error) {
        console.error({error})
    }
};
