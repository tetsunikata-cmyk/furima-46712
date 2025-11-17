const setupPriceCalc = () => {
  
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; 

  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);

    if (Number.isNaN(price)) {
      addTaxPrice.textContent = "";
      profit.textContent = "";
      return;
    }

    const tax = Math.floor(price * 0.1);
    const gain = price - tax;

    addTaxPrice.textContent = tax;
    profit.textContent = gain;
  });
};

window.addEventListener("load", setupPriceCalc);
document.addEventListener("turbo:load", setupPriceCalc);
window.addEventListener("turbo:render", setupPriceCalc);