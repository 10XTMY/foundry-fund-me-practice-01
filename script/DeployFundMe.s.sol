// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    FundMe fundMe;
    HelperConfig helperConfig;

    // function run() public payable {
    //     vm.startBroadcast();
    //     fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    //     vm.stopBroadcast();
    // }

    function run() external returns (FundMe) {
        helperConfig = new HelperConfig();
        address priceFeed = helperConfig.activeNetworkConfig();
        vm.startBroadcast(); // anything after startBroadcast is a real transaction
        // all the code before startBroadcast is just a simulation, no gas used
        fundMe = new FundMe(priceFeed);
        vm.stopBroadcast();
        return fundMe;
    }

    function check() public view returns (bool) {
        return address(fundMe) != address(0);
    }
}
