This project has been created as part of the 42 curriculum by oben-jha


# Inception
## Description
The inception project's about setting up a small infrastructure composed of different services within a virtual machine.
It's main goal is being able to create and manage your own infrastructure all under docker, including creating images and containers for each service, creating the necessary networks and volumes as well.

## Instruction
In order to get this infrastructure up and running correctly on your local machine, a few configuration steps are required before lunching the services.
Below are the full steps to follow to properly set up the environment, build the images, and deploy the containers.

### 1. Prerequisities & Environment Setup
### Configuring the Domain Name
Before building the project, You must configure your local domain name to point to your localhost. This ensures the web server correctly routes traffic to your WordPress site.

locate to the following file /etc/hosts
    ```bash
    sudo vim /etc/hosts
    ```
and change the following line 
    ```127.0.0.1       localhost``` ----> ````127.0.0.1       oben-jha.42.f```
save the changes and exit.
### Setting up Environment Variables 
For security reasons, sensitive data such as database passwords, root credentials, and WordPress user details must not be hardcoded into the Dockerfiles or Compose files. Instead they are pased via .env file.
You need to create a .env file inside the src/ directory. Fill it with your secure credentials matching the variables required by the services. 
    ```bash
        cd src/ && cat > .env << EOF
        # Domain
        DOMAIN_NAME=oben-jha.42.fr
        # MariaDB credentials
        SQL_DB=wordpress_db
        SQL_USR=wp_user
        SQL_PWD=secure123
        SQL_ROOT_PWD=oben-jha

        # WordPress Admin (Subject rule: Cannot contain 'admin' or 'Administrator')
        WP_ADMIN_USR=oben-jha_boss
        WP_ADMIN_PWD=0000
        WP_ADMIN_EMAIL=oben-jha@student.42.fr

        # WordPress standard user
        WP_USR=regular_user
        WP_EMAIL=user@student.42.fr
        WP_PWD=1111
        #_FTP user credentials
        FTP_USER=FTP_USER
        FTP_PWD=ftppppp
        EOF
        ```


