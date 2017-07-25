FROM alpine:3.6

ARG version=2.4.1
ARG buildhost=https://downloads.sourceforge.net/project/mnemosyne-proj/mnemosyne/mnemosyne-${version}
ARG tar_filename=Mnemosyne-${version}.tar.gz

VOLUME ["/opt/mnemosyne/data"]

RUN apk update \
 && apk add --no-cache \
            ca-certificates \
            python3 \
            py3-qt5 \
            libpng \
 && apk add --no-cache \
            --virtual build \
            wget \
            python3-dev \
            freetype-dev \
            libjpeg-turbo-dev \
            make \
            g++ \
 && update-ca-certificates \
 && pip3 install --no-cache-dir \
                 matplotlib \
                 cheroot \
                 pillow \
                 webob \
 && wget ${buildhost}/${tar_filename} \
 && mkdir /mnemosyne \
 && tar xvf "${tar_filename}" -C mnemosyne --strip 1 \
 && rm "${tar_filename}" \
 && cd /mnemosyne \
 && python3 setup.py install \
 && rm -r /mnemosyne \
 && apk del build

CMD ["mnemosyne", \
       "--datadir=/opt/mnemosyne/data", \
       "--no-upgrades", \
       "--sync-server"]

EXPOSE 8512 8513
