#!/usr/bin/env bash

# Perform basic validation
if [ "$REDMINE_MAIL_RECEIVER_HOST" = "" ]; then
    echo "Envar REDMINE_MAIL_RECEIVER_HOST undefined"
    exit 1
fi

if [ "$REDMINE_MAIL_RECEIVER_PORT" = "" ]; then
    echo "Envar REDMINE_MAIL_RECEIVER_PORT undefined"
    exit 1
fi

if [ "$REDMINE_MAIL_RECEIVER_USERNAME" = "" ]; then
    echo "Envar REDMINE_MAIL_RECEIVER_USERNAME undefined"
    exit 1
fi

if [ "$REDMINE_MAIL_RECEIVER_PASSWORD" = "" ]; then
    echo "Envar REDMINE_MAIL_RECEIVER_PASSWORD undefined"
    exit 1
fi

# Build receiver command
COMMAND=""

if [ "$REDMINE_MAIL_RECEIVER_PROTOCOL" = "IMAP" ]; then
    COMMAND="rake redmine:email:receive_imap --trace "

    if [ "$REDMINE_MAIL_RECEIVER_IMAP_FOLDER" != "" ]; then
        COMMAND="$COMMAND folder=\"$REDMINE_MAIL_RECEIVER_IMAP_FOLDER\" "
    fi

    if [ "$REDMINE_MAIL_RECEIVER_IMAP_MOVE_ON_SUCCESS" != "" ]; then
        COMMAND="$COMMAND move_on_success=\"$REDMINE_MAIL_RECEIVER_IMAP_MOVE_ON_SUCCESS\" "
    fi

    if [ "$REDMINE_MAIL_RECEIVER_IMAP_MOVE_ON_FAILURE" != "" ]; then
        COMMAND="$COMMAND move_on_failure=\"$REDMINE_MAIL_RECEIVER_IMAP_MOVE_ON_FAILURE\" "
    fi    

elif [ "$REDMINE_MAIL_RECEIVER_PROTOCOL" = "IMAP" ]; then
    COMMAND="rake redmine:email:receive_pop3 --trace "
    
    if [ "$REDMINE_MAIL_RECEIVER_POP3_DELETE_UNPROCESSED" != "" ]; then
        COMMAND="$COMMAND delete_unprocessed=\"$REDMINE_MAIL_RECEIVER_POP3_DELETE_UNPROCESSED\" "
    fi
    
else
    echo "Unsupported mail receive protocol. Exiting"
    exit 1
fi

# Add required values
COMMAND="$COMMAND RAILS_ENV='production' \
host=\"$REDMINE_MAIL_RECEIVER_HOST\" \
port=\"$REDMINE_MAIL_RECEIVER_PORT\" \
username=\"$REDMINE_MAIL_RECEIVER_USERNAME\" \
password=\"$REDMINE_MAIL_RECEIVER_PASSWORD\" "


# Add optional values
if [ "$REDMINE_MAIL_RECEIVER_USE_SSL" ]; then
    COMMAND="$COMMAND ssl=\"$REDMINE_MAIL_RECEIVER_USE_SSL\" "
fi

if [ -z "$REDMINE_MAIL_RECEIVER_STARTTLS" -a "$REDMINE_MAIL_RECEIVER_STARTTLS" ]; then
    COMMAND="$COMMAND starttls=\"$REDMINE_MAIL_RECEIVER_STARTTLS\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_UNKNOWN_USER_ACTION" != "" ]; then
    COMMAND="$COMMAND unknown_user=\"$REDMINE_MAIL_RECEIVER_UNKNOWN_USER_ACTION\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_NO_PERMISSION_CHECK" != "" ]; then
    COMMAND="$COMMAND no_permission_check=\"$REDMINE_MAIL_RECEIVER_NO_PERMISSION_CHECK\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_NO_ACCOUNT_NOTICE" != "" ]; then
    COMMAND="$COMMAND no_account_notice=\"$REDMINE_MAIL_RECEIVER_NO_ACCOUNT_NOTICE\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_DEFAULT_GROUP" != "" ]; then
    COMMAND="$COMMAND default_group=\"$REDMINE_MAIL_RECEIVER_DEFAULT_GROUP\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_PROJECT" != "" ]; then
    COMMAND="$COMMAND project=\"$REDMINE_MAIL_RECEIVER_PROJECT\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_PROJECT_FROM_SUBADDRESS" != "" ]; then
    COMMAND="$COMMAND  project_from_subaddress=\"$REDMINE_MAIL_RECEIVER_PROJECT_FROM_SUBADDRESS\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_STATUS" != "" ]; then
    COMMAND="$COMMAND status=\"$REDMINE_MAIL_RECEIVER_STATUS\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_TRACKER" != "" ]; then
    COMMAND="$COMMAND tracker=\"$REDMINE_MAIL_RECEIVER_TRACKER\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_CATEGORY" != "" ]; then
    COMMAND="$COMMAND category=\"$REDMINE_MAIL_RECEIVER_CATEGORY\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_PRIORITY" != "" ]; then
    COMMAND="$COMMAND priority=\"$REDMINE_MAIL_RECEIVER_PRIORITY\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_ASSIGNED_TO" != "" ]; then
    COMMAND="$COMMAND assigned_to=\"$REDMINE_MAIL_RECEIVER_ASSIGNED_TO\" "
fi

if [ "$REDMINE_MAIL_RECEIVER_ALLOW_OVERRIDE" != "" ]; then
    COMMAND="$COMMAND allow_override=\"$REDMINE_MAIL_RECEIVER_ALLOW_OVERRIDE\" "
fi

echo "Start rake receive email process"
# Execute command
eval $COMMAND
echo "Email receiveing completed"

exit 0