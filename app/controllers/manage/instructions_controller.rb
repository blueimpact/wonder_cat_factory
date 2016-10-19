class Manage::InstructionsController < ApplicationController
  before_action :set_product
  before_action :set_instruction, only: [:edit, :update, :destroy]

  # GET /admin/instructions
  # GET /seller/instructions
  def index
    instructions = @product.instructions
                           .index_by(&:class)
    @instructions = [Instructions::DequeuedInstruction].map do |model_class|
      instructions.fetch model_class, model_class.new(product: @product)
    end
  end

  # GET /admin/instructions/new
  # GET /seller/instructions/new
  def new
    type = params.require(:type)
    @instruction = Instruction.new(type: type)
    render :edit
  end

  # GET /admin/instructions/1/edit
  # GET /seller/instructions/1/edit
  def edit
  end

  # POST /admin/instructions
  # POST /seller/instructions
  def create
    @instruction = Instruction.new(instruction_params)
    @instruction.product = @product
    if @instruction.save
      redirect_to [current_role, @product, :instructions],
                  notice: 'Instruction was successfully created.'
    else
      render :edit
    end
  end

  # PATCH/PUT /admin/instructions/1
  # PATCH/PUT /seller/instructions/1
  def update
    if @instruction.update(instruction_params.permit(:body))
      redirect_to [current_role, @product, :instructions],
                  notice: 'Instruction was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/instructions/1
  # DELETE /seller/instructions/1
  def destroy
    @instruction.destroy
    redirect_to [current_role, @product, :instructions],
                notice: 'Instruction was successfully destroyed.'
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_instruction
    @instruction = @product.instructions.find(params[:id])
  end

  def instruction_params
    params.require(:instruction).permit(:type, :body)
  end
end
