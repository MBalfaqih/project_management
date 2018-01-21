class V1::Company::CompanySerializer < ActiveModel::Serializer
  attributes *Company.column_names
end
