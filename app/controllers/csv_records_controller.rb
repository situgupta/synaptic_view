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
        p "hereeeeee"
        @csv_records = current_user.csv_records.all
        @max = CsvRecord.max_value(@csv_records)
        p"max-----#{@max}"
        

        p"#{@csv_records.inspect}"

        respond_to do |format|
            format.html
            format.csv {send_data @csv_records.to_csv,
            filename:"CSV-#{DateTime.current}.csv"}

        end
    end

    def time_series
        to_month
        start = Time.now.end_of_month
        puts "*******==#{start}"

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
