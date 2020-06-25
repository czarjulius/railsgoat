# frozen_string_literal: true
class BenefitFormsController < ApplicationController
  def index
    @benefits = Benefits.new
  end

  def download
    begin
      path = params[:name]
      if path == "public/docs/Dental_n_Stuff.pdf" || path == "public/docs/Health_n_Stuff.pdf"
        file = params[:type].constantize.new(path)
        send_file file, disposition: "attachment"
      else
        render json: {},status: :bad_request
      end
    rescue
      redirect_to user_benefit_forms_path(user_id: current_user.id)
    end
  end

  def upload
    file = params[:benefits][:upload]
    if file
      flash[:success] = "File Successfully Uploaded!"
      Benefits.save(file, params[:benefits][:backup])
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to user_benefit_forms_path(user_id: current_user.id)
  end
end
