#Files Uploader

##Protocol

  1. Send File Upload Request

     POST SP uri/uploadFile SP version
     Content-Type: 'text/ascii'
     Accept: 'text/utf-8'
     filename
     studyUri
     seriesUri
     instanceUri
  2. Response

     HTTP/1.1 SP status SP reason
     uri

     Where uri is the target for transfering the contents.



### Client ###

* Client divides the files into parts and sent to the server.
* Version: only test


### Setup ###

1. Download project
2. Open in WebStorm
3. Run it
4. Client works with the server [uploaderserver](https://bitbucket.org/tookman/uploaderserver)
