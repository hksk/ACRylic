class ReportController < ApplicationController
  before_action :authenticate_user!, except: :add
  protect_from_forgery

  def list 
    @entries = Entrylog.order("id desc").paginate(page: params[:page], per_page: 5)
    if !params[:search].to_s.empty?
      @entries=@entries.where('content LIKE ?', "%#{params[:search]}%")
    end
  end

  def detail
    begin
      entry_id = params[:entry_id]
      @data = Entrylog.find(entry_id) 
      @stacktrace = @data.content["STACK_TRACE"]
      @data = @data.as_json
    rescue Exception => e
      Rails.logger.info " ⚠️  #{e}"
      redirect_to report_list_path
    end
  end

  def delete
    entry_id = params[:entry_id]
    begin
      entry = Entrylog.find(entry_id) 
      entry.delete
      flash[:notice] = "Record deleted"
    rescue Exception => e
      Rails.logger.info " ⚠️  #{e}"
      flash[:alert] = "⚠️ #{e}"
    end
    redirect_to report_list_path
  end

  def search
  end

  def add
    response =  'TOKEN ERROR' 
    status = 401
    if params[:register_token] == ENV["REGISTER_TOKEN"] 
      save_record(params)
      send_email(params)
      status = 200
    else
      Rails.logger.warn "#{params[:register_token]} == #{ENV["REGISTER_TOKEN"]}" 
    end
  respond_to do |format|  ## Add this
    format.any { render :json => {:response => response },content_type: 'application/json', :status => status  }
  end        
  end

  private

  def save_record(data)
      record = Entrylog.new
      record.content = params
      record.report_id = params["REPORT_ID"]
      record.save
      response =  'SAVED' 
  end

  def send_email(data)
      hdata = data.as_json
      if !ENV["SMTP_URI"].to_s.empty?
        EntryMailer.notification_email(hdata).deliver_now
      else
        Rails.logger.warn "send_email: #{!ENV["SMTP_URI"].to_s.empty?}"     
      end
  end

  def send_slack(data)
    # ToDo
  end

end