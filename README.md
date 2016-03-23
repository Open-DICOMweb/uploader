#Files Uploader

This Project is to create prototype uploaders either a browser or
or an independent user agent.  There are two clients: browser and cmd
line and one server.

## Protocols
There are three different protocols being tried:
  1. HTTP1/1
  2. HTTP/2
  3. WebSockets

##General Workflow

  1. Select one or more files to upload

  2. Send one file at a time either as a whole or in chunks.

  3. The server receives the file as one or more chunks and stores it
     in a DICOM file system using the standard naming convention.

## Example HTTP messages

  1. Request

     POST SP /dicom/store/{study} SP version
     Content-Type: [application/dicom, application/json, application/dicom+xml]
     Accept: 'text/utf-8'
     [Range: bytes = start-end]
     payload

  2. Response

     HTTP/1.1 SP status SP reason
     payload

     where payload is a UTF-8 message confirming the receipt

### Client ###

* The Client divides the files into one or more parts and sends them to the server.
* Version: only test

### Server

The server is in the /bin director and can be run in WebStorm.

### Setup ###

1. Download project
2. Open in WebStorm
3. Run it
4. Client works with the server [uploaderserver](https://bitbucket.org/tookman/uploaderserver)
