// app/javascript/card.js

const setupPayjp = () => {
  // 購入フォームがないページでは何もしない
  const form = document.getElementById("charge-form");
  if (!form) return;

  console.log("card.js loaded");

  // ① 公開鍵をmetaタグから取得
  const publicKeyMeta = document.querySelector('meta[name="payjp-public-key"]');
  if (!publicKeyMeta) {
    console.error("PAYJP 公開鍵の meta タグが見つかりません");
    return;
  }
  const publicKey = publicKeyMeta.getAttribute("content");

  // ② PAY.JPオブジェクト＆Elementsを初期化
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  // ③ テンプレに用意された3つの枠に、PAY.JPの入力欄をマウント
  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  // ④ フォーム送信時（購入ボタン押したとき）の処理
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // いったん本来の送信は止める

    console.log("submit event fired");

    // ⑤ PAY.JP にカード情報を送り、トークンを作ってもらう
    payjp.createToken(numberElement).then((response) => {
      console.log("PAY.JP response:", response);

      if (response.error) {
        alert("カード情報が正しくありません");
        console.error(response.error);
      } else {
        const token = response.id; // ★ これがトークン本体

        // ⑥ hidden の token フィールドに詰める
        let tokenField = document.getElementById("card-token");
        if (!tokenField) {
          // 万が一無かったらここで作る
          tokenField = document.createElement("input");
          tokenField.setAttribute("type", "hidden");
          tokenField.setAttribute("name", "token");
          tokenField.setAttribute("id", "card-token");
          form.appendChild(tokenField);
        }
        tokenField.value = token;

        // ⑦ カード入力欄はサーバーには送られない（ElementsのiframeなのでOK）
        // そのままフォーム送信
        form.submit();
      }
    });
  });
};

// Turbo + 通常ロード両対応
document.addEventListener("turbo:load", setupPayjp);
//window.addEventListener("load", setupPayjp);