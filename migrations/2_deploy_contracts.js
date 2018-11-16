var Adoption = artifacts.require("Adoption");
var BuyTickets = artifacts.require("BuyTickets")

module.exports = function(deployer) {
  deployer.deploy(Adoption);
  deployer.deploy(BuyTickets);
};