class CsvRecordsController < ApplicationController

    skip_before_action :verify_authenticity_token
    before_action :set_csv_record, only: %i[ show ]

    def import
        CsvRecord.import(params[:file],current_user)
        redirect_to csv_records_path
    end

    def show
    end

    def index
        @csv_records = current_user.csv_records.all
        @max = CsvRecord.max_value(@csv_records)
       
        respond_to do |format|
            format.html
            format.csv {send_data @csv_records.to_csv,
            filename:"CSV-#{DateTime.current}.csv"}

        end
    end

    def max_value
        @csv_records = current_user.csv_records.all
        CsvRecord.max_value(@csv_records)
        
    end


    def time_series
        puts "*******==#{params["to-month"]}"
        @from_month=params["from-month"]
        @to_month=params["to-month"]
        start = Time.now.end_of_month

        p"@from_month************#{@from_month} **** @to_month===#{@to_month}"
        

    end

    # def create
    #     @csv_record = CsvRecord.new(csv_record_params)
    
    #     respond_to do |format|
    #       if @csv_record.save
    #         format.html { redirect_to csv_record_url(@csv_record), notice: "Csv record was successfully created." }
    #         format.json { render :show, status: :created, location: @csv_record }
    #       else
    #         format.html { render :new, status: :unprocessable_entity }
    #         format.json { render json: @csv_record.errors, status: :unprocessable_entity }
    #       end
    #     end
    # end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_csv_record
        @csv_record = CsvRecord.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def csv_record_params
        params.require(:csv_record).permit(:date, :value, :domain_name)
      end

end
