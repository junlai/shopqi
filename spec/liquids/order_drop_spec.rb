#encoding: utf-8
require 'spec_helper'

describe OrderDrop do
  let(:shop) { Factory(:user).shop }
  let(:customer){ Factory(:customer_liwh, shop: shop)}
  let(:order) { Factory(:order_liwh, shop: shop, customer: customer)}
  let(:order_drop) { OrderDrop.new order}

  it 'should get the order based delegate attributes for order_drop' do
    variant = "{{ order.id }}"
    liquid(variant).should eql "#{order.id}"

    variant = "{{ order.name }}"
    liquid(variant).should eql "#{order.name}"

    variant = "{{ order.order_number }}"
    liquid(variant).should eql "#{order.order_number}"

    variant = "{{ order.shipping_rate }}"
    liquid(variant).should eql "#{order.shipping_rate}"
  end

  it 'should get financial_status' do
    variant = "{{ order.financial_status }}"
    liquid(variant).should eql "#{order.financial_status_name}"
  end

  it 'should get fulfillment_status' do
    variant = "{{ order.fulfillment_status }}"
    liquid(variant).should eql "#{order.fulfillment_status_name}"
  end

  it 'should get customer_url' do
    variant = "{{ order.customer_url }}"
    liquid(variant).should eql "/account/orders/#{order.token}"
  end

  it 'should get subtotal_price' do
    variant = "{{ order.subtotal_price }}"
    liquid(variant).should eql "#{order.total_line_items_price}"
  end

  private
  def liquid(variant, assign = {'order' => order_drop})
    Liquid::Template.parse(variant).render(assign)
  end

end


