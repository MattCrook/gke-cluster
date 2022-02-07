## Global External HTTPS Google Cloud LoadBalancer


##### GCP Docs: https://cloud.google.com/load-balancing/docs/https


LoadBalancer that is globally external internet facing, supports SSL/TLS termination at the load balancer level, and forwards to backend services that are a Managed (or un managed) Instance Group. Load Balancer will select healthy instance at random to distribute traffic to instances within and managed by the instance group manager.

This load balancer offers multi-region load balancing, directing traffic to the closest healthy backend that has capacity and terminates HTTP(S) traffic as close as possible to the users.

This module is set up to allow or enable HTTP to HTTPS redirect, forcing HTTPS traffic to be sent to the backend service.
* This behavior is set by default, however to disable the HTTP to HTTPS redirect behavior, you can set `enable_redirect` and `enable_http` to `false`.

For testing purposes, the variable `create_self_signed_cert` can be set to `true` to enable the creation and use of a self-signed certificate (*do not use in production*) if one is not yet created or available to use for HTTPS and SSL/TLS connections.


### Resources Created

* Global Static Address
* Global Forwarding Rule
* HTTPS Target Proxy
* URL Map
* Backend Service

* ##### HTTP to HTTPS Redirect
  * Global Forwarding Rule (on HTTP port 80)
  * HTTP Target Proxy
  * URL Map (Forces redirect to HTTPS backend service)

### Outputs
* Compute Global Address
