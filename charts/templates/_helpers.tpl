{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "penpot-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "penpot-helm.fullname" -}}
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
{{- define "penpot-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "penpot-helm.labels" -}}
helm.sh/chart: {{ include "penpot-helm.chart" . }}
app.kubernetes.io/name: {{ include "penpot-helm.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "penpot-helm.frontendSelectorLabels" -}}
app.kubernetes.io/name: {{ include "penpot-helm.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "penpot-helm.backendSelectorLabels" -}}
app.kubernetes.io/name: {{ include "penpot-helm.name" . }}-backend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{- define "penpot-helm.exporterSelectorLabels" -}}
app.kubernetes.io/name: {{ include "penpot-helm.name" . }}-exporter
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "penpot-helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "penpot-helm.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
