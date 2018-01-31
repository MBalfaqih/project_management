module Response
    
    def render_success(message: 'success', data: nil, status: :ok)
        # message = data.nil? ? "no record founds" : "success"

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

    def collection_serializer( data , serializer )
        ActiveModel::Serializer::CollectionSerializer.new( data , serializer: serializer )
    end

end