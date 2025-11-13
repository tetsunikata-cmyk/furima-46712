class User < ApplicationRecord
  # Devise の標準バリデーション（email / password の必須・文字数など）
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 自分で presence を見るのは「ニックネーム・名前・生年月日」
  with_options presence: true do
    validates :nickname
    validates :birth_date

    # 名前（漢字・ひらがな・カタカナ）
    with_options format: {
      with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
      message: 'は全角で入力してください'
    } do
      validates :last_name
      validates :first_name
    end

    # 名前カナ（カタカナ）
    with_options format: {
      with: /\A[ァ-ヶー]+\z/,
      message: 'は全角カタカナで入力してください'
    } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

  # パスワードは Devise が必須/6文字以上を見てくれるので、
  # ここでは「半角英数字混合」のチェックだけ、空欄はスキップ
  validates :password,
            format: {
              with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
              message: 'は半角英数字混合で入力してください'
            },
            allow_blank: true
end
