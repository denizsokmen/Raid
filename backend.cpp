#include <stdio.h>
#include <errno.h>
#include <sys/socket.h>
#include <resolv.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <errno.h>
#include <thread>
#include <vector>

#define MY_PORT		9999
#define MAXBUF		1024


void clientWorker(int socket) {
    char buff[1024];
    printf("het\n");
    while (1) {
	int count = recv(socket, buff, 1024, 0);
	if (count <= 0) {
	    printf("disconnected: %d\n", socket);
	    close(socket);
	    break;
	}
	else if (count > 0) {
	    printf("received: %s\n", buff);
	}
    }
    
}

int main(int Count, char *Strings[]) {  
    std::vector<std::thread> clientworkers;
    int sockfd;
    struct sockaddr_in self;
    char buffer[MAXBUF];

    if ( (sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0 ) {
	perror("Socket");
	_exit(errno);
    }

    
    self.sin_family = AF_INET;
    self.sin_port = htons(MY_PORT);
    self.sin_addr.s_addr = INADDR_ANY;

    if ( bind(sockfd, (struct sockaddr*)&self, sizeof(self)) != 0 ) {
	perror("socket--bind");
	_exit(errno);
    }

    if ( listen(sockfd, 20) != 0 ) {
	perror("socket--listen");
	_exit(errno);
    }

    while (1) {	
	int clientfd;
	struct sockaddr_in client_addr;
	socklen_t addrlen=sizeof(client_addr);
        
	clientfd = accept(sockfd, (struct sockaddr*)&client_addr, &addrlen);
	printf("%s:%d connected\n", inet_ntoa(client_addr.sin_addr), ntohs(client_addr.sin_port));
	
        clientworkers.push_back(std::thread(clientWorker, clientfd));

    }

    for (auto &thr : clientworkers) {
	thr.join();
    }

    close(sockfd);
    return 0;
}











