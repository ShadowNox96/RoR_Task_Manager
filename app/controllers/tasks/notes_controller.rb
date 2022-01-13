# Scope resolution operator :: es una convencion que se utiliza para agrupar cosas que pertenecen al mismo contexto, y estan directamente asociadas al directorio, esto es llamado Namespacing 
# Con esto rails define que Tasks es un modulo
class Tasks::NotesController < ApplicationController 
  before_action :set_task
   
  def create 
    @note = @task.notes.new(note_params)
    @note.user = current_user
    @note.save
  end

  private 

  # strong parameters 
  def note_params 
    params.require(:note).permit(:body)
  end
  
  def set_task
    # Referencia al id de la nota 
    @task = Task.find(params[:task_id])
  end

end