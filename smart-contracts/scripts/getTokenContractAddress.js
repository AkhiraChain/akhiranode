module.exports = async () => {
  /*******************************************
   *** Set up
   ******************************************/
  require("dotenv").config();
  const Web3 = require("web3");
  const HDWalletProvider = require("@truffle/hdwallet-provider");

  // Contract abstraction
  const truffleContract = require("truffle-contract");
  const contract = truffleContract(
    require("../build/contracts/BridgeToken.json")
  );

  console.log("Expected usage: \n truffle exec scripts/getTokenBalance.js --network ropsten");

  /*******************************************
   *** Constants
   ******************************************/
  const NETWORK_ROPSTEN =
    process.argv[4] === "--network" && process.argv[5] === "ropsten";

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
  const address = await contract.deployed().then(function(instance) {
    return instance.address;
  });

  return console.log("Token contract address: ", address);
};
