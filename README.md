[![Docker Repository on Quay.io](https://quay.io/repository/briandoconnor/fastqc/status "Docker Repository on Quay.io")](https://quay.io/repository/briandoconnor/fastqc)

# fastqc

A repo for the `Dockerfile` to create a Docker image for the fastqc command. Also contains the
`Dockstore.cwl` which is used by the [Dockstore](https://www.dockstore.org) to register
this container and describe how to call fastqc for the community.

## Validation

This tool has been validated as a CWL v1.0 CommandLineTool.

## Building Manually

Normally you would let [Quay.io](http://quay.io) build this.  But, if you need to build
manually you would execute:

    docker build -t quay.io/briandoconnor/fastqc:0.11.5 .

## Running Manually

```
# get some NA12878 fastq data
$ wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/140313_D00360_0014_AH8GGVADXX/Project_RM8398/Sample_U0b/U0b_TGACCA_L002_R1_006.fastq.gz
$ docker run -it -v `pwd`/U0b_TGACCA_L002_R1_006.fastq.gz:/U0b_TGACCA_L002_R1_006.fastq.gz quay.io/briandoconnor/fastqc:0.11.5 /bin/bash

# within the docker container
$ /usr/local/bin/run-fastqc --outdir . --fastq /U0b_TGACCA_L002_R1_006.fastq.gz
```

You should see an html and zip output.

## Running Through the Dockstore CLI

This tool can be found at the [Dockstore](https://dockstore.org), login with your GitHub account and follow the directions to setup the CLI.  It lets you run a Docker container with a CWL descriptor locally, using Docker and the CWL command line utility.  This is great for testing.

### Make a Parameters JSON

This is the parameterization of the BAM stat tool, a copy is present in this repo called `fastqc.json`:

```
{
    "fastq_files": [
        {
        "class": "File",
        "path": "https://github.com/briandoconnor/fastqc/blob/master/sample.fastq.gz?raw=true"
        }
    ],
    "tar_files": [
        {
        "class": "File",
        "path": "https://github.com/briandoconnor/fastqc/blob/master/sample.tar?raw=true"
        }
    ],
    "zipped_file" : {
        "class": "File",
        "path": "/tmp/fastqc_reports.tar.gz"
    }
}
```

You can leave out either the fastq_files or tar_files as well.

### Run with the CLI

Run it using the `dockstore` CLI:

    dockstore tool launch --entry fastqc.cwl  --local-entry --json fastqc.json
