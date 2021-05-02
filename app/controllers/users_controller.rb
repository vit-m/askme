class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vitalik',
        username: 'vitalik1',
        avatar_url: 'https://icons-for-free.com/iconfiles/png/128/avatar-1320568024619304547.png'
      ),
      User.new(
        id: 2,
        name: 'Charlie',
        username: 'charlie_cooper'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vitalik',
      username: 'vitalik1',
      avatar_url: 'https://icons-for-free.com/iconfiles/png/128/avatar-1320568024619304547.png'
    )

    @questions = [
      Question.new(text: 'How are you?', created_at: Date.parse('01.04.2021')),
      Question.new(text: 'How are you??', created_at: Date.parse('28.04.2021'))
    ]

    @new_question = Question.new
  end
end
