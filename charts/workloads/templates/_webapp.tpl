{{- define "workloads.webapp" -}}
apiVersion: deployments.plural.sh/v1alpha1
kind: ServiceDeployment
metadata:
  name: {{ .Values.workspace }}-{{ .name }}
spec:
  version: 0.0.1
  namespace: {{ .Release.Namespace }}
  {{ if .Values.access }}
  bindings: 
  {{ toYaml .Values.access | nindent 4 }}
  {{ end }}
  git:
    folder: helm-values
    ref: main
  repositoryRef:
    kind: GitRepository
    name: {{ .Values.gitRepository }}
    namespace: infra
  helm:
    version: "0.x.x"
    chart: webapp
    valuesFiles:
    - {{ .name }}.webapp.values.yaml
    repository:
      namespace: infra
      name: workloads
  clusterRef:
    kind: Cluster
    name: {{ .Values.cluster }}
    namespace: infra
{{- end -}}