# Development Setup

1. Install and select Ruby 2.6+ via RVM or your ruby version manager of choice.

    ```bash
    rvm install 2.7.0
    rvm use 2.7.0
    ```
  
2. Install and configure PostgresQL database.

    ```bash
    brew install postgresql
    brew services start postgresql
    ```

3. Install and configure Redis server.

    ```bash
    brew install redis
    brew services start redis-server
    ```

4. Copy `.env` file from example and set all needed variables:

    ```bash
    cp .env.example .env
    ```

5. Install bundle gems.

    ```bash
    bundle
    ```

6. Setup the database up to your CTF event.

    ```bash
    rails hurricane:setup
    ```
    
7. Start the application.

    ```bash
    rails server -b '0.0.0.0'
    ```
