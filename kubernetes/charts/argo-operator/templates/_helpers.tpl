{{- define "argo-operators.catalogName" -}}
{{ .Release.Name }}-catalog
{{- end }}

{{- define "argo-operators.subscritionName" -}}
{{ .Release.Name }}-operator
{{- end }}

{{- define "argo-operators.subscriptionSourceNamespace" -}}
{{ if .Values.catalog.enabled -}}
{{ .Values.catalog.publisher }}
{{- else -}}
olm
{{- end }}
{{- end }}

{{- define "argo-operators.subscriptionSourceName" -}}
{{ if .Values.catalog.enabled -}}
{{ include "argo-operators.catalogName" . }}
{{- else -}}
operatorhubio-catalog
{{- end }}
{{- end }}
