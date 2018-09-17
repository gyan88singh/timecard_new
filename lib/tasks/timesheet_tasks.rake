desc 'send timesheet excel'

task send_timesheet_excel: :environment do
  # ... set options if any
  TimeSheet.import_excel_sheet_ftp
end
