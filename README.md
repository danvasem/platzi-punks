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
