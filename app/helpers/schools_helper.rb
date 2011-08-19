module SchoolsHelper
  
  def search_message(params)
    if @geocoded_address.present? && @geocoded_address.success == true && AssignmentZone.find_with_point(@geocoded_address.lat, @geocoded_address.lng).blank?
      "<div class='alert'>The address you entered &mdash; '#{@geocoded_address.street_address} #{@geocoded_address.city}, #{@geocoded_address.state}' &mdash; could not be located within the bounds of any Assignment Zone. Please try again.</div>"
    elsif params[:address].present? && @geocoded_address.success == false
      "<div class='alert'>We couldn't locate that address &mdash; please try again.</div>"
    elsif params[:address].blank? && params[:grade_level].present?
      "<div class='alert'>Please enter an address to see your eligible schools.</div>"
    end
  end
  
  def normal_results_title(params)
    if params[:grade_level].blank?
      "<h2>All Schools <span class='small nobold'>&nbsp;(#{@schools.size} results)</span></h2>"
    elsif @walk_zone_schools.present?
      "<h2>Other #{params[:grade_level]}s <span class='small nobold'>&nbsp;(#{@schools.size} results)</span></h2>"
    else
      "<h2>#{params[:grade_level]}s <span class='small nobold'>&nbsp;(#{@schools.size} results)</span></h2>"
    end
  end
end
