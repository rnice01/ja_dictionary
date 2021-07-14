# JaStudyTools

Development:
  I have a Docker Compose file for running this project in dev mode. In the root of the project run the following:

  `docker-compose -f docker/docker-compose.dev.yml up`

  If this is the first time starting the containers, you'll also need to run:


 `docker-compose -f docker/docker-compose.dev.yml run app mix ecto.reset`

 `docker-compose -f docker/docker-compose.dev.yml run app mix dict.yomichan`

 The first command creates the app's database in the postgres container if it doesn't exist. If it does, it'll drop the database and create a new one.

 The second command runs a mix task that reads through some JSON files to fill the DB with dictionary entries and index the data in the elasticsearch container.