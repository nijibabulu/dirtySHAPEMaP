#! /usr/bin/env python3

import sys
import tdqm
import click
from Bio import SeqIO
import numpy as np

@click.command()
@click.option("--verbose", "-v", is_flag=True, help="Print verbose messages.")
@click.argument("fasta")
def pwm_generate(verbose, fasta):
    """Generate a position specific matrix from a fasta file. Note 
    all sequences in the  fasta file is assumed to have the same length."""
    first_seq = next(SeqIO.parse(fasta, "fasta"))
    pwm_len = len(first_seq.seq)
    pwm = np.zeros((pwm_len, 4))
    if(verbose):
        print("Sequence length: {}".format(pwm_len), file=sys.stderr)
        pb = tdqm.tqdm(total=pwm_len, file=sys.stderr)
    for record in SeqIO.parse(fasta, "fasta"):
        for i, base in enumerate(record.seq):
            if base == "A":
                pwm[i, 0] += 1
            elif base == "C":
                pwm[i, 1] += 1
            elif base == "G":
                pwm[i, 2] += 1
            elif base == "T":
                pwm[i, 3] += 1

    pwm = pwm / pwm.sum(axis=1, keepdims=True)
    np.savetxt(sys.stdout, pwm, fmt="%.3f", delimiter="\t")

if __name__ == "__main__":
    pwm_generate()
