class DeliveryTimePerformers < ActiveRecord::Base
  belongs_to :delivery_time
  belongs_to :performer
end
