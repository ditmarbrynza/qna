# README

Lesson 12 Oauth
```
1. Юзер жмет на авторизацию через соцсеть
  - oauth провайдер запрашивает разрешение к аккаунту юзера
  - oauth провайдер редиректит на redirect_url (users/oauth/github) с кодом
  - там получаем по code json (через гемы) в виде request.env['omniauth.auth'] на 
2. Проверяем есть ли юзер в системе
  - Ищем по uid и провайдеру юзера в системе через authorization
  - Если находим, то авторизуем authorization.user
  - Если не находим, то пробуем найти по мылу auth.info.email
  - Если и такого нет, то создаем юзера с email, password, password confirmation и для него создаем authorization связанную
  - Если мыла нет, то отправляем письмо, ждем подтверждения и только тогда авторизуем


Если нет мыла?
- перенаправляем на view, где просит ввести мыло
- оттуда делаем post запрос на создание authorization, ожидающей подвтверждения, для юзер с uid и provider
- когда юзер переходит по ссылке с мыла, то его редиректит на email_confirmation
- в email_confirmation authorization обновляется и становится confirmed (authorization токен затирается)
- юзер логинится
```
