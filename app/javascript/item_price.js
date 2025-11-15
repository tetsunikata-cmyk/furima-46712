// app/javascript/item_price.js

// 価格計算のセットアップを行う関数
const setupPriceCalc = () => {
  // ① 価格入力欄を取得
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // このページに価格欄がないなら何もしない

  // ② 手数料と利益を表示する要素を取得
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");


  // ③ 価格入力欄の値が変わるたびに処理を実行
  priceInput.addEventListener("input", () => {
    // 入力値を数値に変換
    const price = parseInt(priceInput.value, 10);

    // 数字じゃない（空欄など）の時は表示を消す
    if (Number.isNaN(price)) {
      addTaxPrice.textContent = "";
      profit.textContent = "";
      return;
    }

    // ④ 手数料10%を計算（小数切り捨て）
    const tax = Math.floor(price * 0.1);

    // ⑤ 利益 = 価格 − 手数料
    const gain = price - tax;

    // ⑥ 計算結果を画面に反映
    addTaxPrice.textContent = tax;
    profit.textContent = gain;
  });
};

// ⑦ ページ読み込み時に上の関数を実行
window.addEventListener("load", setupPriceCalc);
document.addEventListener("turbo:load", setupPriceCalc);
window.addEventListener("turbo:render", setupPriceCalc);