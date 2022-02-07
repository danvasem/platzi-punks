const { expect } = require("chai");

describe("Platzi Punks Contracts", () => {
  const setup = async ({ maxSupply = 10000 }) => {
    const [owner] = await ethers.getSigners();
    const PlatziPunks = await ethers.getContractFactory("PlatziPunks");
    const deployed = await PlatziPunks.deploy(maxSupply);

    return { owner, deployed };
  };
  describe("Deployment", () => {
    it("Sets max supply to max params", async () => {
      const maxSupply = 4000;
      const { deployed } = await setup({ maxSupply });
      const returnedMaxSupply = await deployed.maxSupply();
      expect(maxSupply).to.equal(returnedMaxSupply);
    });
  });
  describe("Minting", () => {
    it("Mints a new token and assigns it to owner", async () => {
      const { owner, deployed } = await setup({});
      await deployed.mint();
      const ownerOfMinted = await deployed.ownerOf(0);
      expect(ownerOfMinted).to.equal(owner.address);
    });
  });
  describe("Has a minting Limit", () => {
    it("Check miniting limit is working", async () => {
      const { deployed } = await setup({ maxSupply: 2 });
      //Mint All
      await Promise.all([deployed.mint(), deployed.mint()]);
      //Assert the last minting
      await expect(deployed.mint()).to.be.revertedWith("No PLatziPunks left :(");
    });
  });
  describe("TokenURI", () => {
    it("Returns valid Metadata", async () => {
      const { deployed } = await setup({});
      await deployed.mint();
      const tokenURI = await deployed.tokenURI(0);
      const stringifiedTokenURI = await tokenURI.toString();
      const [, base64JSON] = stringifiedTokenURI.split("data:application/json;base64,");
      const stringifiedMetadata = await Buffer.from(base64JSON, "base64").toString("ascii");
      const metadata = JSON.parse(stringifiedMetadata);
      expect(metadata).to.have.all.keys("name", "description", "image");
    });
  });
});
