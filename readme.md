``
docker run -it --rm -v $(pwd)/tor:/var/lib/tor y0uls/irctor generate <pattern>
``

``
docker run -d --restart=always --name irctor -v $(pwd)/tor:/var/lib/tor y0uls/irctor
``
