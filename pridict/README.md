Here we have a Docker definition file for PRIDICT: https://github.com/uzh-dqbm-cmi/PRIDICT
Image is built by:
```docker build . -t mercury/pridict```

Once the Dockerfile is built we convert it ti singularity image by:
```sudo singularity build pridict.img Singularity```

Once the image is built the PRIDICT can be run by:
```singularity exec --bind /lustre /path/to/pridict/image/pridict_20_04_2023.img /home/container_user/PRIDICT/pridict_pegRNA_design.py manual --sequence-name seq1 --sequence 'GCCTGGAGGTGTCTGGGTCCCTCCCCCACCCGACTACTTCACTCTCTGTCCTCTCTGCCCAGGAGCCCAGGATGTGCGAGTTCAAGTGGCTACGGCCGA(G/C)GTGCGAGGCCAGCTCGGGGGCACCGTGGAGCTGCCGTGCCACCTGCTGCCACCTGTTCCTGGACTGTACATCTCCCTGGTGACCTGGCAGCGCCCAGATGCACCTGCGAACCACCAGAATGTGGCCGC' --output-dir /lustre/scratch125/humgen/teams/hgi/mo11/container```

NOTE:
1) /home/container_user/PRIDICT/pridict_pegRNA_design.py - this is a location within the container. (Can be symlinked to avoid the ugly path, but this is not mandatory)
2) --output-dir : has to be a path of where the output results should be emited. 
3) --bind: please bind your local path where the putput directory sits.