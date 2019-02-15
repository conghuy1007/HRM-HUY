class UsersController < ApplicationloginController
    def new
        @user = User.new
      end
    
      def create   
        @user = User.new(user_params)  
        @user.role_id = 0
        @user.isActivated = 0
        #get data 
        name = params[:users][:name]
        password = params[:users][:password]
        password_confirmation = params[:users][:password_confimation]
        email = params[:users][:email]
        nameValid = name.match(/\A[a-zA-Z0-9]{1,50}\z/)
        emailValid = email.downcase.match(/\A[^\s@]+@((?!gmail|yahoo|outlook).)+\.[^\s@]+\z/)
        usernameDb = User.find_by(name: name)
        emailDb = User.find_by(email: email)
        
        # validate data
        formValid = {
          :status => true,
          :msg => ""
        }
        if nameValid.nil?
          formValid = {
            :status => false,
            :msg => "Username is invalid . Please try another name !!!"
          }
        elsif !usernameDb.nil?
          formValid = {
            :status => false,
            :msg => "This username has been used . Please try another name !!!"
          }
        elsif !emailDb.nil?
          formValid = {
            :status => false,
            :msg => "This email has been used . Please try another email !!!"
          }
        # elsif emailValid.nil?
        #   formValid = {
        #     :status => false,
        #     :msg => "Email is invalid . Please try another email !!!"
        #   }
        elsif password != password_confirmation
          formValid = {
            :status => false,
            :msg => "Password confirmation doesn't match . Please try again !!!"
          }
        elsif password.length < 8
          formValid = {
            :status => false,
            :msg => "Password contain at least 8 characters . Please try again !!!"
          }
        end  
      
        # @user.transaction do
        #    begin
        #       # res, msg =  User.isUsernameNotExisted?(@user.name)
                                    
        #       # if res == true
        #         if formValid[:status] == true
        #           if @user.save
        #             @user.set_key
        #             @user.save(validates: false)   
                    
        #             #create username folder as Resources folder in Webserver after created user successfull
        #             if create_folder? "resources/#{@user.name}"              
        #               commitSvnWithAdd Rails.root.join('resources'), @user.name, "Commit new user"                
        #               UserMailer.registration_confirmation(@user).deliver_now 
        #               flash[:success] = "Please confirm your email address to continue"
    
        #               redirect_to activate_index_path
        #             else              
        #               flash[:error] = 'Create user folder failed !!!'
        #               redirect_to signup_path
        #             end
        #           else
        #             flash[:error] = 'Getting Error, please try again later.'
        #             render 'new'
        #           end
        #         else
        #           flash[:error] = formValid[:msg]
        #           render 'new'
        #         end    
        #       # else
        #       #   flash[:error] = msg
        #       #   redirect_to signup_path
        #       # end
        #   rescue Exception => e
        #     unless delete_folder? "resources/#{@user.name}"
        #       flash[:error] = 'Delete user folder failed !!!'
        #       redirect_to signup_path
        #     end
        #     flash[:error] = 'Created failed !!!'
        #     redirect_to signup_path
        #     raise ActiveRecord::Rollback
        #   end
        # end
      end
    
      
      private
        def user_params
          params.require(:users).permit(:name, :role_id, :email, :password, :password_confirmation)
        end
end
