Description
===========

Installs and configures Zuul, the inter-dependent build job management service that works with Jenkins and Gerrit.

Requirements
============

Platform
--------

* Ubuntu 14.04

Cookbooks
---------

* default
* server
* webapp

Attributes
==========

See `attributes/default.rb` for default values.

Usage
=====

default
-------

Include default recipe in a run list, to get `zuul` service.

License and Author
==================

Author:: Jay Pipes (<jaypipes@gmail.com>)
Author:: Edmund Haselwanter (<me@ehaselwanter.com>)
Author:: Jürgen Brüder (<hello@juergenbrueder.com>)

Copyright:: 2012, Jay Pipes
Copyright:: 2015, Edmund Haselwanter / Jürgen Brüder

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
