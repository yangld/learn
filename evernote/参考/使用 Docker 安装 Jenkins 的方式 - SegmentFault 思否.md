
    $ docker run \
      --name jenkins-blueocean \
      -d \
      -p 8080:8080 \
      -p 50000:50000 \
      -v jenkins-data:/var/jenkins_home \
      jenkinsci/blueocean

    Created at: 2021-02-01T10:35:15+08:00
    Updated at: 2021-02-01T10:35:15+08:00

