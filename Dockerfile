# FASTQC
FROM ubuntu:latest

# File Author / Maintainer
MAINTAINER Walt Shands

# Install OpenJDK JRE
RUN apt-get update && apt-get install --yes \
    openjdk-8-jre \
    unzip \
    curl \
    perl

ENV FASTQC_PATH http://www.bioinformatics.babraham.ac.uk/projects/fastqc
ENV FASTQC_ZIP fastqc_v0.11.5.zip
ENV FASTQC_DEST /usr/local

RUN curl -SL ${FASTQC_PATH}/${FASTQC_ZIP} -o /tmp/${FASTQC_ZIP} \
    && unzip /tmp/${FASTQC_ZIP} -d ${FASTQC_DEST} \
    && chmod 755 ${FASTQC_DEST}/FastQC/fastqc \
    && ln -s ${FASTQC_DEST}/FastQC/fastqc /usr/local/bin/fastqc \
    && rm -rf /tmp/${FASTQC_ZIP}
     
ENTRYPOINT ["fastqc"]
CMD ["--help"]
