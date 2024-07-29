{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "signals-backend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "signals-backend.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "signals-backend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "signals-backend.labels" -}}
helm.sh/chart: {{ include "signals-backend.chart" . }}
{{ include "signals-backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "signals-backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "signals-backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "signals-backend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "signals-backend.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}


{{- define "signals-backend.migrate" -}}
  {{- printf "%s-migrate" (include "signals-backend.fullname" .) -}}
{{- end -}}

{{- define "signals-backend.elasticsearch-index" -}}
  {{- printf "%s-elasticsearch-index" (include "signals-backend.fullname" .) -}}
{{- end -}}

{{- define "signals-backend.celery-worker" -}}
  {{- printf "%s-celery-worker" (include "signals-backend.fullname" .) -}}
{{- end -}}

{{- define "signals-backend.celery-beat" -}}
  {{- printf "%s-celery-beat" (include "signals-backend.fullname" .) -}}
{{- end -}}

{{- define "signals-backend.celery-flower" -}}
  {{- printf "%s-celery-flower" (include "signals-backend.fullname" .) -}}
{{- end -}}
