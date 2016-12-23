# FASTQC
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Brian O'Connor <briandoconnor@gmail.com>

# Install OpenJDK JRE
RUN apt-get update && apt-get install --yes \
    openjdk-8-jre \
    unzip \
    curl \
    perl \
    python

ENV FASTQC_PATH http://www.bioinformatics.babraham.ac.uk/projects/fastqc
ENV FASTQC_ZIP fastqc_v0.11.5.zip
ENV FASTQC_DEST /usr/local

RUN curl -SL ${FASTQC_PATH}/${FASTQC_ZIP} -o /tmp/${FASTQC_ZIP} \
    && unzip /tmp/${FASTQC_ZIP} -d ${FASTQC_DEST} \
    && chmod 755 ${FASTQC_DEST}/FastQC/fastqc \
    && ln -s ${FASTQC_DEST}/FastQC/fastqc /usr/local/bin/fastqc \
    && rm -rf /tmp/${FASTQC_ZIP}

COPY run-fastqc /usr/local/bin
RUN chmod a+x /usr/local/bin/run-fastqc

# switch back to the ubuntu user so this tool (and the files written) are not owned by root
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 -m ubuntu
USER ubuntu

# by default /bin/bash is executed
CMD ["/bin/bash"]
