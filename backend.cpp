#include <stdio.h>
#include <errno.h>
#include <sys/socket.h>
#include <resolv.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <errno.h>
#include <thread>
#include <vector>
#include <map>
#include <string.h>
#include <atomic>
#include <mutex>

#define MY_PORT		9999
#define MAXBUF		1024


struct user_t {
    int id;
    char username[100];
    char password[100];
};

struct client_t {
    int sock;
    user_t* user;
    int headerbytes;
    int bytesleft;
    int bufferpointer;
    union len {
	unsigned char length_c[2];
	short length_s;
    } length;
    char buffer[2048];
};

struct bugreport_t {
    int id;
    int reporterid;
    int priority;
    int assignee;
    char title[100];
    char description[1000];
};

std::mutex mapMutex;
std::atomic<int> USERCOUNTER, REPORTCOUNTER, CLIENTCOUNTER;
std::map<int, bugreport_t*> bugreports;
std::map<int, user_t*> users;
std::map<int, client_t*> clients;

void createAccount(const char* user, const char* pass) {
    std::lock_guard<std::mutex> lock(mapMutex);
    user_t *usr = (user_t *) malloc(sizeof(user_t));
    usr->id = USERCOUNTER++;
    strcpy(usr->username, user);
    strcpy(usr->password, pass);
    users[usr->id] = usr;
}

void addClient(int sock) {
    std::lock_guard<std::mutex> lock(mapMutex);
    client_t *client = (client_t*) malloc(sizeof(client_t));
    client->sock = sock;
    client->user = NULL;
    clients[client->sock] = client;
}

void reportBug(const char* title, const char* desc, int asgn, int reporter, int prio) {
    std::lock_guard<std::mutex> lock(mapMutex);
    bugreport_t *report = (bugreport_t*) malloc(sizeof(bugreport_t));
    report->id = REPORTCOUNTER++;
    strcpy(report->title, title);
    strcpy(report->description, desc);
    report->assignee = asgn;
    report->reporterid = reporter;
    report->priority = prio;
    bugreports[report->id] = report;
}

void disconnectClient(int sock) {
    std::lock_guard<std::mutex> lock(mapMutex);
    client_t *client = clients[sock];
    if (client != NULL) {
	free(client);
	clients.erase(sock);
    }
    close(sock);
}


void processPacket(client_t *client) {
    char packetid = client->buffer[0];
    
    printf("received (%d): %s\n", ntohs(client->length.length_s), client->buffer);
    char asd[2] = {'a','b'};
    send(client->sock, asd, 2, 0);
    switch(packetid) {
    case 0: //register - 100 byte user - 100 byte pass
	char username[100], password[100];
	
	memcpy(username, &client->buffer[1], 100);
	memcpy(password, &client->buffer[101], 100);
	bool found = false;
	for(auto &it: users) {
	    if (strncmp(it.second->username, username, 100) == 0 ) {
		found = true;
	    }
	}

	if (found) {
	    
	}
	else {
	    createAccount(username, password);
	}

	break;
   
    }
}

int receivePacket(client_t *client) {
    if (client->headerbytes < 2) {
	int count= recv(client->sock, client->length.length_c + client->headerbytes, 2 - client->headerbytes, 0);
        if (count <= 0)
            return -1;
	
        client->headerbytes += count;
	if (client->headerbytes >= 2)
	    client->bytesleft = ntohs(client->length.length_s);
        
        return 1;
    }
    else {
        int count = recv(client->sock, client->buffer + client->bufferpointer, client->bytesleft, 0);
        if (count <= 0)
            return -1;
	client->bytesleft -= count;
	client->bufferpointer += count;

	// got the packet
	if (client->bytesleft <= 0) {
	    client->bufferpointer = 0;
	    client->headerbytes = 0;
	    client->bytesleft = 0;
        client->buffer[2047] = '\0';
	    processPacket(client);
        
	}
        return 1;
    }
}



void clientWorker(int sock) {
    char buff[1024];
    addClient(sock);

    while (1) {
    int count = receivePacket(clients[sock]);
	//int count = recv(sock, buff, 1024, 0);
	if (count <= 0) {
	    perror("client disconnected");
	    break;
	}
	
    }
    disconnectClient(sock);
}



int main(int Count, char *Strings[]) {  
    USERCOUNTER.store(0);
    REPORTCOUNTER.store(0);
    CLIENTCOUNTER.store(0);

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
	addClient(clientfd);
        clientworkers.push_back(std::thread(clientWorker, clientfd));

    }

    for (auto &thr : clientworkers) {
	thr.join();
    }

    close(sockfd);
    return 0;
}











