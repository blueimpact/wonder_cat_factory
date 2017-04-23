class Manage::CommentsController < ApplicationController
  before_action :set_product


  # GET /admin/products/1/comments
  # GET /seller/products/1/comments
  def index
    @comments = @product.comments.where.not(event_id: nil)
  end

  def new
    @comment = @product.comments.new
  end

  def create

    @comment = @product.comments.new(comment_params)

    if @comment.valid?
      @comment.save!
      Events::CommentEvent.attach!(@comment)

      redirect_to [current_role, @product, :comments],
                  notice: 'comment was successfully created.'
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
