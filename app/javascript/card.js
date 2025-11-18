const setupPayjp = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKeyMeta = document.querySelector('meta[name="payjp-public-key"]');
  if (!publicKeyMeta) return;

  const publicKey = publicKeyMeta.getAttribute("content");
  if (!publicKey) return;

  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        form.submit();
        return;
      }

      const token = response.id;

      let tokenField = document.getElementById("card-token");
      if (!tokenField) {
        tokenField = document.createElement("input");
        tokenField.setAttribute("type", "hidden");
        tokenField.setAttribute("name", "token");
        tokenField.setAttribute("id", "card-token");
        form.appendChild(tokenField);
      }
      tokenField.value = token;

      form.submit();
    });
  });
};

document.addEventListener("turbo:load", setupPayjp);
document.addEventListener("turbo:render", setupPayjp);
window.addEventListener("load", setupPayjp);