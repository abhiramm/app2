class QualityPerformer < ActiveRecord::Base
  belongs_to :quality
  belongs_to :performer
end
