class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:top]
  def top
  end

  def index
    clean_index = params[:clean_index].to_i
    heat_index = params[:heat_index].to_i
    select_items(clean_index, heat_index)
  end


  private
  def select_items(clean_index,heat_index)
    items_per_genre = 1
    genre_ids = [2, 4, 6]
    genre_ids += [1, 5, 7] if rand(2).zero?
    clean_index_avg = clean_index
    heat_index_avg = heat_index
    genre_ids << 3 if @temperature_celsius < 16 || heat_index_avg >= 6


    @selected_items = []

    genre_ids.each do |genre_id|
      genre_items = Item.where(genre_id: genre_id).where.not(id: @selected_items.map(&:id)).to_a
      genre_items.shuffle!(random: SecureRandom)

      if genre_items.size > 0
        selected_item = genre_items.min_by do |item|
          (item.clean_index - clean_index_avg).abs + (item.heat_index - heat_index_avg).abs
        end

        @selected_items << selected_item
      end
    end

    remaining_items = Item.where.not(id: @selected_items.map(&:id)).to_a
    remaining_items.shuffle!(random: SecureRandom)

    remaining_items.each do |item|
      break if @selected_items.size >= items_per_genre

      @selected_items << item
    end

    @selected_items.shuffle!(random: SecureRandom)
  end

end
