# Notes from: https://docs.docker.com/engine/reference/builder/
# Next steps: https://docs.microsoft.com/en-us/visualstudio/docker/tutorials/image-building-best-practices

# Docker files need a FROM to set the parent container
# FROM can be FROM scratch https://docs.docker.com/develop/develop-images/baseimages/
FROM alpine

# ARG <name>[=<default value>]
# The ARG instruction defines a variable that users can pass at build-time to the builder with the docker build command using the --build-arg <varname>=<value> flag.
ARG key=defaultvalue
# ARG values are visibile in docker history command, so don't use them to pass secrets into the container at build time. Use BuildKit instead: https://docs.docker.com/develop/develop-images/build_enhancements/#new-docker-build-secret-information

# RUN commands execute steps in the build process
# RUN commands add layers to the build process
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

# WORKDIR is like cd, and sets the working directory for the commands that follow it
# If WORKDIR is specified as a relative path, it's relative to the existing WORKDIR path
# See: https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /the/workdir/path
# WORKDIR also uses ENV variables
ENV DIRPATH=/path
WORKDIR $DIRPATH/$DIRNAME
RUN pwd

# ADD copies files
# ADD source dest
# This copies all the files from the local build directory, to the WORKDIR
ADD . .
# This copies all the files from the local ./directory, to the absolute path of /directory in the container's filesystem
ADD ./directory /directory/
# Difference between ADD and COPY: https://nickjanetakis.com/blog/docker-tip-2-the-difference-between-copy-and-add-in-a-dockerile


# VOLUME commands mount a volume inside the container, to a mount point that is specified at run time
# No changes can be made to the content of the volume in the Dockerfile after it is declared; any new data is ignored
RUN mkdir /data
RUN echo "data" > /data/data.txt
VOLUME [ "/data" ]
# This line gets ignored, because it tries to change data after the volume is declared
RUN echo "data2" > /data/data.txt


# HEALTHCHECK
# Provides Docker a way to test if the container is healthy, such as a web server
# See: https://docs.docker.com/engine/reference/builder/#healthcheck
# HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "executable" ]


# ENTRYPOINT allows you to configure a container that will run as an executable.
# Run time parameters are appended to these parameters, instead of overwriting them
# exec form, preferred
# ENTRYPOINT ["executable", "param1", "param2"]
# shell form, not preferred, because it runs as a subprocess of bash -c, and doesn't receive signals, ex SIGTERM
# ENTRYPOINT command param1 param2
# See: https://docs.docker.com/engine/reference/builder/#understand-how-cmd-and-entrypoint-interact



# CMD instruction is intended to start the container's app
# CMD parameters are overwritten if provided at run time
# There can only be one CMD instruction; only the last CMD runs
# Runs at execution time, isn't cached
# Convention is to put it at the bottom of the file
# exec form, preferred, but doesn't expand variables 
CMD [ "echo","$GIT_DIR"]
# shell form, not preferred, but expands variables 
CMD echo $GIT_DIR
