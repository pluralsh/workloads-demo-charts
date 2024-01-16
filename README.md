# workloads-demo-charts

These are some base charts for setting up a way to provision self-service workloads for users. The structure is basically 3 charts right now:

* webapp - simple single pod webapp
* cron - a basic cron job w/ config
* workloads - wrapper that creates instances of the other two based on its helm values

The workloads uses a helm multi-source deployment to lock down configuration. In this way, the values file for each workload can be safely sourced from an external repo and core configuration managed by a platform team, eliminating risk of perverse consequences.