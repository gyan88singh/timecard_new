class TimeSheetsController < ApplicationController
  before_filter :authorize
  
  
  def import
   # raise params[:file1].inspect
    if (params[:file1])
    
    # begin
       TimeSheet.import(params[:file1])
        flash[:notice] = 'Time Sheet imported.'
        redirect_to employees_path
    else
    # rescue
       #flash[:notice] = 'Invalid  file format.'
              redirect_to employees_path
     end
   end
   
  def create
         @timesheets = TimeSheet.all
         @timesheet = TimeSheet.create(timesheet_params)
   end
   
   private
      def timesheet_params
        params.require(:time_sheet).permit(:WORKED_ID,
        :PAYROLL,
        :PDATE,
        :SHIFT,
        :ON_TIME,
        :OFF_TIME,
        :CODE,
        :CODE_TYPE,
        :LINE_NO,
        :PAY_TYPE,
        :DEPT_GROUP,
        :DEPARTMENT,
        :CENTRE,
        :POS,
        :DOCKET,
        :QUANTITY,
        :STD_RATE,
        :HOURS,
        :HOUR_TYPE,
        :NO_OT_REC,
        :JOB_PREM,
        :AM_PREM_HR,
        :PM_PREM_HR,
        :CALC_FLAG,
        :STATUS,
        :WAS_LL,
        :OT_TYPE,
        :NOERASE,
        :CLK_ON,
        :CLK_OFF,
        :UDF1,
        :UDF2,
        :NOTE,
        :CENTRE1,
        :POS1,
        :RDOCKET,
        :TDEFAULT,
        :FLAG1,
        :FLAG2,
        :FLAG3,
        :FLAG4,
        :FLAG5,
        :RATE,
        :AM_PREM_RATE,
        :PM_PREM_RATE,
        :JOB_ID,
        :UDF_KEY,
        :OPERATION,
        :UDF3,
        :UDF4,
        :PIECE_RATE,
        :WORK_ORDER_ID,
        :WORK_ITEM_ID,
        :WOI_CONTROL,
        :APPROVED_STATUS,
        :APPROVED_BY,
        :APPROVED_TIME,
        :EXT_ATTR_1,
        :EXT_ATTR_2,
        :EXT_ATTR_3,
        :EXT_ATTR_4,
        :EXT_ATTR_5,
        :EXT_ATTR_6,
        :EWA_1,
        :EWA_2,
        :EWA_3,
        :EWA_4,
        :EWA_5,
        :EWA_6,
        :EWA_7,
        :EWA_8,
        :EWA_9,
        :EWA_10,
        :EWA_11,
        :EWA_12,
        :EWA_13,
        :EWA_14,
        :EWA_15,
        :EWA_16,
        :EWA_17,
        :EWA_18,
        :EWA_19,
        :EWA_20)
      end
   
end
