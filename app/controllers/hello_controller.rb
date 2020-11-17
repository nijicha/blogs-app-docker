class HelloController < ApplicationController
  def index
    render html: 'hello world!'
  end
end
