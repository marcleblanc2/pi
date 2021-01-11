# Notes from: https://docs.docker.com/engine/reference/builder/
# Next steps: https://docs.microsoft.com/en-us/visualstudio/docker/tutorials/image-building-best-practices

# Docker files need a FROM to set the parent container
# FROM can be FROM scratch https://docs.docker.com/develop/develop-images/baseimages/
FROM alpine

# RUN instructions build layers in the build process
# Layers can be cached to save on build time, unless --no-cache is used
RUN apk add git

# Add metadata
# Shows up in docker inspect
LABEL maintainer="Marc"

# Expose is only a communication tool from the container maintainer to the container user, instructing them which ports to open
# Doesn't actually open the port, still requires the -p 80:80 argument to docker run
# Expose assumes TCP; UDP needs to be specified
EXPOSE 80
EXPOSE 443

# ENV variables persist inside the container's execution environment
ENV GIT_DIR=/git

# CMD instruction is intended to start the container's app
# There can only be one CMD instruction; only the last CMD runs
# Runs at execution time, isn't cached
# Convention is to put it at the bottom of the file
CMD [ "apk","info"]
