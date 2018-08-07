FROM ubuntu:17.10

ARG version=2.6.1
ARG buildhost=https://downloads.sourceforge.net/project/mnemosyne-proj/mnemosyne/mnemosyne-${version}
ARG tar_filename=Mnemosyne-${version}.tar.gz

VOLUME ["/opt/mnemosyne/data"]

RUN apt-get update \
 && apt-get install --no-install-recommends \
                    -y \
                    wget \
                    ca-certificates \
                    python3 \
                    python3-pip \
                    python3-setuptools \
                    python3-pyqt5 \
                    python3-cherrypy3 \
                    python3-matplotlib \
                    python3-webob \
                    python3-pillow \
                    python3-pyqt5.qtwebengine \
 && update-ca-certificates \
 && pip3 install --no-cache-dir \
                 cheroot \
 && wget ${buildhost}/${tar_filename} \
 && mkdir /mnemosyne \
 && tar xvf "${tar_filename}" -C mnemosyne --strip 1 \
 && rm "${tar_filename}" \
 && cd /mnemosyne \
 && python3 setup.py build \
 && python3 setup.py install --optimize=1 \
 && rm -r /mnemosyne \
 && apt-get purge -y \
                  --autoremove \
                  wget \
                  python3-setuptools \
 && rm -rf /var/lib/apt/lists/*

CMD ["mnemosyne", \
       "--datadir=/opt/mnemosyne/data", \
       "--no-upgrades", \
       "--sync-server"]

EXPOSE 8512 8513
