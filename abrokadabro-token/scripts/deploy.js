const hre = require("hardhat");

async function main() {
  const initialSupply = hre.ethers.parseEther("1000000"); // 1 million tokens

  const Abrokadabro = await hre.ethers.getContractFactory("Abrokadabro");
  const abrokadabro = await Abrokadabro.deploy(initialSupply);

  await abrokadabro.waitForDeployment();

  console.log("Abrokadabro deployed to:", await abrokadabro.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});