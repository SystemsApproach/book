1.4 Software
============

Network architectures and protocol specifications are essential
things, but a good blueprint is not enough to explain the phenomenal
success of the Internet: The number of computers connected to the
Internet has grown exponentially for over three decades (although
precise numbers are hard to come by). The number of users of the
Internet was estimated to be around 4.1 billion by the end of
2018—roughly half of the world’s population.

What explains the success of the Internet? There are certainly many
contributing factors (including a good architecture), but one thing that
has made the Internet such a runaway success is the fact that so much of
its functionality is provided by software running on general-purpose
computers. The significance of this is that new functionality can be
added readily with “just a small matter of programming.” As a result,
new applications and services have been showing up at an incredible
pace.

A related factor is the massive increase in computing power available
in commodity machines. Although computer networks have always been
capable in principle of transporting any kind of information, such as
digital voice samples, digitized images, and so on, this potential was
not particularly interesting if the computers sending and receiving
that data were too slow to do anything useful with the
information. Virtually all of today’s computers are capable of playing
back digitized audio and video at a speed and resolution that are
quite usable.

In the years since the first edition of this book appeared, the
writing of networked applications has become a mainstream activity and
not a job just for a few specialists. Many factors have played into
this, including better tools to make the job easier and the opening up
of new markets such as applications for smartphones.

The point to note is that knowing how to implement network software is
an essential part of understanding computer networks, and while the odds
are you will not be tasked to implement a low-level protocol like IP,
there is a good chance you will find reason to implement an
application-level protocol—the elusive “killer app” that will lead to
unimaginable fame and fortune. To get you started, this section
introduces some of the issues involved in implementing a network
application on top of the Internet. Typically, such programs are
simultaneously an application (i.e., designed to interact with users)
and a protocol (i.e., communicates with peers across the network).

Application Programming Interface (Sockets)
-------------------------------------------

The place to start when implementing a network application is the
interface exported by the network. Since most network protocols are in
software (especially those high in the protocol stack), and nearly all
computer systems implement their network protocols as part of the
operating system, when we refer to the interface “exported by the
network,” we are generally referring to the interface that the OS
provides to its networking subsystem. This interface is often called the
network *application programming interface* (API).

Although each operating system is free to define its own network API
(and most have), over time certain of these APIs have become widely
supported; that is, they have been ported to operating systems other
than their native system. This is what has happened with the *socket
interface* originally provided by the Berkeley distribution of Unix,
which is now supported in virtually all popular operating systems, and
is the foundation of language-specific interfaces, such as the Java or
Python socket library. We use Linux and C for all code examples in
this book, Linux because it is open source and C because it remains
the language of choice for network internals. (C also has the
advantage of exposing all the low-level details, which is helpful in
understanding the underlying ideas.)

.. sidebar:: Sockets Enabled Application Explosion

	     It is hard to overstate the importance of the Socket
	     API. It defines the demarcation point between the
	     applications running on top of the Internet, and the
	     details of how the Internet is implemented. As a
	     consequence of Sockets providing a well-defined and
	     stable interface, writing Internet applications exploded
	     into a multi-billion dollar industry. Starting from the
	     humble beginnings of the client/server paradigm and a
	     handful of simple application programs like email, file
	     transfer, and remote login, everyone now has access to an
	     never-ending supply of cloud applications from their
	     smartphones.

	     This section lays the foundation by revisiting the
	     simplicity of a client program opening a socket so it can
	     exchange messages with a server program, but today a rich
	     software ecosystem is layered on top of the Socket
	     API. This layer includes a plethora of cloud-based tools
	     that lower the barrier for implementing scalable
	     applications. We return to the interplay between the
	     cloud and the network in every chapter, starting with the
	     *Perspective* section at the end of Chapter 1.

Before describing the socket interface, it is important to keep two
concerns separate in your mind. Each protocol provides a certain set of
*services*, and the API provides a *syntax* by which those services can
be invoked on a particular computer system. The implementation is then
responsible for mapping the tangible set of operations and objects
defined by the API onto the abstract set of services defined by the
protocol. If you have done a good job of defining the interface, then it
will be possible to use the syntax of the interface to invoke the
services of many different protocols. Such generality was certainly a
goal of the socket interface, although it’s far from perfect.

