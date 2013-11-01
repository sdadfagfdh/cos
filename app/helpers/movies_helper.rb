module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def sortable(column,title=nil,css_id,checked)
    title||=column.titleize
    checks = Hash.new
    checked.each{|c| checks[c]=1}
    link_to title, {:sort=>column}.merge({"ratings"=>checks}),{:id=>css_id}
  end
  
  def set_th_class(column)
    column == params[:sort] ? "hilite" : nil
  end
end
