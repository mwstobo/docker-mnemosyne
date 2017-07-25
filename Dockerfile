FROM alpine:3.6

ARG mnemosyne_version=2.4.1
ARG mnemosyne_buildhost=https://downloads.sourceforge.net/project/mnemosyne-proj/mnemosyne/mnemosyne-${mnemosyne_version}
ARG mnemosyne_tar_filename=Mnemosyne-${mnemosyne_version}.tar.gz
ARG matplotlib_version=2.0.2
ARG matplotlib_buildhost=https://pypi.python.org/packages/f5/f0/9da3ef24ea7eb0ccd12430a261b66eca36b924aeef06e17147f9f9d7d310
ARG matplotlib_tar_filename=matplotlib-${matplotlib_version}.tar.gz

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
                 cheroot \
                 pillow \
                 webob \
 && wget ${mnemosyne_buildhost}/${mnemosyne_tar_filename} \
 && wget ${matplotlib_buildhost}/${matplotlib_tar_filename} \
 && mkdir /mnemosyne \
 && mkdir /matplotlib \
 && tar xvf "${mnemosyne_tar_filename}" -C mnemosyne --strip 1 \
 && tar xvf "${matplotlib_tar_filename}" -C matplotlib --strip 1 \
 && rm "${mnemosyne_tar_filename}" \
 && rm "${matplotlib_tar_filename}" \
 && cd /matplotlib \
 && python3 setup.py build \
 && python3 setup.py install \
 && cd /mnemosyne \
 && python3 setup.py install \
 && rm -r /mnemosyne \
 && rm -r /matplotlib \
 && apk del build

CMD ["mnemosyne", \
       "--datadir=/opt/mnenosyne/data", \
       "--no-upgrades", \
       "--sync-server"]

EXPOSE 8512 8513