The main abstraction of the socket interface, not surprisingly, is the
*socket*. A good way to think of a socket is as the point where a local
application process attaches to the network. The interface defines
operations for creating a socket, attaching the socket to the network,
sending/receiving messages through the socket, and closing the socket.
To simplify the discussion, we will limit ourselves to showing how
sockets are used with TCP.

The first step is to create a socket, which is done with the following
operation:

.. code-block:: c

   int socket(int domain, int type, int protocol);

The reason that this operation takes three arguments is that the socket
interface was designed to be general enough to support any underlying
protocol suite. Specifically, the ``domain`` argument specifies the
protocol *family* that is going to be used: ``PF_INET`` denotes the
Internet family, ``PF_UNIX`` denotes the Unix pipe facility, and
``PF_PACKET`` denotes direct access to the network interface (i.e., it
bypasses the TCP/IP protocol stack). The ``type`` argument indicates the
semantics of the communication. ``SOCK_STREAM`` is used to denote a byte
stream. ``SOCK_DGRAM`` is an alternative that denotes a message-oriented
service, such as that provided by UDP. The ``protocol`` argument
identifies the specific protocol that is going to be used. In our case,
this argument is ``UNSPEC`` because the combination of ``PF_INET`` and
``SOCK_STREAM`` implies TCP. Finally, the return value from ``socket``
is a *handle* for the newly created socket—that is, an identifier by
which we can refer to the socket in the future. It is given as an
argument to subsequent operations on this socket.

The next step depends on whether you are a client or a server. On a
server machine, the application process performs a *passive* open—the
server says that it is prepared to accept connections, but it does not
actually establish a connection. The server does this by invoking the
following three operations:

.. code-block:: c

   int bind(int socket, struct sockaddr *address, int addr_len);
   int listen(int socket, int backlog);
   int accept(int socket, struct sockaddr *address, int *addr_len);

The ``bind`` operation, as its name suggests, binds the newly created
``socket`` to the specified ``address``. This is the network address of
the *local* participant—the server. Note that, when used with the
Internet protocols, ``address`` is a data structure that includes both
the IP address of the server and a TCP port number. Ports are used to
indirectly identify processes. They are a form of *demux keys*. The port
number is usually some well-known number specific to the service being
offered; for example, web servers commonly accept connections on port
80.

The ``listen`` operation then defines how many connections can be
pending on the specified ``socket``. Finally, the ``accept`` operation
carries out the passive open. It is a blocking operation that does not
return until a remote participant has established a connection, and when
it does complete it returns a *new* socket that corresponds to this
just-established connection, and the ``address`` argument contains the
*remote* participant’s address. Note that when ``accept`` returns, the
original socket that was given as an argument still exists and still
corresponds to the passive open; it is used in future invocations of
``accept``.

On the client machine, the application process performs an *active*
open; that is, it says who it wants to communicate with by invoking the
following single operation:

.. code-block:: c

   int connect(int socket, struct sockaddr *address, int addr_len);

This operation does not return until TCP has successfully established a
connection, at which time the application is free to begin sending data.
In this case, ``address`` contains the remote participant’s address. In
practice, the client usually specifies only the remote participant’s
address and lets the system fill in the local information. Whereas a
server usually listens for messages on a well-known port, a client
typically does not care which port it uses for itself; the OS simply
selects an unused one.

Once a connection is established, the application processes invoke the
following two operations to send and receive data:

.. code-block:: c

   int send(int socket, char *message, int msg_len, int flags);
   int recv(int socket, char *buffer, int buf_len, int flags);

The first operation sends the given ``message`` over the specified
``socket``, while the second operation receives a message from the
specified ``socket`` into the given ``buffer``. Both operations take a
set of ``flags`` that control certain details of the operation.

Example Application
-------------------

We now show the implementation of a simple client/server program that
uses the socket interface to send messages over a TCP connection. The
program also uses other Linux networking utilities, which we introduce as
we go. Our application allows a user on one machine to type in and send
text to a user on another machine. It is a simplified version of the
Linux ``talk`` program, which is similar to the program at the core of
instant messaging applications.

