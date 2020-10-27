Rails.application.routes.draw do
  get 'tasks/index'
  root to: "tasks#index"
end
