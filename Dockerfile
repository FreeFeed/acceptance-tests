FROM cypress/included:6.4.0
ADD ./ /app/
WORKDIR /app
RUN npm update caniuse-lite browserslist
RUN yarn
ENTRYPOINT ["cypress"]
