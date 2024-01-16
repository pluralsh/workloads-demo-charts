{{- define "workloads.cron" -}}
apiVersion: deployments.plural.sh/v1alpha1
kind: ServiceDeployment
metadata:
  name: {{ .name }}
spec:
  version: 0.0.1
  namespace: {{ .Release.Namespace }}
  git:
    folder: helm-values
    ref: main
  repositoryRef:
    kind: GitRepository
    name: {{ .Values.gitRepository }}
    namespace: infra
  helm:
    version: "0.x.x"
    chart: cron
    valuesFiles:
    - {{ .name }}.cron.values.yaml
    repository:
      namespace: infra
      name: workloads
  clusterRef:
    kind: Cluster
    name: {{ .Values.cluster }}
    namespace: infra
{{- end -}}