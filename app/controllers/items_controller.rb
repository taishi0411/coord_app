class ItemsController < ApplicationController
  def index
    @items = Item.where(user_id: current_user.id)
  end

  def show
  @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.genre_id = 2
    if @item.save!
      redirect_to item_path(@item), notice: "アイテムが作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])

    if @item.user != current_user
      redirect_to posts_path, alert: "不正なアクセスです。"
    end
  end

  def update
    @item = Item.find(params[:id])
    if  @item.update(item_params)
      redirect_to item_path(@item), notice: "更新に成功しました。"
   else
    render :edit
   end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy
    redirect_to user_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image)
  end
end
