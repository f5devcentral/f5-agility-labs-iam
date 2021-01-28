Module 1 - Deploy an API Protection Profile
===========================================

An API protection profile is the primary tool that Access Policy Manager administrators use to safeguard API servers. Protection profiles define groups of related RESTful APIs used by applications. The protection profile contains a list of paths that may appear in a request. The system classifies requests and sends them to specific API servers.

The simplest way to create an API protection profile and establish API protection is using an OpenAPI Spec file to import the details of the APIs. If you use an OpenAPI Spec file, Access Policy Manager automatically creates the following (depending on what's included in the spec file):

- API Protection Profile
- Paths
- API servers
- Responses
- Per-request policy with a Request Classification agent and a subroutine containing an OAuth scope check agent


To enable API protection, the API Protection Profile must be associated with a virtual server. If using API Protection, the virtual server can have only one API Protection Profile associated with it. You cannot select other access profiles or per-request policies in that virtual server.


.. toctree::
   :maxdepth: 1
   :glob:

   lab*
