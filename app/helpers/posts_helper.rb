module PostsHelper

  class NullAuthor
    attr_accessor :name, :nick_name, :email,:password,:id

    def initialize()
      @name = "Anonymous da Silva"
      @nick_name = "Anonymous"
      @email = "Anonymous@gmail.com"
      @password = "password"
      @id = "01"
    end
  end

end
