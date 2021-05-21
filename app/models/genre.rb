class Genre < ApplicationRecord
  enum genre: { "その他": 0, "ダイエット": 1, "筋トレ": 2, "スポーツ": 3, "生活": 4, "食事": 5 }


end
