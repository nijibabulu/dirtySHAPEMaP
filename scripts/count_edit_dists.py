#! /usr/bin/env python3

import sys
import click
from Bio import SeqIO
import numpy as np

@click.command()
@click.option("--verbose", "-v", is_flag=True, help="Print verbose messages.")
@click.option("--start", "-s", default=0, help="Start position.")
@click.option("--end", "-e", default=-1, help="End position.")
@click.argument("ref_fasta")
@click.argument("fasta")
def count_edit_dists(verbose, start, end, ref_fasta, fasta):
    """Count the number of edit distances between sequences in a fasta file and a reference fasta file."""
    try:
        ref_seq = SeqIO.read(ref_fasta, "fasta")
    except ValueError:
        raise SystemExit("Reference fasta file must contain exactly one sequence.")

    if start >= len(ref_seq.seq) or end > len(ref_seq.seq):
        raise SystemExit("Start and end positions must be within the reference sequence.")
    
    if verbose:
        print("Full reference: {}".format(ref_seq.seq), file=sys.stderr)
        print("Reference subsequence: {}".format(ref_seq.seq[start:end]), file=sys.stderr)

    hist = np.zeros(len(ref_seq.seq[start:end]) + 1, dtype=np.int32)

    for record in SeqIO.parse(fasta, "fasta"):
        if(len(ref_seq.seq) != len(record.seq)):
            raise SystemExit("Sequence lengths do not match.")
        dist = sum([r != q for (r, q) in zip(ref_seq.seq[start:end], record.seq[start:end])])
        hist[dist] += 1

    for i, count in enumerate(hist):
        print("{}\t{}".format(i, count))

if __name__ == "__main__":
    count_edit_dists()


    