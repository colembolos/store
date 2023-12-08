module Admin
  class PromotionsController < ApplicationController
    before_action :set_promotion, only: %i[show edit update destroy]
    before_action :authenticate_user!
    before_action :current_admin!

    def index
      @promotions = Promotion.all
    end

    def show; end

    def new
      @promotion = Promotion.new
      @products = Product.all
    end

    def edit
      @products = Product.all
    end

    def create
      @products = Product.all
      @promotion = Promotion.new(promotion_params)

      begin
        rules = JSON.parse(promotion_params[:rules]) unless promotion_params[:rules].blank?
        @promotion.rules = rules
        if @promotion.save
          redirect_to admin_promotions_url, notice: "Promotion was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      rescue JSON::ParserError
        @promotion.errors.add(:rules, 'Invalid JSON format')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @products = Product.all

      begin
        rules = JSON.parse(promotion_params[:rules]) unless promotion_params[:rules].blank?
        @promotion.assign_attributes(promotion_params)
        @promotion.rules = rules

        if @promotion.save
          redirect_to admin_promotions_url, notice: "Promotion was successfully updated."
        else
          render :edit, status: :unprocessable_entity
        end
      rescue JSON::ParserError
        @promotion.errors.add(:rules, 'Invalid JSON format')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @promotion.destroy!

      redirect_to admin_promotions_url, notice: "Promotion was successfully destroyed."
    end

    private

    def set_promotion
      @promotion = Promotion.find(params[:id])
    end

    def promotion_params
      params.require(:promotion).permit(:product_id, :promotion_type, :threshold, :rules)
    end
  end
end
