# Use official Node.js 20 LTS
FROM node:20-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the project
COPY . .

# Build Strapi admin panel
RUN npm run build

# Set default environment variables (from your .env)
ENV HOST=0.0.0.0
ENV PORT=1337

ENV APP_KEYS=mSWJ4Nv0jDXJErHiCLvPuA==,qwf5LAF5yBpcZMRs/Xd0Eg==,LI2ykjI55Fw+fvlZiaPd/w==,xvbCiu9p4Qy9W5nEKE6Stg==
ENV API_TOKEN_SALT=mbIgDfC2eU4ltJbW3pyxZQ==
ENV ADMIN_JWT_SECRET=MZgp9I7S1JeAflemdW4ATw==
ENV TRANSFER_TOKEN_SALT=7oJBSsBLXwSu6+aXewt63A==
ENV ENCRYPTION_KEY=r53uKBB/1Fle7pce1WSgaw==
ENV JWT_SECRET=4y5gAB7lKeWHEVVnzbZkdA==

ENV DATABASE_CLIENT=sqlite
ENV DATABASE_FILENAME=.tmp/data.db
ENV DATABASE_HOST=
ENV DATABASE_PORT=
ENV DATABASE_NAME=
ENV DATABASE_USERNAME=
ENV DATABASE_PASSWORD=
ENV DATABASE_SSL=false

# Expose default Strapi port
EXPOSE 1337

# Start Strapi in production mode
CMD ["npm", "run", "start"]

