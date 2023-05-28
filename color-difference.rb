# ３つの値を取得
puts "1つ目の値を入力してください:"
value1 = gets.chomp.to_i

puts "2つ目の値を入力してください:"
value2 = gets.chomp.to_i

puts "3つ目の値を入力してください:"
value3 = gets.chomp.to_i

# 最大値と最小値を見つける
min_value = [value1, value2, value3].min
max_value = [value1, value2, value3].max

# 最小値と最大値の差を変数に格納
difference = max_value - min_value

# 変数を出力
puts "最小値: #{min_value}"
puts "最大値: #{max_value}"
puts "差: #{difference}"
