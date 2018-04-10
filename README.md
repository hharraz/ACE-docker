<This is a clone from [V10 instructions](https://github.com/ot4i/iib-docker)


# Overview

This repository contains a Dockerfile and some scripts which demonstrate a way in which you might run [IBM App Connect Enterprise Bus](https://www.ibm.com/cloud/app-connect/enterprise) in a [Docker](https://www.docker.com/whatisdocker/) container.

Please note that at the time of writing the Dockerfile Integration Node is not supported in ACE and expected to be available in an upcoming fixpack

# Work in progress
A base image of ACE V11 will be created in which it will be used to build other ACE images for bar deployment

This repository will also contain a Dockerfile and some scripts which demonstrate a way in which you might run [IBM App Connect Enterprise Bus](https://www.ibm.com/cloud/app-connect/enterprise) with an [IBM MQ] Server(http://www-03.ibm.com/software/products/en/ibm-mq).


# Building the image

The image can be built using standard [Docker commands](https://docs.docker.com/userguide/dockerimages/) against the supplied Dockerfile.  For example:

Please note that you will need to have ACE V11 compressed file to exist in the same folder (ace-11.0.0.0.tar.gz)
~~~
cd 11.0.0.0/ace
docker build -t acev11image .
~~~

This will create an image called `acev11image` occupying approximately 3.1GB of space (including the size of the underlying Ubuntu base image) in your local Docker registry:

~~~
REPOSITORY     TAG       IMAGE ID        CREATED          SIZE
acev11image    latest    b8403ecfcd0d    2 seconds ago    3.1GB
ubuntu         16.04     f975c5035748    3 weeks ago      112MB
~~~



# What the image contains

The built image contains a full installation of [IBM App Connect Enterprise V11](https://www.ibm.com/cloud/app-connect/enterprise). If you install the stand-alone image, which does not contain an installation of IBM MQ, some functionality may not be available, or may be changed - see this [topic](http://www-01.ibm.com/support/knowledgecenter/SSMKHH_10.0.0/com.ibm.etools.mft.doc/bb28660_.htm) for more information.

# Running a container

After building a Docker image from the supplied files, you can [run a container](https://docs.docker.com/userguide/usingdocker/) which will create and start an Integration Node to which you can [deploy](https://www.ibm.com/support/knowledgecenter/SSTTDS_11.0.0/com.ibm.etools.mft.doc/af03890_.htm) integration solutions.


## Running with the default configuration
In order to run a container from this image, it is necessary to accept the terms of the IBM Integration Bus for Developers license.  This is achieved by specifying the environment variable `LICENSE` equal to `accept` when running the image.  You can also view the license terms by setting this variable to `view`. Failure to set the variable will result in the termination of the container with a usage statement.  You can view the license in a different language by also setting the `LANG` environment variable.

In addition to accepting the license, you can optionally specify an Integration Server name using the `SERVERNAME` environment variable.

The last important point of configuration when running a container from this image, is port mapping.  The Dockerfile exposes ports `7600` and `7800` by default, for Integration Server administration and HTTP traffic respectively.  This means you can run with the `-P` flag to auto map these ports to ports on your host.  Alternatively you can use `-p` to expose and map any ports of your choice.

For example:

~~~
docker run --name myServer -e LICENSE=accept -e  SERVERNAME=aceserver -P acev11image
~~~

A bar file is already provided in 11.0.0.0/ace/bars folder which is deployed for testing.

For example:
Get container port

~~~
docker ps
~~~~~~

~~~
curl -X GET http://localhost:<port>/employee/v1/employeeID
~~~

If you wish, you can also deploy more BAR files by
  * Specifying a [Docker volume](https://docs.docker.com/engine/admin/volumes/volumes/) which makes the BAR file(s) available when the container is started:
~~~
docker run --name myNode -v  /local/path/to/bars:/tmp/bars/<yourbars> -e LICENSE=accept -e SERVERNAME=aceserver -P acev11image
~~~

* Another way is to put all bars required in 11.0.0.0/ace/bars folder and run the docker run command


This will run a container that creates and starts an Integration Server called `aceserver` and exposes ports `7600` and `7800` on random ports on the host machine.  At this point you can use:
~~~
docker port <container name>



to see which ports have been mapped then connect to the Server's web user interface as normal (see [verification](# Verifying your container is running correctly) section below).


## Running administration commands

You can run any of the App Connect Enterprise
 commands using one of two methods:

#### Directly in the container

Attach a bash session to your container and execute your commands as you would normally:

~~~
docker exec -it <container name> /bin/bash
~~~

At this point you will be in a shell inside the container and can source `mqsiprofile` and run your commands.

#### Using Docker exec

Use Docker exec to run a non-interactive Bash session that runs any of the App Connect Enterprise commands.  For example:

~~~
docker exec <container name> /bin/bash -c mqsilist
~~~


## Accessing logs

This image also configures syslog, so when you run a container, your server will be outputting messages to /var/log/syslog inside the container.  You can access this by attaching a bash session as described above or by using docker exec.  For example:

~~~
docker exec <container id> tail -f /var/log/syslog
~~~

# Verifying your container is running correctly

Whether you are using the image as provided or if you have customized it, here are a few basic steps that will give you confidence your image has been created properly:

1. Run a container, making sure to expose port 7600 to the host - the container should start without error
2. Run mqsilist and see the result. At this stage it should be an error as nodes are not introduced yet
3. Access syslog as descried above - there should be no errors
4. Connect a browser to your host on the port you exposed in step 1 - the Integration Bus web user interface should be displayed.
5. Run curl command as described earlier

At this point, your container is running and bars are already deployed.


# List of all Environment variables supported by this image

* **LICENSE** - Set this to `accept` to agree to the MQ Advanced for Developers license. If you wish to see the license you can set this to `view`.
* **LANG** - Set this to the language you would like the license to be printed in.
* **SERVERNAME** - Set this to the name you want your Integration Server to be created with.
