class CreateTimeSheets < ActiveRecord::Migration
  def change
    create_table :time_sheets do |t|
                 t.integer :WORKED_ID, limit: 8
                 t.integer :ID, limit: 8
                 t.integer :PAYROLL, limit: 8
                 t.timestamp :PDATE
                 t.integer :SHIFT
                 t.timestamp :ON_TIME
                 t.timestamp :OFF_TIME
                 t.string :CODE
                 t.integer :CODE_TYPE
                 t.integer :LINE_NO
                 t.string :PAY_TYPE
                 t.string :DEPT_GROUP
                 t.string :DEPARTMENT
                 t.string :CENTRE
                 t.string :POS
                 t.string :DOCKET
                 t.integer :QUANTITY
                 t.integer :STD_RATE
                 t.integer :HOURS
                 t.integer :HOUR_TYPE
                 t.integer :NO_OT_REC
                 t.integer :JOB_PREM
                 t.integer :AM_PREM_HR
                 t.integer :PM_PREM_HR
                 t.boolean :CALC_FLAG          
                 t.string :STATUS       
                 t.boolean :WAS_LL
                 t.integer :OT_TYPE
                 t.boolean :NOERASE
                 t.timestamp :CLK_ON
                 t.timestamp :CLK_OFF
                 t.integer :UDF1
                 t.integer :UDF2
                 t.string :NOTE
                 t.string :CENTRE1
                 t.integer :POS1
                 t.string :RDOCKET
                 t.boolean :TDEFAULT
                 t.boolean :FLAG1
                 t.boolean :FLAG2
                 t.boolean :FLAG3
                 t.boolean :FLAG4
                 t.boolean :FLAG5
                 t.integer :RATE
                 t.integer :AM_PREM_RATE
                 t.integer :PM_PREM_RATE
                 t.integer :JOB_ID
                 t.integer :UDF_KEY
                 t.string :OPERATION
                 t.string :UDF3
                 t.string :UDF4
                 t.integer :PIECE_RATE
                 t.integer :WORK_ORDER_ID
                 t.integer :WORK_ITEM_ID
                 t.string :WOI_CONTROL
                 t.string :APPROVED_STATUS
                 t.string :APPROVED_BY
                 t.timestamp  :APPROVED_TIME
                 t.string :EXT_ATTR_1
                 t.string :EXT_ATTR_2
                 t.string :EXT_ATTR_3
                t.string :EXT_ATTR_4
                t.string :EXT_ATTR_5
                t.string :EXT_ATTR_6
                t.timestamp :EWA_1
                t.timestamp :EWA_2
                t.timestamp :EWA_3
                t.timestamp :EWA_4
                t.timestamp :EWA_5
                t.timestamp :EWA_6
                t.timestamp :EWA_7
                t.timestamp :EWA_8
                t.timestamp :EWA_9
                t.timestamp :EWA_10
                t.timestamp :EWA_11
                t.timestamp :EWA_12
                t.timestamp :EWA_13
                t.timestamp :EWA_14
                t.timestamp :EWA_15
                t.timestamp :EWA_16
                t.timestamp :EWA_17
                t.timestamp :EWA_18
                t.timestamp :EWA_19
                t.timestamp :EWA_20
      t.timestamps null: false
    end
  end
end

