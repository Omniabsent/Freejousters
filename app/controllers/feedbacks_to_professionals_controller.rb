class FeedbacksToProfessionalsController < ApplicationController

  def to_rejected_professionals
    @feedback = FeedbacksToProfessional.new
  end

end
