FROM ubuntu:latest

WORKDIR /app

ADD GoLinkShortener/GoLinkShortener /app
ADD GoLinkShortener/index.html /app
ADD GoLinkShortener/background.jpg /app

USER nobody

EXPOSE 5100:5100
CMD ["/app/GoLinkShortener"]
