class V1::CompanySerializer < ActiveModel::Serializer
  attributes :id , :company_name , :username , :email , :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at
  
end
     