FROM redmine:4.0.5-alpine

ENV RAILS_ENV production
WORKDIR /usr/src/redmine

COPY docker-entrypoint.sh /
COPY receive-command.sh /
COPY secrets.yml config/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [ "/receive-command.sh" ]