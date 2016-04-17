class HomeController < ApplicationController
  def index
    @accounts = Account.all
  end
  
  def add_account

    account = Account.find_by username: params[:username]

    account_doesnt_exisits = account == nil
    
    if account_doesnt_exisits
    
      FetchByUsernameJob.perform_later params[:username]
      
      
      respond_to do |format|
          format.html { render :text => "account " + params[:username] + " has been added to the process queue" }
      end

    else

        respond_to do |format|
            format.html { render :text => "account " + params[:username] + " already exisits" }
        end

    end
    
  end
end
