FROM thewtex/cross-compiler-linux-x64
ADD setup.sh /
RUN /bin/bash /setup.sh
