# platzi-punks

- Inicializar YARN:
  yarn init -y

- Inicializar GIT
  git init

- Instalar la dependencia de Desarrollo HardHat
  yarn add hardhat -D

- Instalar dependencias de Desarrollo de HardHat
  yarn add @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers -D

- Ejecutar hardhat y seleccionar la creación de un nuevo proyecto
  npx hardhat

- Ejecutar el proyecto de ejemplo:
  npx hardhat run scripts/sample-script.js

Despliegue del contrato utilizando INFURA en la TestNet de RINKEBY:
npx hardhat run scripts/sample-script.js --network rinkeby

- Agregar los contratos de OpenZeppelin https://docs.openzeppelin.com/contracts/4.x/
  yarn add @openzeppelin/contracts

- Depliegue del contrato PlatziPunks
  npx hardhat run scripts/deploy.js --network rinkeby

- Para solo compilar
  npx hardhat compile

- Para ejecutar los Tests
  npx hardhat test

- Para generar un único archivo con todos los contratos
  npx hardhat flatten
  npx hardhat flatten > Flattened.sol
