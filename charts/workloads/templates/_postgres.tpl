{{- define "workloads.postgres" -}}
apiVersion: deployments.plural.sh/v1alpha1
kind: ServiceDeployment
metadata:
  name: {{ .Values.workspace }}-{{ .name }}
spec:
  namespace: {{ .Release.Namespace }}
  bindings:
  {{ if .Values.access.write }}
    write:
    {{ toYaml .Values.access.write | nindent 6 }}
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
    chart: postgres
    valuesFiles:
    - {{ .name }}.postgres.values.yaml
    repository:
      namespace: infra
      name: workloads
  clusterRef:
    kind: Cluster
    name: {{ .Values.cluster }}
    namespace: infra
{{- end -}}