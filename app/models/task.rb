# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#  code        :string
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user
  has_many :notes

  # Validar que una tarea siempre tenga participantes 
  validates :participating_users, presence: true

  # Validaciones de campos en blanco  
  validates :name, :description, presence: true
  # Validacion para que no se duplique o de unicidad 
  # Validar unicidad pero sin importar las mayuculas o minusculas 
  validates :name, uniqueness: { case_sensitive: false}

  # validacion personalizada 
  validate :due_date_validity 

  # validar internamente que si es capaz de recibir informacion anidada

  accepts_nested_attributes_for :participating_users, allow_destroy: true

  # geerate code of code param 
  before_create :generate_code

  # enviar el mail 
  after_create :send_mail

  

  def generate_code
    # Establecer el code para la tarea, antes de que la misma sea creada 
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def send_mail
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_email.deliver!
    end
  end

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('tasks.errors.invalid_due_date')
  end
end
