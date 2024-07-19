// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Project1{

    uint public totalBalance;

    address payable public manager;

    mapping(address => bool) donator;

    bool public endFundraising = false;

    uint public objective;

    uint public numberOfDonators; 

    



  constructor (uint _objective){
    objective = _objective;

    manager = payable(msg.sender);

    
  }

//Donations

  function donate() public payable {
    
    require(endFundraising == false, "Fundraising is closed");
   
    require(msg.value > 0, "Donations must be greater than 0");
    
    require (totalBalance<=objective, "Objective reached, donations no longer accepted");
    
    
    totalBalance += msg.value;
    
    if(!donator[msg.sender]){
        
        donator[msg.sender] = true;
        
        numberOfDonators++;
    }
    
    if(totalBalance >= objective){
        endFundraising = true;
    }
          
    
    
  }

  // Check Objective

  function checkObjective () public view returns (bool) {
    if (totalBalance < objective) {  
      
      return false;
    } 
    else {
        return true;
        
    }
    
  }
  
  // Withdraw 

  function withdrawFunds () external  {
   
    require (msg.sender == manager, "Only the manager can withdraw funds");
   
    require (endFundraising, "Fundraising is still ongoing");
  
    manager.transfer(address(this).balance);
    
  }
   
  
  
  // Close Fundraising
  
  function closeFundraising () external  {
           
           require (msg.sender == manager, "Only the manager can close the fundraising");
           
           require (totalBalance >= objective, "Objective has not been reached yet");
        
           endFundraising = true;
    
  }
    
  
  
  
  
}