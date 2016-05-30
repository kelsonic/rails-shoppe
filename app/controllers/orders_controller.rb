class OrdersController < ApplicationController

  include UsersHelper
  include CartsHelper
  include OrdersHelper

  def index
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
    @total_cost = calculate_order_total(@order)
  end

  def new
    @cart_products = get_prods_and_qty
    @total_cost = get_order_total
  end

  def create
    @order = Order.create(total: get_order_total, user_id: current_user.id)

    create_order(@order)
    client = SendGrid::Client.new do |c|
        c.api_key = ENV["SENDGRID_SECRET_KEY"]
    end
    session[:products] = nil

    respond_to do |format|
      if @order.save
        mail = SendGrid::Mail.new do |m|
          m.to = current_user.email
          m.from = 'sales@robotshoppee.com'
          m.subject = "Thank you for your order #{@order.id}"
          m.text = "Thank you for placing your order with the best Robot Shoppee on the interwebs.  Please come again."
        end
        res = client.send(mail)
        puts res.code
        puts res.body
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

end
