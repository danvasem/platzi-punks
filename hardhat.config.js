require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

const RINKEBY_RPC_URL = process.env.INFURA_PROJECT_ID;
const PRIVATE_KEY = process.env.DEPLOYER_SIGNER_PRIVATE_KEY;

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks:{
    rinkeby:{
      url: `https://rinkeby.infura.io/v3/${RINKEBY_RPC_URL}`,
      accounts:[
        PRIVATE_KEY
      ]
    }
  }
};
