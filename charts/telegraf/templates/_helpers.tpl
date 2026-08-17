{{/* Expand the chart name. */}}
{{- define "telegraf.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Create a fully qualified application name. */}}
{{- define "telegraf.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/* Chart label value. */}}
{{- define "telegraf.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Common labels. */}}
{{- define "telegraf.labels" -}}
helm.sh/chart: {{ include "telegraf.chart" . }}
{{ include "telegraf.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Immutable selector labels. */}}
{{- define "telegraf.selectorLabels" -}}
app.kubernetes.io/name: {{ include "telegraf.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Environment ConfigMap name. */}}
{{- define "telegraf.envConfigMapName" -}}
{{- if .Values.envConfigMap.existingName -}}
{{- .Values.envConfigMap.existingName -}}
{{- else if .Values.envConfigMap.create -}}
{{- printf "%s-env" (include "telegraf.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- required "envConfigMap.existingName is required when envConfigMap.create is false" .Values.envConfigMap.existingName -}}
{{- end -}}
{{- end }}

{{/* Environment Secret name. */}}
{{- define "telegraf.envSecretName" -}}
{{- if .Values.envSecret.existingName -}}
{{- .Values.envSecret.existingName -}}
{{- else if .Values.envSecret.create -}}
{{- printf "%s-secrets" (include "telegraf.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- required "envSecret.existingName is required when envSecret.create is false" .Values.envSecret.existingName -}}
{{- end -}}
{{- end }}

{{/* ServiceAccount used by the Telegraf pods. */}}
{{- define "telegraf.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "telegraf.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end }}
