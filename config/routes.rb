Rails.application.routes.draw do
  devise_for :users
  root to: "report#list"

  get 'report/list'
  get 'report/detail/:entry_id' => "report#detail", as: 'report_detail'
  get 'report/delete/:entry_id' => "report#delete", as: 'report_delete'
  get 'report/search'
  post 'report/add'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
