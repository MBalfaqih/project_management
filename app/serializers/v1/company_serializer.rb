class V1::CompanySerializer < ActiveModel::Serializer
  attributes *Company.column_names
end
     