#!/usr/bin/env cwl-runner

class: CommandLineTool
id: "fastqc"
label: "A quality control application for high throughput sequence data"
cwlVersion: v1.0

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

doc: |
    ![build_status](https://quay.io/repository/briandoconnor/fastqc/status)
    A Docker container for the fastqc command.
    See the fastqc (http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
    website for more information.


dct:creator:
  '@id': http://orcid.org/0000-0002-7681-6415
  foaf:name: "Brian O'Connor"
  foaf:mbox: "briandoconnor@gmail.com"

requirements:
  - class: DockerRequirement
    dockerPull: "quay.io/briandoconnor/fastqc:0.11.5"

hints:
  - class: ResourceRequirement
    coresMin: 1
    ramMin: 4092
    outdirMin: 512000
    description: "the process requires at least 4G of RAM"

inputs:
  fastq_files:
    type?:
      type: array
      items: File
    format: http://edamontology.org/format_1930
    inputBinding:
      position: 1
      prefix: --fastq

  tar_files:
    type?:
      type: array
      items: File
    format: http://purl.obolibrary.org/obo/OBI_0000326
    inputBinding:
      position: 2
      prefix: --tar

outputs:
  zipped_files:
    type: File
    format: http://purl.obolibrary.org/obo/OBI_0000326
    outputBinding:
      # should be put in the working directory
       glob: "fastqc_reports.tar.gz"
    doc: "This tarball includes individual graph files and additional data files containing the raw data from which plots were drawn along with HTML reports with embedded graphs."

baseCommand: [ "run-fastqc" ]
