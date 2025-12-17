# Developer Documentation

## Environment Setup

### Prerequisites
- Docker (version 20.10.0 or higher)
- Docker Compose (version 2.0.0 or higher)
- GNU Make
- OpenSSL (for certificate generation)

### Initial Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd inception
   ```

2. **Configure Environment Variables**
   Create a `.env` file in the project root with the following variables:
   ```
   # Database
   DB_ROOT_PASSWORD=your_db_root_password
   DB_NAME=wordpress
   DB_USER=wpuser
   DB_PASSWORD=wppassword
   DB_HOST=mariadb
   
   # WordPress
   WP_URL=localhost
   WP_TITLE="My WordPress Site"
   WP_ADMIN=admin
   WP_ADMIN_PASS=adminpass
   WP_ADMIN_EMAIL=admin@example.com
   ```

## Project Structure

```
inception/
├── Makefile               # Build and management commands
├── .gitignore            # Git ignore file
├── srcs/
│   ├── docker-compose.yml # Service definitions
│   ├── .env              # Environment variables (not versioned)
│   ├── nginx/            # Nginx configuration and SSL certificates
│   ├── mariadb/          # Database configuration
│   └── wordpress/        # WordPress configuration and setup
```

## Building and Running

### Available Make Commands

| Command      | Description                                      |
|--------------|--------------------------------------------------|
| `make`       | Build and start all services (build + up)        |
| `make build` | Build services without starting them             |
| `make up`    | Start all services                              |
| `make down`  | Stop and remove containers                      |
| `make clean` | Stop and remove containers, images, and volumes  |
| `make logs`  | View logs for all services                      |

### Development Workflow

1. **Start the environment**
   ```bash
   make
   ```

2. **Access the services**
   - WordPress site: https://localhost/wordpress
   - WordPress admin: https://localhost/wordpress/wp-admin

3. **Making Changes**
   - Update configuration files in their respective directories
   - Rebuild the affected service:
     ```bash
     docker-compose -f srcs/docker-compose.yml build <service_name>
     docker-compose -f srcs/docker-compose.yml up -d <service_name>
     ```

## Data Persistence

Data is persisted using bind mounts to the host system:
- WordPress files: `/home/zsaghir/data/wordpress`
- MariaDB data: `/home/zsaghir/data/mariadb`

To reset the environment:
```bash
make clean
```

## Debugging

### Viewing Logs

- View all logs:
  ```bash
  make logs
  ```
  or
  ```bash
  docker-compose -f srcs/docker-compose.yml logs -f
  ```

- View specific service logs:
  ```bash
  docker-compose -f srcs/docker-compose.yml logs -f nginx
  docker-compose -f srcs/docker-compose.yml logs -f wordpress
  docker-compose -f srcs/docker-compose.yml logs -f mariadb
  ```

### Accessing Containers

To access a running container:
```bash
docker-compose -f srcs/docker-compose.yml exec <service_name> /bin/bash
```

## Environment Variables

| Variable           | Description                       | Example Value        |
|--------------------|-----------------------------------|---------------------|
| `DB_ROOT_PASSWORD` | Root password for MariaDB        | `your_db_password`  |
| `DB_NAME`          | WordPress database name          | `wordpress`         |
| `DB_USER`          | WordPress database user          | `wpuser`            |
| `DB_PASSWORD`      | WordPress database password      | `wppassword`        |
| `DB_HOST`          | Database hostname                | `mariadb`           |
| `WP_URL`           | WordPress site URL               | `localhost`         |
| `WP_TITLE`         | Site title                       | `My WordPress Site` |
| `WP_ADMIN`         | Admin username                   | `admin`             |
| `WP_ADMIN_PASS`    | Admin password                   | `adminpass`         |
| `WP_ADMIN_EMAIL`   | Admin email                      | `admin@example.com` |

## Security Considerations

- The application uses HTTPS with a self-signed certificate
- Database credentials are passed via environment variables
- The `.env` file is in `.gitignore` to prevent committing sensitive data
- Regular Docker image updates are recommended for security patches

## License

This project is part of the 42 curriculum and is available for educational purposes only.
