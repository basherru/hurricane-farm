# Development Setup

1. Install and select Ruby 3.0 via RVM or your ruby version manager of choice.

    ```bash
    rvm install 3.0.0
    rvm use 3.0.0
    ```
  
2. Install and configure PostgresQL database. Mind to allow external connections if you want to parallel run exploits in the network.

    ```bash
    brew install postgresql
    brew services start postgresql
   ...
    ```

3. Install and configure Redis server. Mind to allow external connections if you want to parallel run exploits in the network.

    ```bash
    brew install redis
    brew services start redis
   ...
    ```

4. Copy `.env` file from example and set all needed variables:

    ```bash
    cp /docker/env/postgres.env.example /docker/env/postgres.env
    cp /docker/env/redis.env.example /docker/env/redis.env
    cp /docker/env/app.env.example /docker/env/app.env
    ```

5. Run docker-compose with the server or client docker-compose.yml file

    ```bash
    docker-compose -f docker/server.docker-compose.yml up -d --build
    ```
