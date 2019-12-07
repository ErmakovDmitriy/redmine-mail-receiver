# Redmine Mail Receiver

Image is based on official redmine docker image.

Init script is configured to perform one-time IMAP or POP3 email receive task.
The image is intended to use with some kind of external scheduler,
for instance Kubernetes CronJob.

The image uses environment variables to configure its job.

More information about configuring Redmine to receive emails:  [Redmine Receive Emails](https://www.redmine.org/projects/redmine/wiki/RedmineReceivingEmails).

## Environment variables


| Variable                                      | Description                                                                                                                                                                                                      |
| --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| REDMINE_MAIL_RECEIVER_HOST                    | Defines an IMAP or POP3 server to receiver emails from                                                                                                                                                           |
| REDMINE_MAIL_RECEIVER_PORT                    | Defines TCP port to connect to                                                                                                                                                                                   |
| REDMINE_MAIL_RECEIVER_USERNAME                | Login to authenticate on mail server                                                                                                                                                                             |
| REDMINE_MAIL_RECEIVER_PASSWORD                | Password to authenticate on mail server                                                                                                                                                                          |
| REDMINE_MAIL_RECEIVER_PROTOCOL                | Valid values are `IMAP` or `POP3`. Defines protocol to use to receive emails                                                                                                                                     |
| REDMINE_MAIL_RECEIVER_IMAP_FOLDER             | Defines a folder to read emails from (IMAP only)                                                                                                                                                                 |
| REDMINE_MAIL_RECEIVER_IMAP_MOVE_ON_SUCCESS    | Defines action after correct parsing of email for IMAP only. if defined must set a mailbox to move the processed emails to. Valid values are mailbox names for mail account used for reading emails from         |
| REDMINE_MAIL_RECEIVER_IMAP_MOVE_ON_FAILURE    | Defines action after error of parsing of email for IMAP only. if defined must set a mailbox to move the processed emails to. Valid values are mailbox names for mail account used for reading emails from        |
| REDMINE_MAIL_RECEIVER_POP3_DELETE_UNPROCESSED | Defines action with unprocessed emails for POP3 only                                                                                                                                                             |
| REDMINE_MAIL_RECEIVER_USE_SSL                 | Defines if the receiver uses SSL. Valid values are `true` and `false`                                                                                                                                            |
| REDMINE_MAIL_RECEIVER_STARTTLS                | Defines if the receiver uses StartTLS. Valid values are `true` and `false`                                                                                                                                       |
| REDMINE_MAIL_RECEIVER_UNKNOWN_USER_ACTION     | Defines action to apply to emails from unregistered users. Valid values are `ignore`, `accept`, `create`                                                                                                         |
| REDMINE_MAIL_RECEIVER_NO_PERMISSION_CHECK     | Defines permission check on addind modifying tasks by email. Valid values are `0` and `1`                                                                                                                        |
| REDMINE_MAIL_RECEIVER_NO_ACCOUNT_NOTICE       | Defines if the receiver sends email notification about a new account for unregistered user. Valid values are `0` and `1`                                                                                         |
| REDMINE_MAIL_RECEIVER_DEFAULT_GROUP           | Defines default assigned to group for new user accounts                                                                                                                                                          |
| REDMINE_MAIL_RECEIVER_PROJECT                 | Defines project for a new task                                                                                                                                                                                   |
| REDMINE_MAIL_RECEIVER_PROJECT_FROM_SUBADDRESS | Defines email to use as a base for parsing project id from it                                                                                                                                                    |
| REDMINE_MAIL_RECEIVER_STATUS                  | Defines a new tasks status                                                                                                                                                                                       |
| REDMINE_MAIL_RECEIVER_TRACKER                 | Defines a new task tracker                                                                                                                                                                                       |
| REDMINE_MAIL_RECEIVER_CATEGORY                | Defines a new task category                                                                                                                                                                                      |
| REDMINE_MAIL_RECEIVER_PRIORITY                | Defines a new task priority                                                                                                                                                                                      |
| REDMINE_MAIL_RECEIVER_ASSIGNED_TO             | Defines a new task assignee                                                                                                                                                                                      |
| REDMINE_MAIL_RECEIVER_ALLOW_OVERRIDE          | Defines fields from `project`, `status`, `tracker`, `category`, `priority`, `assigned_to` or `all` which can be rewritten by their values in a new task. Valid value is a list without spaces separated by comma |

