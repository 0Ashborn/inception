# User Documentation

## Overview
This documentation provides guidance for end users and administrators on how to use and manage the Inception project services.

## Available Services

### Web Services
- **WordPress**: Blog/CMS platform at `https://zsaghir.42.fr/`
- **Nginx Web Server**: Serves the WordPress site on port 443 (HTTPS)
- **MariaDB**: Database server for WordPress

## Getting Started

### Prerequisites
- Docker
- Docker Compose
- Make

### Starting the Services
1. Ensure Docker is running on your system
2. Open a terminal and navigate to the project directory
3. Run the following command to build and start all services:
   ```bash
   make
   ```
   This is equivalent to running:
   ```bash
   make build
   make up
   ```

### Stopping the Services
To stop all running containers:
```bash
make down
```

## Service Management

### Accessing WordPress
1. Open your web browser
2. Navigate to `https://localhost/wordpress`
3. Follow the WordPress setup wizard to complete the installation

### Managing the Services
- **View logs**: `make logs`
- **Rebuild services**: `make build`
- **Start services**: `make up`
- **Stop and remove containers**: `make down`
- **Full cleanup (containers, images, volumes)**: `make clean`

### Verifying Services
To check if all services are running:
```bash
docker ps
```

## Troubleshooting

### Common Issues
1. **Port Conflicts**: Ensure port 443 is not in use by another service
2. **Permission Issues**: Ensure your user has permission to run Docker commands
3. **Build Failures**: Check the build output for specific error messages

### Viewing Logs
To view logs for all services:
```bash
make logs
```

Or for a specific service:
```bash
docker-compose -f srcs/docker-compose.yml logs -f [service_name]
```

## Data Persistence
Data is persisted using Docker volumes:
- WordPress files: `/home/zsaghir/data/wordpress`
- MariaDB data: `/home/zsaghir/data/mariadb`

## Security Notes
- The application runs with HTTPS using a self-signed certificate
- Default credentials should be changed after first login
- The `.env` file contains sensitive information and should not be committed to version control
