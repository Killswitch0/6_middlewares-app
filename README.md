# middlewares

* Когда мы запускаем команду rails s, рельсовый сервер создает объект rack.
  ```
  Rails::Server.new.tap do |server|
    require APP_PATH
    Dir.chdir(Rails.application.root)  
    server.start
  end
  ```
  Это все настройки, которые есть в вашем приложении. Все приложение помещается в один контейнер,
  а внутри содержатся все конфигурации приложения - гемы, конфиги, бизнес-логика и т.п.
  А этот объект является rack приложением.
 
  ```
  Rails::Server < ::Rack::Server
    def initialize()
      ...
      super
    end 

    def start
      ...
      super
    end
  end
  ```
  
 * bin/rails middleware - показывает список промежуточных программ(middlewares), через которые проходит
   запрос до передачи в контроллер. 
   
 * middleware можно удалить, если какая-то конкретная вам не нужна, смотри config\application.rb
 
   ```
   config.middleware.delete ActionDispatch::Session::CookieStore
   ```

 * Если нам необходимо поменять позицию порядка middleware - например, сделать в своей последовательности,
   смотри config\application.rb 
   P.S. Желательно не менять список middleware, которые использованы непосредственно рельсами.
   
 * Для включения в проект кастомной middleware добавляем её в config\environments\development.rb. 
   Также смотри файлы lib/middleware/request_time_logger.rb и lib/middleware/freeze_server.rb
   
   ```
   # insert_after, insert_before, use(по умолчанию кладет middleware в конец списка)
   config.middleware.use RequestTimelogger
   config.middleware.use FreezeServer
   ```