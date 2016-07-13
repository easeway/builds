FROM thewtex/cross-compiler-linux-armv7
ADD setup.sh /
RUN /bin/bash /setup.sh
