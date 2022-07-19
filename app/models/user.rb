class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :nickname, presence: true
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, allow_blank: true },
            presence: true
  validates :family_name,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, allow_blank: true },
            presence: true
  validates :first_name,
            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, allow_blank: true },
            presence: true
  validates :family_kana,
            format: { with: /\A[ァ-ヶー－]+\z/, allow_blank: true },
            presence: true
  validates :first_kana,
            format: { with: /\A[ァ-ヶー－]+\z/, allow_blank: true },
            presence: true
  validates :birthday, presence: true

  has_many :items
  has_many :orders
  has_many :sns_credentials
  
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )

    # userが登録済みであるか判断
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }

   end
end
