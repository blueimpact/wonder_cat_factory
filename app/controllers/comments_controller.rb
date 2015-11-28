class CommentsController < SellerController
  load_and_authorize_resource :product
  before_action :set_comment, only: [:destroy]

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.product = @product

    if @comment.save
      redirect_to @product, notice: 'Comment was successfully created.'
    else
      redirect_to @product, alert: 'Failed to create Comment.'
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to @product, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
