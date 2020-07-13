class ItemsController < ApplicationController
  # before_action :set_current_user_items,only:[:p_transaction,:p_exhibiting,:p_soldout]
  # before_action :set_user,only:[:p_transaction,:p_exhibiting,:p_soldout]

  def p_exhibiting #出品中のアクション
  end

  def p_transaction #取引中のアクション
  end

  def p_soldout #売却済みのアクション
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.where.not(id: @item.id).where(category_id: @item.category_id)
  end

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def buy
  end
  
  def new
    @item = Item.new
    @item.images.build()
  end

  def create
    @item = Item.new(item_params)
    binding.pry
    if @item.save
      respond_to do |format|
        format.html{redirect_to root_path}
      end
    else
      redirect_to new_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  # def create
  #   @message = @group.messages.new(message_params)
  #   if @message.save
  #     respond_to do |format|
  #       format.json
  #     end
  #   else
  #     @messages = @group.messages.includes(:user)
  #     flash.now[:alert] = 'メッセージを入力してください。'
  #     render :index
  #   end
  # end

  def update
    # @item = Item.find(params[:id])
    # length = @item.images.length
    # i = 0
    # while i < length do
    #   if  item_update_params[:images_attributes]["#{i}"]["_destroy"] == "0"
    #     @item.update(item_update_params)
    #     redirect_to edit_item_path(@item.id)
    #     return
    #   else
    #     i += 1
    #   end
    # end
    # if item_update_params[:images_attributes]["#{i}"]
    #   @item.update(item_update_params)
    # end
    # redirect_to edit_item_path(@item.id)
    # return
  end

  private

  def set_current_user_products
    if user_signed_in?
      @items = current_user.products.includes(:seller, :buyer, :auction, :item_images)
    else
      redirect_to new_user_session_path
    end
  end

  def set_user
    @user = User.find(seller_id: current_user.id)
  end

  def item_params
    params.require(:item).permit(:name, :price, :produce, :deliveryfee_id, :brand_id, :category_id, :condition_id, :prefecture_id, :deliverydate_id, images_attributes: [:image, :id]).merge(seller_id: current_user.id)
  end

  def item_update_params
    params.require(:item).permit(
      :name,
      [images_attributes: [:image, :_destroy, :id]])
  end

end
