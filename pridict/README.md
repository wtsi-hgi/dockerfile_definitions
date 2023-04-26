Here we have a Docker definition file for PRIDICT: https://github.com/uzh-dqbm-cmi/PRIDICT
Image is built by:
```docker build . -t mercury/pridict```

Once the Dockerfile is built we convert it ti singularity image by:
```sudo singularity build pridict.img Singularity```