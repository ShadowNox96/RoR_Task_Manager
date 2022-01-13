# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    # User es el que proviene directamente de la peticion http equivalente al current_user
    
    # manage es que puede acceder a todo, cuando le digo Task es que solo puede manejar las tareas y todas sus operaciones crud 
    # en owner_id: user_id, significa que solo el usuario creador puede ingresar a la misma
    can :manage, Task, owner_id: user.id
    # Permitir solo lectura
    can :read, Task, participating_users: { user_id: user.id }

    # Solo los responsables pueden aniadir comentarios 
    can :create, Note, task: { owner_id: user.id }


  end
end
