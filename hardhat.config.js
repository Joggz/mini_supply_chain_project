require("dotenv").config();
require("@nomiclabs/hardhat-waffle");

const { RINKEBY_URL, ROPSTEN_URL } = process.env;

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html

// let accounts;
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();
  console.log(accounts);
  for (const account of accounts) {
    console.log(account.address);
  }
});

// const [account1, account2] = accounts;
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    hardhat: {},
    rinkeby: {
      url: RINKEBY_URL,
      accounts: [account1, account2],
    },
    ropsten: {
      url: ROPSTEN_URL,
      accounts: [account1, account2],
    },
  },
  solidity: {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  mocha: {
    timeout: 40000,
  },
};
