
## Installation

```bash
* bundle install

* rails db:migrate

* rails db:seed (This is admin user for te app).

* rails s

* Login with user admin (credentials at seed.rb) or sign up.

* create aplication.yml at config/ and add code:

MAIL_HOST: "smtp.gmail.com"
MAIL_PORT: 587
MAIL_DOMAIN: "test.com"
MAIL_AUTHENTICATION: "plain"
MAIL_USERNAME: "email"
MAIL_PASSWORD: "password"

* rails s
```

The application is for drivers who wants to give a service transport, there's an admin dashboard who can see users, travels and vehicles data from everybody. The driver registers in the app with an email and password and see a dasboard for his vehicles, driver first must to update his data and then the vehicle, after that, in the vehicles panel will be appear and option to start a service where the driver enter time, distance and value for the service and enter identification, phone and email from the user, after create the travel, system will send an email to the driver and user attaching a copy in pdf, if the travel gets update will send an "OtroSI" to both emails

### Notes
```bash
Rails 5.2
Ruby 2.3
Bootstrap CDN
wicked_pdf & wkhtmltopdf-binary to generate pdf's
```
