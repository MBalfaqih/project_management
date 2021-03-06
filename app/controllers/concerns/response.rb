module Response

    def render_data(message: I18n.t('Loaded_successfuly'), data: nil , pages: pages)
        render json: {
                        message: message,
                        data:    data,
                        pages:   pages,
                        status:  status
        }, status: status
    end
    
    def render_success(message: I18n.t('success'), data: nil, status: :ok)
        # message = data.nil? ? "no record founds" : "success"
        render json: {
                        success: true,
                        message: message,
                        data:    data,
                        status:  status
        }, status: status
    end
    
      def render_failed(message: I18n.t("Failed"), data: nil, status: :unprocessable_entity)
        render json: {
                        success: false,
                        message: message,
                        data:    data,
                        status:  status
        }, status: status
    end

    
    def collection_serializer(  data , serializer , scope: nil )
        ActiveModel::Serializer::CollectionSerializer.new(
        data , 
        serializer: serializer, 
        scope:      scope )
    end

end