module SiegesHelper
  def active_siege_or_not(siege)
    if siege == session[:siege]
      "Active"
    else
      link_to "Activate!", activate_siege_path(siege)
    end
  end
end
