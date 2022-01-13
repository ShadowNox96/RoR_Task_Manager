class ParticipantMailer < ApplicationMailer
  # enviar email 
  def new_task_email 
    @user = params[:user]
    @task = params[:task]
    mail to: @user.email, subject: 'Tarea asignada'
  end
end
