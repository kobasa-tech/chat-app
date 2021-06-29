class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one_attached :image

  validates  :content, presence: true, unless: :was_attached?
  # unlessオプションにメソッド名を指定し、メソッドの返り値がfalseならバリデーションによる検証を行う記述。
  # つまり画像が存在していなければ(was_attached? = false)、メッセージが空白でないかをバリデーションで検証する。
    # ⇨画像なし、メッセージなし。なら投稿できない

  def was_attached?
    self.image.attached?  # 画像自身が添付されているかを確認している
  end
end