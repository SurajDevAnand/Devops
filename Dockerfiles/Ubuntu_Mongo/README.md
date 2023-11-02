# MongoDB on Ubuntu with SSL

- Create SSL certificates and put them into the SSL folder. [Link](https://rajanmaharjan.medium.com/secure-your-mongodb-connections-ssl-tls-92e2addb3c89)
- Execute the below command to build the image.
  ```
  docker build -t Ubuntu_Mongo .
  ```
- Execute the below command to start the container.
  ```
  docker run -it Ubuntu_Mongo
  ```
- To connect to mongoDB using mongo client use the below command.
  ```
   mongo --ssl --sslCAFile ssl/rootCA.pem --sslPEMKeyFile ssl/mongodb.pem --host 127.0.0.1 --port 27017
  ```
