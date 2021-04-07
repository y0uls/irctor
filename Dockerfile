FROM debian:jessie

LABEL maintainer "y0uls"

# Base packages
RUN apt-get update && apt-get -y install make inspircd tor torsocks ntpdate build-essential libssl-dev 

# Compile shallot
ADD ./shallot /shallot
RUN cd /shallot && make && mv ./shallot /bin && cd / && rm -Rf /shallot && apt-get -y purge build-essential libssl-dev && rm -Rf /var/lib/apt/lists/*

# Compile script
ADD ./compile.sh /compile.sh

# Tor Config
ADD ./torrc /etc/tor/torrc

# Inspircd Config
ADD ./inspircd /etc/default/inspircd

ENTRYPOINT ["/compile.sh"]
CMD ["serve"]