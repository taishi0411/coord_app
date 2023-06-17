class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def top
  end

  def index
    @clean_index = params[:clean_index].to_i
    @heat_index = params[:heat_index].to_i
     selected_items = select_items(@clean_index, @heat_index)
     
     
     if params[:color_select] == 'on'
      selected_items = color_select(selected_items)
    end

    @high_difference_count = count_high_difference_items(@selected_items)
  end

  private

  def select_items(clean_index, heat_index)
    items_per_genre = 1
    genre_ids = [2, 4, 6]
    genre_ids += [1, 5, 7] if rand(2).zero?
    clean_index_avg = clean_index
    heat_index_avg = heat_index
    genre_ids << 3 if @temperature_celsius < 16 || heat_index_avg >= 6

    @selected_items = []

    genre_ids.each do |genre_id|
      genre_items = current_user.items.where(genre_id: genre_id).where.not(id: @selected_items.map(&:id)).to_a
      genre_items.shuffle!(random: SecureRandom)

      if genre_items.size > 0
        selected_item = nil
        closest_clean_index_avg = nil
        closest_difference = nil

        genre_items.each do |item|
          selected_items_with_genre = @selected_items.select { |selected_item| selected_item.genre_id == genre_id }
          clean_index_sum = selected_items_with_genre.sum(&:clean_index)
          clean_index_avg = (clean_index_sum + item.clean_index) / (selected_items_with_genre.size + 1)
          difference = (clean_index_avg - clean_index).abs

          if closest_clean_index_avg.nil? || difference < closest_difference
            selected_item = item
            closest_difference = difference
            closest_clean_index_avg = clean_index_avg
          end
        end

        @selected_items << selected_item
      end
    end

    remaining_items = current_user.items.where.not(id: @selected_items.map(&:id)).to_a
    remaining_items.shuffle!(random: SecureRandom)

    remaining_items.each do |item|
      break if @selected_items.size >= items_per_genre

      @selected_items << item
    end

    @selected_items.shuffle!(random: SecureRandom)
  end


  def color_select(selected_items)
    high_difference_items = selected_items.select { |item| item.color_difference >= 40 }
    high_difference_count = high_difference_items.count

    if high_difference_count.zero?
      selected_genres = selected_items.map(&:genre_id)
      random_genre_id = selected_genres.sample

      exchange_items = find_exchange_items(selected_items, random_genre_id)

      if exchange_items.empty?
        available_genres = (1..7).to_a - selected_genres.uniq

        available_genres.each do |genre_id|
          exchange_items = find_exchange_items(selected_items, genre_id)
          break unless exchange_items.empty?
        end
      end

      unless exchange_items.empty?
        item_to_exchange = exchange_items.sample
        item_to_replace = selected_items.find { |item| item.genre_id == random_genre_id && item.color_difference < 40 }
        selected_items[selected_items.index(item_to_replace)] = item_to_exchange
      end
    end

    selected_items
  end
  
  def find_exchange_items(selected_items, genre_id)
    Item.where(genre_id: genre_id).where('color_difference >= 40')
  end

  def count_high_difference_items(items)
    items.count { |item| item.color_difference >= 40 }
  end

end