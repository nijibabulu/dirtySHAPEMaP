# dirtySHAPEMaP

This project entails the SHAPE-MaP experiments that are planned for a mutagenized library of xrRNA candidates.

## Data description

The original data from the first run is located in `/ifs/data/as6282_gp/share/raw_ngs/20230705-mermade-ssRNA-input`. It consists of 4 lanes of the same library which will be intiially processed separately and then merged. The original data from the second run is located in `/ifs/data/as6282_gp/share/raw_ngs/20230712-mermade-ssRNA-input`

The expected genome sequence was shared via benchling [here](https://benchling.com/jgezelle/f/lib_y7oDUzWh-plasmids-and-sequences/seq_i2X927Dr-2023-05-03-st9-synth1/edit). The entire template (including PCR adaptors) is available in the file `data/lib_y7oDUzWh/full.fa`

## Pipeline

0. Setup

```
mkdir -p work/00_fastq
cp -r /ifs/data/as6282_gp/share/raw_ngs/20230705-mermade-ssRNA-input/A* work/00_fastq
cp -r /ifs/data/as6282_gp/share/raw_ngs/20230712-mermade-ssRNA-input/A* work/00_fastq
```

Note there are two levels of files here. We are ignoring the `trash reads` directory.

1. Link

The naming convention chosen was as follows: `[LIBNAME]-[LIBVERSION]-[LANE]-[DIRECTION]`. `LIBNAME` indicates our intiial template, `LIBVERSION` is the experiment ID, `LANE` is the lane and `DIRECTION` is one of either `f` or `r` to indicate its direction.
```
mkdir -p work/01_link
ln -s $(realpath work/00_fastq/A3489_L001-ds.848b830a2d744187990425bf018f1271/SL-NGS-indices-plate16-Well-A01_S481_L001_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-01-01-f.fastq.gz
ln -s $(realpath work/00_fastq/A3489_L001-ds.848b830a2d744187990425bf018f1271/SL-NGS-indices-plate16-Well-A01_S481_L001_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-01-01-r.fastq.gz
ln -s $(realpath work/00_fastq/A3489_L002-ds.43194ae4c89f4bf5ac6ce6f646ad1bf7/SL-NGS-indices-plate16-Well-A01_S481_L002_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-01-02-f.fastq.gz
ln -s $(realpath work/00_fastq/A3489_L002-ds.43194ae4c89f4bf5ac6ce6f646ad1bf7/SL-NGS-indices-plate16-Well-A01_S481_L002_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-01-02-r.fastq.gz
ln -s $(realpath work/00_fastq/A3489_L003-ds.1a37f9ad4c3e43a59e24d0b03fc5a566/SL-NGS-indices-plate16-Well-A01_S481_L003_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-01-03-f.fastq.gz
ln -s $(realpath work/00_fastq/A3489_L003-ds.1a37f9ad4c3e43a59e24d0b03fc5a566/SL-NGS-indices-plate16-Well-A01_S481_L003_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-01-03-r.fastq.gz
ln -s $(realpath work/00_fastq/A3489_L004-ds.1817babf9f5848deb6390825177c9395/SL-NGS-indices-plate16-Well-A01_S481_L004_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-01-04-f.fastq.gz
ln -s $(realpath work/01_fastq/A3489_L004-ds.1817babf9f5848deb6390825177c9395/SL-NGS-indices-plate16-Well-A01_S481_L004_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-01-04-r.fastq.gz


ln -s $(realpath work/00_fastq/A3472_L001-ds.b3ceff5212c848b3bfbe028283ab4487/SL-NGS-indices-plate16-Well-D01_S421_L001_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-01-f.fastq.gz
ln -s $(realpath work/00_fastq/A3472_L001-ds.b3ceff5212c848b3bfbe028283ab4487/SL-NGS-indices-plate16-Well-D01_S421_L001_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-01-r.fastq.gz
ln -s $(realpath work/00_fastq/A3472_L002-ds.e81cba3d68ff4fa2a89edcf135ee6492/SL-NGS-indices-plate16-Well-D01_S421_L002_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-02-f.fastq.gz
ln -s $(realpath work/00_fastq/A3472_L002-ds.e81cba3d68ff4fa2a89edcf135ee6492/SL-NGS-indices-plate16-Well-D01_S421_L002_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-02-r.fastq.gz
ln -s $(realpath work/00_fastq/A3472_L003-ds.ec69e41d93c547ffb028382a1fcfb45d/SL-NGS-indices-plate16-Well-D01_S421_L003_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-03-f.fastq.gz
ln -s $(realpath work/00_fastq/A3472_L003-ds.ec69e41d93c547ffb028382a1fcfb45d/SL-NGS-indices-plate16-Well-D01_S421_L003_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-03-r.fastq.gz
ln -s $(realpath work/00_fastq/A3472_L004-ds.51372b112da94d05b0cdf76e20a5f55f/SL-NGS-indices-plate16-Well-D01_S421_L004_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-04-f.fastq.gz
ln -s $(realpath work/00_fastq/A3472_L004-ds.51372b112da94d05b0cdf76e20a5f55f/SL-NGS-indices-plate16-Well-D01_S421_L004_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-04-r.fastq.gz
ln -s $(realpath work/00_fastq/A3480_L001-ds.ca28af0bf5594ad3960c2887a4ed5a2c/SL-NGS-indices-plate16-Well-E01_S433_L001_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-05-f.fastq.gz
ln -s $(realpath work/00_fastq/A3480_L001-ds.ca28af0bf5594ad3960c2887a4ed5a2c/SL-NGS-indices-plate16-Well-E01_S433_L001_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-05-r.fastq.gz
ln -s $(realpath work/00_fastq/A3480_L002-ds.9ca63bd40e464174ba883c3745c38379/SL-NGS-indices-plate16-Well-E01_S433_L002_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-06-f.fastq.gz
ln -s $(realpath work/00_fastq/A3480_L002-ds.9ca63bd40e464174ba883c3745c38379/SL-NGS-indices-plate16-Well-E01_S433_L002_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-06-r.fastq.gz
ln -s $(realpath work/00_fastq/A3480_L003-ds.bf9e8ef82eed4f339f6ed3bbce2b933b/SL-NGS-indices-plate16-Well-E01_S433_L003_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-07-f.fastq.gz
ln -s $(realpath work/00_fastq/A3480_L003-ds.bf9e8ef82eed4f339f6ed3bbce2b933b/SL-NGS-indices-plate16-Well-E01_S433_L003_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-07-r.fastq.gz
ln -s $(realpath work/00_fastq/A3480_L004-ds.19e54094cea64f5394d306a19311bf43/SL-NGS-indices-plate16-Well-E01_S433_L004_R1_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-08-f.fastq.gz
ln -s $(realpath work/00_fastq/A3480_L004-ds.19e54094cea64f5394d306a19311bf43/SL-NGS-indices-plate16-Well-E01_S433_L004_R2_001.fastq.gz) work/01_link/lib_y7oDUzWh-02-08-r.fastq.gz
```

2. Initial QC

```
qlogin -l mem=4G,time=:60:
cd /ifs/scratch/as6282_gp/rpz2103/dirtySHAPEMaP
mkdir -p work/02_rawqc
module load fastqc python3 pyyaml multiqc
fastqc -o work/02_rawqc work/01_link/*
multiqc -o work/02_rawqc work/02_rawqc
multiqc -o work/02_rawqc --filename lib_y7oDUzWh-02.html --ignore lib_y7oDUzWh-01* work/02_rawqc
```
Inspection of the multifastqc looks as expected.

3. Concatenate fastq files

```
mkdir -p work/03_cat
zcat work/01_link/lib_y7oDUzWh-01-0?-f.fastq.gz | gzip -c > work/03_cat/lib_y7oDUzWh-01-f.fastq.gz
zcat work/01_link/lib_y7oDUzWh-01-0?-r.fastq.gz | gzip -c > work/03_cat/lib_y7oDUzWh-01-r.fastq.gz

zcat work/01_link/lib_y7oDUzWh-02-0?-f.fastq.gz | gzip -c > work/03_cat/lib_y7oDUzWh-02-f.fastq.gz
zcat work/01_link/lib_y7oDUzWh-02-0?-r.fastq.gz | gzip -c > work/03_cat/lib_y7oDUzWh-02-r.fastq.gz
```

4. Merge read files using FLASH(/PEAR)

FASTQ reads are paired and the insert sequence extends beyond the anticipated read size of 75 bp. Therefore we need to reliably merge the reads and choose a consensus base in the case of conflicts (ideally based on quality scores to break ties). Two methods exist that appear reliable and recommended. [PEAR](https://www.h-its.org/software/pear-paired-end-read-merger/) appears to be the most popular, however the website is currently down. For now we use [FLASH](http://ccb.jhu.edu/software/FLASH/), which seems to have a reasonable  algorithm documented [here]((http://ccb.jhu.edu/software/FLASH/FLASH-reprint.pdf).

```
qlogin -l mem=4G,time=:60:
mkdir -p work/04_flash
module load flash
flash --read-len=75 --fragment-len=95 --fragment-len-stddev=2 \
    --output-directory=work/04_flash --output-prefix=lib_y7oDUzWh-01 \
    work/03_cat/lib_y7oDUzWh-01-f.fastq.gz  work/03_cat/lib_y7oDUzWh-01-r.fastq.gz
```

This provided the following relevant output:
```
[FLASH] Read combination statistics:
[FLASH]     Total pairs:      8652818
[FLASH]     Combined pairs:   8489563
[FLASH]     Uncombined pairs: 163255
[FLASH]     Percent combined: 98.11%
```

The histogram shows a strong peak at 95 base pairs as expected.

v2

```
qlogin -l mem=4G,time=:60:
mkdir -p work/04_flash
module load flash
flash --read-len=75 --fragment-len=95 --fragment-len-stddev=2 \
    --output-directory=work/04_flash --output-prefix=lib_y7oDUzWh-02 \
    work/03_cat/lib_y7oDUzWh-02-f.fastq.gz  work/03_cat/lib_y7oDUzWh-02-r.fastq.gz
```

The output is:
```
[FLASH] Read combination statistics:
[FLASH]     Total pairs:      20284277
[FLASH]     Combined pairs:   19994401
[FLASH]     Uncombined pairs: 289876
[FLASH]     Percent combined: 98.57%
```

       
5. PEAR

```
mkdir -p work/05_pear # reserved for future.
```

6. Generate sequence logo

We take a simplified approach to the alignment since it is a very large set of sequences and constrain to only 95 base-paired sequences:
```
mkdir -p work/06_logo
grep '^[ACGT]\{95,95\}$' work/04_flash/lib_y7oDUzWh-01.extendedFrags.fastq | awk '{print ">"NR"\n"$0}' > work/06_logo/lib_y7oDUzWh-01.95seqs.fa
```

Now we generate a PWM from the sequences (this takes long):
```
python3 scripts/fasta_to_pwm.py work/06_logo/lib_y7oDUzWh-01.95seqs.fa > work/06_logo/lib_y7oDUzWh-01.95seqs.counts
```

Now we make the plots with `scripts/seq_logo.R`.
