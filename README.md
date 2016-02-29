## Dockerfile for python 2.7 with opencv 3.1
----------

### Get Started(OSX)

```sh
docker run -it -e DISPLAY=<host of your virtual box>:0 -v <path-to-your-code>:/source yoyoyohamapi/opencv:3.1 /bin/bash
```

> In Mac OSX, to run GUI apps through docker, please refer to the following article:
[How to get a GUI to a Docker Container on OS X](http://learning-continuous-deployment.github.io/docker/images/dockerfile/2015/04/22/docker-gui-osx/)
