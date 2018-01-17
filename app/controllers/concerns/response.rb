module Response
    # def json_response( object , status = :ok )
    #         render json: object , status: status
    # end

    def render_success(message: "Success", data: nil, status: :ok)

        render json: {
                        success: true,
                        message: message,
                        data: data,
                        status: status
          }, status: status
    end
    
      def render_failed(message: "Failed", data: nil, status: :unprocessable_entity)
    
        render json: {
                        success: false,
                        message: message,
                        data: data,
                        status: status
          }, status: status
    end

end