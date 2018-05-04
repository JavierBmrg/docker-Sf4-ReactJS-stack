FROM node:carbon

# Set working dir
RUN mkdir -p /var/srv/app
WORKDIR /var/srv/app

# Set env var
ENV PATH /var/srv/app/node_modules/.bin:$PATH

# Copy dependencies files
COPY ./app-front/package*.json ./
COPY ./app-front/yarn.lock ./

# To be defined!
RUN yarn install

# Copy project directories
#COPY src ./var/srv/app
#COPY public ./var/srv/app

CMD [ "yarn", "start" ]