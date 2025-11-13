class User < ApplicationRecord
  # Devise の標準バリデーション（email / password の必須・文字数など）
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ★必須チェックだけ見るカラム
  with_options presence: true do
    validates :nickname
    validates :birth_date
  end

  # ★氏名（全角）の必須＆形式チェック
  validates :last_name, presence: true
  validates :last_name,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
                      message: 'は全角で入力してください' },
            allow_blank: true

  validates :first_name, presence: true
  validates :first_name,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
                      message: 'は全角で入力してください' },
            allow_blank: true

  # ★フリガナ（全角カタカナ）の必須＆形式チェック
  validates :last_name_kana, presence: true
  validates :last_name_kana,
            format: { with: /\A[ァ-ヶー]+\z/,
                      message: 'は全角カタカナで入力してください' },
            allow_blank: true

  validates :first_name_kana, presence: true
  validates :first_name_kana,
            format: { with: /\A[ァ-ヶー]+\z/,
                      message: 'は全角カタカナで入力してください' },
            allow_blank: true

  # ★パスワードは Devise が必須＆6文字以上を見てくれるので、
  #   ここでは「半角英数字混合」のチェックだけ
  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                      message: 'は半角英数字混合で入力してください' },
            allow_blank: true
end
