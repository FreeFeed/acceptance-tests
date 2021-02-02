FROM cypress/included:3.2.0
ADD ./ /app/
WORKDIR /app
RUN yarn
ENTRYPOINT ["cypress"]
