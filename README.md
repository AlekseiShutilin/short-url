## Short url test application
#### 1. Приложение использует:

- Ruby 2.3.0
- Rails 5.0
- sqlite database (dev mode)
- postgresql (production mode)

#### 2. [Deployed on Heroku](https://shturl.herokuapp.com/)


#### 3. Использование API:

3.1 API приложения использует формат *RFC 6750 Bearer Token* для авторизации.
Все запросы к API должны содержать заголовок
     ` Content-Type: application/json`
     
3.2 Регистрация нового пользователя:
       `POST /api/auth`
	обязательные параметры:
	
* user
* password
* password_confirmation
     
3.3 Авторизация:
        `POST api/auth/sign_in`
     обязательные параметры:
     
* user
* password
    
при успешной авторизации ответ будет содержать заголовки, которые должны быть переданы
при обращении к `POST /api/entities`:

* `access-token`
* `token-type`     
* `client`
* `expiry` 
* `uid` 

3.4 Создание новой пары URL:
	`POST /api/entities`
формат параметров:
```
    {
	"data": {
		"entity": {
			"url": "https://shturl.herokuapp.com/",
			"short_url": "self" // optional
            }
	    }
    }
```  
    
3.5 Получение списка существующих записей:
        `GET api/entities`
        
#### 4. Развертывание проекта локально:
* Clone the project
* [install RVM](https://rvm.io/rvm/install)
* Go to the project directory
* Perform: 
    ```
    $ rvm install ruby-2.3.0
    $ rvm --default use ruby-2.3.0
    $ gem install bundler
    $ bundle install
    $ rails db:create
    $ rails db:migrate
    $ crontab -r
    $ whenever --update-crontab --set environment='development'
    $ rails s
    ```
    сервер будет запущен на *localhost:3000*
