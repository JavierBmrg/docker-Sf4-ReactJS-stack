FROM node:carbon

# Set working dir
RUN mkdir -p /var/srv/app
WORKDIR /var/srv/app

# Set env var
ENV PATH /var/srv/app/node_modules/.bin:$PATH

# Copy dependencies files
COPY ./app-frontend/package*.json ./
COPY ./app-frontend/yarn.lock ./

# To be defined!
RUN yarn install

# Copy project directories
#COPY src ./var/srv/app
#COPY public ./var/srv/app

CMD [ "yarn", "start" ]