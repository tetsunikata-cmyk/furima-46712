// app/javascript/card.js

const setupPayjp = () => {
  // フォームがないページでは何もしない
  const form = document.getElementById("charge-form");
  if (!form) return;

  // meta タグから公開鍵を取得
  const publicKeyMeta = document.querySelector('meta[name="payjp-public-key"]');
  if (!publicKeyMeta) return;

  const publicKey = publicKeyMeta.getAttribute("content");
  if (!publicKey) return;

  // PAY.JP のオブジェクト生成
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  // カード入力用の要素を作成
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  // HTML 上の指定した場所にマウント
  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  // フォーム送信時の処理
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        alert("カード情報が正しくありません");
        return;
      }

      const token = response.id;

      // hidden フィールドにトークンを埋め込む
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

// Turbo + 通常ロード両対応
document.addEventListener("turbo:load", setupPayjp);
document.addEventListener("turbo:render", setupPayjp);
window.addEventListener("load", setupPayjp);