              format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
                        message: 'は全角で入力してください' },
              allow_blank: true
    validates :last_name_kana,
              format: { with: /\A[ァ-ヶー]+\z/,
                        message: 'は全角カタカナで入力してください' },
              allow_blank: true
    validates :first_name_kana,
              format: { with: /\A[ァ-ヶー]+\z/,
                        message: 'は全角カタカナで入力してください' },
              allow_blank: true
    validates :birth_date
  end

  # パスワードは Devise が必須/6文字以上を見てくれるので、
  # ここでは「半角英数字混合」のチェックだけ、空欄はスキップ
  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
                      message: 'は半角英数字混合で入力してください' },
            allow_blank: true
end
