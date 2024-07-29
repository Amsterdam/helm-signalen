# Signalen backend Helm chart

The backend Helm chart installs the Signalen API and the by default the following dependencies using subcharts:

- PostgreSQL
- RabbitMQ
- Elasticsearch

## Configuration

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `tags.postgresql` | Install PostgreSQL subchart | `true` |
| `tags.rabbitmq` | Install RabbitMQ subchart | `true` |
| `tags.elasticsearch` | Install Elasticsearch subchart | `true` |
| `image.repository` | The repository of the Docker image | `signalen/frontend` |
| `image.tag` | The tag of the Docker image | `latest` |
| `replicaCount` | The number of API replicas | `1` |
| `workerReplicaCount` | The number of background worker replicas | `1` |
| `uwsgi.processes` | The number of uWSGI processes | `4` |
| `uwsgi.threads` | The number of uWSGI threads | `2` |
| `celery.concurrency` | The number of Celery concurrent child processes | `2` |
| `celery.loglevel` | The loglevel of Celery | `WARNING` |
| `flower.enabled` | Enable real-time Celery monitoring tool | `false` |
| `persistence.media.enabled` | Enable persistence of media | `true` |
| `persistence.media.enabledOnWorker` | Enable persistence of media on worker | `false` |
| `persistence.media.size` | Specify the size of the media PVC | `1Gi` |
| `persistence.media.existingClaim` | Name of an existing PVC to use | `null` |
| `persistence.media.accessModes` | The accessModes of media | `{ ReadWriteOnce }` |
| `persistence.media.storageClassName` | The storageClassName of media | `""` |
| `persistence.datawarehouse.enabled` | Enable persistence of datawarehouse | `false` |
| `persistence.datawarehouse.enabledOnWorker` | Enable persistence of media on datawarehouse | `true` |
| `persistence.datawarehouse.size` | Specify the size of the datawarehouse PVC | `1Gi` |
| `persistence.datawarehouse.existingClaim` | Name of an existing PVC to use for datawarehouse | `null` |
| `persistence.datawarehouse.accessModes` | The accessModes of datawarehouse | `{ ReadWriteMany }` |
| `persistence.datawarehouse.storageClassName` | The storageClassName of datawarehouse | `""` |
| `existingSecret` | Name of an existing secret to avoid managing secrets through Helm | `null` |
| `extraVolumes` | Ability to add exta volumes | `[]` |
| `extraVolumeMounts` | Ability to add exta volume mounts | `[]` |
| `envFrom` | Additional environment variables mounted from [secrets](https://kubernetes.io/docs/concepts/configuration/secret/#using-secrets-as-environment-variables) or [config maps](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables). | `[]` |
| `env` | Additional environment variables passed directly to containers. | `{}` |
| `envVars` | Similar to env but with support for all possible configurations. | `[]` |
| `managementCommands` | Run management commands post-install and post-upgrade | `""` |
| `settings.secretKey` | The secret key of the backend | `change-to-something-secret` |
| `settings.allowedHosts` | Restrict the allowed hosts of the API | `*` |
| `settings.defaultPdokMunicipalities` | A (comma-seperated) list of [PDOK municipalities](https://www.pdok.nl/introductie/-/article/cbs-wijken-en-buurten) the API allows complaints for (e.g. `"Amsterdam,'s-Hertogenbosch"`) | `""` |
| `settings.environment` | The environment name. Can be acceptance or production. | `"production"` |
| `settings.organizationName` | The name of the organization | `"Signalen"` |
| `settings.defaultFromEmail` | The default from e-mail | `"webmaster@localhost"` |
| `settings.apiTransformSourceBasedOnReporter` | Transform the source of a complaint when a complaint comes from a particular e-mail domain | `false` |
| `settings.apiTransformSourceBasedOnReporterSource` | The source to transform to when a complaint comes from a particular e-mail domain | `"Internal"` |
| `settings.apiTransformSourceBasedOnReporterDomainExtensions` | The (comma-seperated) list of e-mail domains to automatically transform the source for | `"@localhost"` |
| `settings.apiTransformSourceBasedOnReporterExceptions` | Do not transform the source automatically for these e-mail addresses | `"ignore@localhost"` |
| `settings.apiPdfLogoStaticFile` | Link to PDF logo on local system | `"api/logo-gemeente-amsterdam.svg"` |
| `settings.jwksUrl` | The JWKS url of the OpenID Connect Identity Provider | `""` |
| `settings.userIdField` | The JWKS url of the OpenID Connect Identity Provider | `""` |
| `settings.email.hostname` | The hostname of the SMTP server for e-mail notifications | `""` |
| `settings.email.port` | The port of the SMTP server | `""` |
| `settings.email.useTLS` | Use TLS while connecting to the SMTP server | `false` |
| `settings.email.useSSL` | Use SSL while connecting to the SMTP server | `false` |
| `settings.email.restEndpoint` | The REST endpoint when using REST backend | `""` |
| `settings.email.restEndpointClientCert` | The path to the client certificate when using REST backend | `""` |
| `settings.email.restEndpointClientKey` | The path to the client key when using REST backend | `""` |
| `settings.celeryEmailBackend` | The e-mail backend to use (SMTP or REST) | `django.core.mail.backends.smtp.EmailBackend` |
| `settings.frontendUrl` | The URL of the frontend | `""` |
| `settings.classificationEndpoint` | Use SSL while connecting to the SMTP server | `https://api.data.amsterdam.nl/signals_mltool` |
| `settings.enablePublicGeoSignalEndpoint` | Enable public endpoint for viewing Signals | `false` |
| `settings.allowInvalidAddressAsUnverified` | Allow a backoffice employee to enter an unknown address | `true` |
| `settings.excludedPermissionsInResponses` | sia_ permissions to hide from backoffice settings page | `sia_delete_attachment_of_normal_signal, sia_delete_attachment_of_parent_signal, sia_delete_attachment_of_child_signal, sia_delete_attachment_of_other_user` |
| `settings.systemMailFeedbackReceivedEnabled` | Send email on reception of feedback | `false` |
| `settings.reporterMailHandledNegativeContactEnabled` | Allow transition VERZOEK_TOT_HEROPENEN to AFGEHANDELD to send a mail to reporter  | `false` |
| `settings.signalHistoryLogEnabled` | Enable new-style history log | `false` |
| `sigmax.enabled` | Enable the connection with Sigmax City Control | `false` |
| `sigmax.serverUrl` | The server URL of Sigmax | `` |
| `sigmax.authToken` | The token to authenticate with Sigmax | `` |
| `ingress.enabled` | Expose the API through an ingress | `true` |
| `ingress.annotations` | Additional annotations on the API ingress | `{}` |
| `ingress.hosts` | The hosts of the ingress | `{}` |
| `ingress.tls` | The TLS settings of the ingress | `{}` |

Check [values.yaml](./values.yaml) for all the possible configuration options.
