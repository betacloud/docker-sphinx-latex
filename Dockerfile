FROM ubuntu:18.04
LABEL maintainer="Betacloud Solutions GmbH (https://www.betacloud-solutions.de)"

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION ${VERSION:-latest}

ENV CONFPATH ${CONFPATH:-/source}
ENV DOCUMENT ${DOCUMENT:-index}
ENV TYPE ${TYPE:-html}

COPY files/logo.png /logo.png
COPY files/conf.py /conf.py
COPY files/run.sh /run.sh

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && apt-get install -y \
      latexmk \
      make \
      python-pip \
      texlive-fonts-recommended \
      texlive-lang-german \
      texlive-latex-extra \
      texlive-latex-recommended \
    && pip install \
      Flask-Sphinx-Themes \
      sphinx \
      sphinxcontrib-blockdiag \
      sphinxcontrib-nwdiag \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY files/latex.tex_t /usr/local/lib/python2.7/dist-packages/sphinx/templates/latex/latex.tex_t

VOLUME /html
VOLUME /latex
VOLUME /pdf
VOLUME /source

WORKDIR /source

ENTRYPOINT ["/run.sh"]
