FROM ubuntu:22.04

RUN apt update
RUN apt install sudo
RUN sudo apt-get install software-properties-common -y

###Install Python
RUN sudo add-apt-repository ppa:deadsnakes/ppa
RUN sudo apt install python3.10 python3.10-dev -y

### Install prerequisite
RUN sudo apt install -y git build-essential apt-utils cmake libfontconfig1 libglu1-mesa-dev libgtest-dev libspdlog-dev libboost-all-dev libncurses5-dev libgdbm-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev mesa-common-dev qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools libqt5websockets5 libqt5websockets5-dev qtdeclarative5-dev golang-go qtbase5-dev libqt5websockets5-dev python3-dev libboost-all-dev mingw-w64 nasm

WORKDIR /opt
### For Havoc client
RUN git clone https://github.com/HavocFramework/Havoc.git

# Install Go and compile
RUN cd Havoc/teamserver && go mod download golang.org/x/sys && go mod download github.com/ugorji/go
RUN cd Havoc/ && make ts-build
RUN cd Havoc/ && make client-build

COPY start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/start.sh"]
