module DynamicSort
    
    def column_name(column_name, model_name: nil)
        column_name.in?(model_name.column_names) ? column_name : "name" 
    end

    def direction(direction)
        direction.in?( %w[asc desc] ) ? direction : "asc"
    end
end