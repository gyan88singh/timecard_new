module ApplicationHelper
  
  def showdatetime(mydatetime)
       if mydatetime
         strdatetime=mydatetime.to_time.strftime("%d-%m-%Y %I:%M %P")
       else
         strdatetime=""
       end
       return strdatetime
     end
     
  def showdate(mydate)
      if mydate
        strdate=mydate.to_date.strftime("%B-%Y")
      else
        strdate=""
      end
      return strdate
    end    
     
     
end
