// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Gym {
     address private owner;

     struct gymActivity {
        string name;
        uint credits;
    }
    struct Clients {
        string name;
        uint credits;
        
    }

    mapping(address => uint) clientsAddress;
    mapping(address => uint) creditsAddress;

    mapping(string => uint) creditsClass;

    constructor(){
        owner = msg.sender;
    }

    gymActivity[] public classes;
    Clients[] public clients;

    function addClass(string memory _name, uint _credits) public {
    require(msg.sender == owner, "Solo el admin puede agregar clases");
    classes.push(gymActivity(_name, _credits)); 
    }


    function newClient(string memory _name, uint _credits) public payable{
        creditsAddress[msg.sender] = _credits;
        clients.push(Clients(_name, _credits));
    }

    function viewCredits(address _client) public view returns(address, uint){
        uint _clientCredits = creditsAddress[_client];
        return (_client, _clientCredits);
    }    
    
    function assistClass(string memory _name) public{ 
        require(creditsAddress[msg.sender] >= creditsClass[_name]);
        creditsAddress[msg.sender] -= creditsClass[_name];
    }

 }