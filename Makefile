DEBUG=
CXX=g++
CXXFLAGS=-std=c++11 -Wall -O3 -Wno-psabi $(DEBUG)
BIN=nexus433
LIBS=-lgpiod -lpthread -lmosquittopp

SRC=$(wildcard *.cpp)
OBJ=$(SRC:%.cpp=%.o)

all: $(OBJ)
	$(CXX) $(LIBS) -o $(BIN) $^

clean:
	rm -f *.o
	rm -f $(BIN)

install:
	cp nexus433 /usr/local/bin
	cp nexus433.service /etc/systemd/system/
	cp nexus433.ini /etc

uninstall:
	rm -f /usr/local/bin/nexus433
	rm -f /etc/systemd/system/nexus433.service
	rm -f /etc/nexus433.ini

main.cpp : version
.PHONY: main.cpp
.PHONY: version
version:
	@echo "Generating version info"
	@echo -n \#define VERSION \" > _VERSION
	@echo -n `date --utc +%FT%T` >> _VERSION
	@echo -n " " >> _VERSION
	@echo -n `git rev-parse --short HEAD` >> _VERSION
	@echo \" >>_VERSION
