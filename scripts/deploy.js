const deploy = async () => {
  const [deployer] = await ethers.getSigners();
  //Address is given by Infura from the previously configured project
  console.log("Deploying contract with the account: ", deployer.address);
  const PlatziPunks = await ethers.getContractFactory("PlatziPunks");
  const deployed = await PlatziPunks.deploy(10000);
  //This is the address of the new contract in the selected network
  console.log("platziPunks is deployed at: ", deployed.address);
};

deploy()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
