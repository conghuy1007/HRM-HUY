module SessionsHelper
    def sign_in(user)
        if user.isActivated == true
            session[:user_id] = user.id
            self.current_user = user            
        end
        
        
    end

    #setter
    def current_user=(user)
        @current_user = user
    end

    #getter
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def current_user?(user)
        user == current_user
    end
    
    def signed_in?
        !current_user.nil?
    end
    
    def sign_out
        session.delete(:user_id) 
        self.current_user = nil
    end  
    
    def deny_access
        redirect_to root_path, :notice => "Please sign in to access this page"
    end
    
    def is_admin?
        self.current_user.role.name == "Admin"
    end

    def is_freeMember?
        self.current_user.role.name == "Member"
    end

    # def isMemberHasPermissionToCreateData(input)
    #     listDataFiles = []
    #     if is_freeMember?
    #         case input
    #         when "Testsuite"                
    #             lsTestsuites = Dir.glob("resources/#{current_user.name}/*")
    #             if lsTestsuites.size >= 2
    #                 return false, "Can't create more than 2 Testsuites. Upgrading your account to create more !!!"
    #             else
    #                 return true, ""
    #             end
                
    #         when "Testcase"
    #             lsTestsuites = Dir.glob("resources/#{current_user.name}/*")
                                               
    #             lsTestsuites.each do |tsFolder|
                    
    #                 layoutFolders = Dir.glob("#{tsFolder}/Testcases/*")
    #                      #byebug
    #                      layoutFolders.each do |layoutF|
    #                         obj = {}
    #                         obj = layoutF
    #                         listDataFiles.push(obj)
    #                      end     
                                         
    #             end
    #             if listDataFiles.size >= 3
    #                 return false, "Can't create more than 3 Testcases. Upgrading your account to create more !!!"
    #             else
    #                 return true, ""
    #             end
            
    #         when "Testlayout"
    #             lsTestsuites = Dir.glob("resources/#{current_user.name}/*")
                                               
    #             lsTestsuites.each do |tsFolder|
                    
    #                 layoutFolders = Dir.glob("#{tsFolder}/Layouts/*")
    #                      #byebug
    #                      layoutFolders.each do |layoutF|
    #                         obj = {}
    #                         obj = layoutF
    #                         listDataFiles.push(obj)
    #                      end     
                                         
    #             end
    #             if listDataFiles.size >= 3
    #                 return false, "Can't create more than 3 Layouts. Upgrading your account to create more !!!"
    #             else
    #                 return true, ""
    #             end
    #         when "Testdata"
    #             lsTestsuites = Dir.glob("resources/#{current_user.name}/*")
                                               
    #             lsTestsuites.each do |tsFolder|
                    
    #                 dataFolders = Dir.glob("#{tsFolder}/TestDatas/*")
                        
    #                      dataFolders.each do |layoutF|
    #                         obj = {}
    #                         obj = layoutF
    #                         listDataFiles.push(obj)
    #                      end     
                                         
    #             end
    #             if listDataFiles.size >= 3
    #                 return false, "Can't create more than 3 Datas. Upgrading your account to create more !!!"
    #             else
    #                 return true, ""
    #             end             
    #         else
    #             return true, ""
    #         end  
    #     else
    #         return true, ""
    #     end
    # end

    
    
    def comma_numbers(number, delimiter = ',')
      number = number.round
      number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
    end
end
