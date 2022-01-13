# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Category < ApplicationRecord
  has_many :tasks

  # Validaciones de campos en blanco  
  validates :name, :description, presence: true
  # Validacion para que no se duplique o de unicidad 
  # Validar unicidad pero sin importar las mayuculas o minusculas 
  validates :name, uniqueness: { case_sensitive: false}

end
