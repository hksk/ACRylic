# README

ACRA Backend in RoR 

> $ bundle install 
> $ rake db:migrate

create user
> $ rake users:manipulate email=user@example.com password=123456

simulate request
> $ bash curl-example.sh

.env example:

```
BACKEND_RAILS_DOMAIN=localhost:3000
RAILS_RELATIVE_URL_ROOT=/acrylic
SLACK_TOKEN=xxxxxx
SMTP_URI=smtp://mail.example.com:25
REGISTER_TOKEN=abc123
EMAIL_FROM=from@acrylic.com
EMAIL_TO=to@acrylic.com
EMAIL_SUBJECT="Crash Received!"
```

* remove `SMTP_URI` to disable the email send
* `REGISTER_TOKEN` is a parameter in the request to allow the insertion `/add?register_token=abc123`

TODO:
- Slack Integration