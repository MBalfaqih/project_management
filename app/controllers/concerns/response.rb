module Response

    def render_data(message: 'Loaded successfuly', data: nil , pages: pages)
        render json: {
                        message: message,
                        data:    data,
                        pages:   pages,
                        status:  status
        }, status: status
    end
    
    def render_success(message: 'success', data: nil, status: :ok)
        # message = data.nil? ? "no record founds" : "success"
        render json: {
                        success: true,
                        message: message,
                        data:    data,
                        status:  status
        }, status: status
    end
    
      def render_failed(message: "Failed", data: nil, status: :unprocessable_entity)
        render json: {
                        success: false,
                        message: message,
                        data:    data,
                        status:  status
        }, status: status
    end

    
    def collection_serializer(  data , serializer , scope: nil )
        if scope == nil 
            ActiveModel::Serializer::CollectionSerializer.new( data , serializer: serializer )
        else
            ActiveModel::Serializer::CollectionSerializer.new(
                        data , 
            serializer: serializer, 
                 scope: scope )
        end
    end

end