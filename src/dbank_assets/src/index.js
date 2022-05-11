import { dbank } from "../../declarations/dbank"

window.addEventListener("load", function(){
  updateCurrentAmount();
})

document.querySelector("form").addEventListener("submit", async function(event){
  event.preventDefault();
  
  const inputAmount = document.getElementById("input-amount").value;
  const outputAmount = document.getElementById("withdrawal-amount").value;

  // disable submit button to avoid user clicking on submit button again and again because updating value in blockchain takes time and
  const button = document.getElementById("submit-btn")
  button.setAttribute("disabled", true);

  if(inputAmount.length !== 0) {
    await dbank.topUp(parseFloat(inputAmount));
    event.target.querySelector("#input-amount").value = "";

  }

  if(outputAmount.length !== 0) {
    await dbank.withdraw(parseFloat(outputAmount));
    event.target.querySelector("#withdrawal-amount").value = "";
  }

  // compund amount for both topUp and withdraw action
  await dbank.compound();

  updateCurrentAmount();

  // enable submit button back
  button.removeAttribute("disabled");

})

async function updateCurrentAmount() { 
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
}