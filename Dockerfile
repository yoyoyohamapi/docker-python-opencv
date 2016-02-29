FROM daocloud.io/library/python:2.7-wheezy

MAINTAINER yoyoyohamapi "softshot37@gmail.com"

ENV OPENCV_VERSION 3.1

# 替换软件源
COPY sources.list /etc/apt/sources.list

# opencv3.1 compiler && required && optional
RUN apt-get update \
	&& apt-get install -y \
	wget unzip \
	build-essential \
	cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
	python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

RUN apt-get remove -y libwebp-dev
WORKDIR /tmp
RUN wget https://github.com/Itseez/opencv/archive/3.1.0.zip
RUN wget https://raw.githubusercontent.com/Itseez/opencv_3rdparty/81a676001ca8075ada498583e4166079e5744668/ippicv/ippicv_linux_20151201.tgz
RUN unzip 3.1.0.zip
RUN tar -zxvf ippicv_linux_20151201.tgz
RUN cp -R ippicv_lnx opencv-3.1.0/ippicv

WORKDIR /tmp/opencv-3.1.0
RUN mkdir /tmp/opencv-3.1.0/build

# dependencies
ADD requirements.txt /tmp/

RUN pip install --trusted-host pypi.douban.com -i http://pypi.douban.com/simple -r /tmp/requirements.txt


WORKDIR /tmp/opencv-3.1.0/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D WITH_V4L=ON -D INSTALL_PYTHON_EXAMPLES=ON -D INSTALL_C_EXAMPLES=OFF -D BUILD_EXAMPLES=ON -D WITH_OPENGL=ON -D WITH_IPP=OFF  ..

RUN make -j $(nproc)
RUN	make install
RUN sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
RUN ldconfig


WORKDIR /source
VOLUME ["/source"]

RUN rm -rf /tmp/*

CMD ["python"]