Client
~~~~~~

We start with the client side, which takes the name of the remote
machine as an argument. It calls the Linux utility to translate this name
into the remote host’s IP address. The next step is to construct the
address data structure (``sin``) expected by the socket interface.
Notice that this data structure specifies that we’ll be using the socket
to connect to the Internet (``AF_INET``). In our example, we use TCP
port 5432 as the well-known server port; this happens to be a port that
has not been assigned to any other Internet service. The final step in
setting up the connection is to call ``socket`` and ``connect``. Once
the operation returns, the connection is established and the client
program enters its main loop, which reads text from standard input and
sends it over the socket.

.. code-block:: c

   #include <stdio.h>
   #include <sys/types.h>
   #include <sys/socket.h>
   #include <netinet/in.h>
   #include <netdb.h>

   #define SERVER_PORT 5432
   #define MAX_LINE 256

   int
   main(int argc, char * argv[])
   {
     FILE *fp;
     struct hostent *hp;
     struct sockaddr_in sin;
     char *host;
     char buf[MAX_LINE];
     int s;
     int len;

     if (argc==2) {
       host = argv[1];
     }
     else {
       fprintf(stderr, "usage: simplex-talk host\n");
       exit(1);
     }

     /* translate host name into peer's IP address */
     hp = gethostbyname(host);
     if (!hp) {
       fprintf(stderr, "simplex-talk: unknown host: %s\n", host);
       exit(1);
     }

     /* build address data structure */
     bzero((char *)&sin, sizeof(sin));
     sin.sin_family = AF_INET;
     bcopy(hp->h_addr, (char *)&sin.sin_addr, hp->h_length);
     sin.sin_port = htons(SERVER_PORT);

     /* active open */
     if ((s = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
       perror("simplex-talk: socket");
       exit(1);
     }
     if (connect(s, (struct sockaddr *)&sin, sizeof(sin)) < 0)
     {
       perror("simplex-talk: connect");
       close(s);
       exit(1);
     }
     /* main loop: get and send lines of text */
     while (fgets(buf, sizeof(buf), stdin)) {
       buf[MAX_LINE-1] = '\0';
       len = strlen(buf) + 1;
       send(s, buf, len, 0);
     }
   }

Server
~~~~~~

The server is equally simple. It first constructs the address data
structure by filling in its own port number (``SERVER_PORT``). By not
specifying an IP address, the application program is willing to accept
connections on any of the local host’s IP addresses. Next, the server
performs the preliminary steps involved in a passive open; it creates
the socket, binds it to the local address, and sets the maximum number
of pending connections to be allowed. Finally, the main loop waits for a
remote host to try to connect, and when one does, it receives and prints
out the characters that arrive on the connection.

.. code-block:: c

   #include <stdio.h>
   #include <sys/types.h>
   #include <sys/socket.h>
   #include <netinet/in.h>
   #include <netdb.h>

   #define SERVER_PORT  5432
   #define MAX_PENDING  5
   #define MAX_LINE     256

   int
   main()
   {
     struct sockaddr_in sin;
     char buf[MAX_LINE];
     int buf_len, addr_len;
     int s, new_s;

     /* build address data structure */
     bzero((char *)&sin, sizeof(sin));
     sin.sin_family = AF_INET;
     sin.sin_addr.s_addr = INADDR_ANY;
     sin.sin_port = htons(SERVER_PORT);

     /* setup passive open */
     if ((s = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
       perror("simplex-talk: socket");
       exit(1);
     }
     if ((bind(s, (struct sockaddr *)&sin, sizeof(sin))) < 0) {
       perror("simplex-talk: bind");
       exit(1);
     }
     listen(s, MAX_PENDING);
     
    /* wait for connection, then receive and print text */
     while(1) {
       if ((new_s = accept(s, (struct sockaddr *)&sin, &addr_len)) < 0) {
         perror("simplex-talk: accept");
         exit(1);
       }
       while (buf_len = recv(new_s, buf, sizeof(buf), 0))
         fputs(buf, stdout);
       close(new_s);
     }
   }
