FROM golang:alpine
WORKDIR /serviceSTAN
COPY . /serviceSTAN
RUN go build -o main .
CMD ["/serviceSTAN/main"]