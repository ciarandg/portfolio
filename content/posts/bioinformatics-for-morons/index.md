---
title: "Bioinformatics for Biological Morons"
date: 2025-05-07T00:00:00-06:00
draft: false
tags: ["bioinformatics", "r"]
downloads: []
blog: true
tableOfContents: true
---

Back in grade school, I never felt quite as ill-equipped, or frankly as stupid, as I did in biology class. In a twist of fate, I am dating a geneticist, and have been forced to reckon with the fact that his research is both fascinating and mostly beyond my grasp. Fortunately, when I'm not moping in a blog post, I can make myself useful through the god-given duty bestowed upon all DevOps engineers: tech support.

This post is intended to chronicle my journey through the world of bioinformatics tooling, as a complete outsider to the field of biology. I'll probably come back and update this post as I learn more.

## File Formats

### FASTA

FASTA is a plaintext format for storing nucleotide sequences. You can find a brief spec [here](https://www.ncbi.nlm.nih.gov/genbank/fastaformat/). You will often find these files gzipped with a `.fa.gz` file extension.

An example:

```fasta
>seq1 my cool nucleotide sequence
ATCGTACGATCGATCGATCG
```

### FASTQ

FASTQ is also a plaintext format for storing nucleotide sequences. Unlike FASTA, it contains both raw sequence data and quality scores for each base (each A/T/C/G letter in a sequence is a "nucleotide base").

An example:
```fastq
@seq1
ATCGTACGATCG
+
!''*((((***+
```

You can see that the line of scores is the same length as the the sequence. This is because each character is a score for the corresponding nucleotide base (e.g. `!` is the score for the first `A`). These scores are ASCII-encoded _Phred quality scores_, which represent the probability of an incorrect base call. See [Wikipedia](https://en.wikipedia.org/wiki/Phred_quality_score) for more details on Phred scores (it's actually very simple!).

## Languages

## Package Management

### Conda and Mamba

These two package managers are broadly equivalent. Mamba is just a faster drop-in replacement for Conda. They are _multi-language_ environment and package managers, which is important in bioinformatics, since the field seems to rely on both Python and R so heavily.

### Anaconda

Anaconda is a data science focused distribution of Python, including the `conda` CLI and a whole load of Python packages. It is very much batteries-included. Recently, they have shamelessly rebranded as "The Operating System for AI", as if data science and AI are a tautology. I hope they get the funding they need.

### Miniconda

Miniconda is a pared-down version of Anaconda, only including `conda` and its dependencies. With Miniconda, you need to install all your dependencies à la carte through the `conda` CLI.

### Micromamba

Micromamba is a smaller, standalone version of Mamba with less batteries included. It doesn't depend on an external Python install, making it useful for CI/CD, containerization, and other automated workflows.

### Bioconductor

Bioconductor is an R package repository specifically tailored to bioinformatics. It is exposed to the Conda/Mamba package managers through the `bioconda` channel.

### Nix

My initial impression is: just give up on Nix for bioinformatics work. I've been playing with this tooling on NixOS and it has been a serious headache; I ended up just spinning up an Ubuntu Distrobox and doing all my package management with Conda.

There are interesting tools in the Nix ecosystem, such as [bionix](https://github.com/PapenfussLab/bionix) and [rix](https://github.com/ropensci/rix). If I was a researcher, I think that the reproducibility Nix offers would seem very compelling to me, but it seems that bioinformatics has a very mature tooling ecosystem that is pretty much totally parallel to most of the tooling I use in my day-to-day as a software engineer.

## Tools

### Salmon

Salmon is a tool that performs _transcript quantification_ on RNA sequencing data. Do I understand what that means? Barely. To install it, add `bioconda` to your conda environment, and run `conda install salmon`.

I'll probably write some more about Salmon down the line when I understand a bit more about it.

## Learning Resources

### Wikipedia Articles

- [FASTQ format](https://en.wikipedia.org/wiki/FASTQ_format)
- [FASTA format](https://en.wikipedia.org/wiki/FASTA_format)
- [Phred quality score](https://en.wikipedia.org/wiki/Phred_quality_score)

### Tutorials

- [Sanbomics: RNAseq Mapping with Salmon for Differential Expression](https://www.youtube.com/watch?v=hJB7cHfmppc)
