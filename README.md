helloworld
==========

Create Docker image FROM scratch

This GitHub repository belongs with the following blog post:

http://blog.xebia.com/2014/07/04/create-the-smallest-possible-docker-container/

_**Update (11 May 2017):** The image creation process is greatly simplified with the introduction of Multi-Stage Builds. See my new blog “[Simplify the Smallest Possible Docker Image](https://medium.com/@adriaandejonge/simplify-the-smallest-possible-docker-image-62c0e0d342ef)”_

The helloworld.go provides a simple web server that says Hello World. The Dockerfile creates a Docker image from scratch and places the Hello World web server inside it.
