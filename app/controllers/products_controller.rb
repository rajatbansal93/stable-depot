class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if(params[:id])
      @products = Product.where(category_id: params[:id])
    else
      @products = Product.all
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    unless params[:product][:picture].nil?
      save_image()
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: t(:product_created) }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    unless params[:product][:picture].nil?
      save_image()
    end
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: t(:product_updated) }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: t(:product_destroyed) }
      format.json { head :no_content }
    end
  end

  def who_bought
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom
      end
    end
  end

  private

    def save_image
      images = params[:product][:picture]
      images.each do |image|
        File.open(Rails.root.join('public','product_images', image.original_filename), 'wb') do |file|
          file.write(image.read)
        end
        @image = @product.images.build(url: image.original_filename)
      end

    end

    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description, :image_url, :price,
        :discount_price, :permalink, :enabled, :category_id, :picture)
    end
end
