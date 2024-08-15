const hre = require("hardhat");

async function main() {
  const AbrokadabroFaucet = await hre.ethers.getContractFactory("AbrokadabroFaucet");

  const tokenAddress = "0x61D2d1e3363723bc32630c3F5Fdf424eE699F51a";

  console.log("Deploying AbrokadabroFaucet...");
  
  const faucet = await AbrokadabroFaucet.deploy(tokenAddress);

  await faucet.waitForDeployment();

  console.log("AbrokadabroFaucet deployed to:", await faucet.getAddress());
  console.log("Token address:", await faucet.token());
  console.log("Contract owner:", await faucet.owner());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });