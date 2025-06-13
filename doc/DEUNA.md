# DEUNA! 2.0

# Objetivo
Brindar como Cloud Engineer las soluciones de mejores prácticas para los escenarios presentados por el equipo.

## Escenarios
### Monitoreo del escalamiento
#### Recursos:

1. Envío de métricas de ECS a CloudWatch
    - Cada servicio ECS Insights genera métricas dentro de los task por servicio como:
        - DesiredTaskCount: número deseado de tareas para un ECS
        - RunningTaskCount: número de tareas que actualmente tienen el estado RUNNING
        - PendingTaskCount: número de tareas que actualmente tienen el estado PENDING

2. Según la herramienta externa que se usa se puede:
    - DataDog - Ofrece una integracion con AWS
    - Grafana - integracion con datasource cloudwatch
    - Otras herramientas que permitan la integración  de ingesta de métricas
#### Creación de alertas

1. Se necesita ingestar las metricas RunningTaskCount y el límite MaximumTaskCount, agregando una condición de tiempo para evitar falsos positivos, un valor podría ser 5min, 10min.

```shell
runningTask == maximumTask
```

2. Automatización 
	- El valor maximumTask, debe mantenerse actualizado para cada ECS
	- Puede guardarse el valor en un Tag dentro del recurso ECS así siempre se reflejara el valor preciso y auditable

3. Configuración de notificaciones
	- Las alertas deben integrarse con los canales oficiales de comunicación (Slack, Teams, Correo, Webhooks)
	- Se define el mensaje de alerta 
		- Nombre del servicio afectado
		- Hora
		- Enlace al dashboard para una revisión rápida

4. Ante una alerta
	- Al obtener una alerta debe tener algun procedimiento 
	- Validar los recursos disponibles en el clúster del ECS
	- Determinar si es necesario aumentar el límite, optimizar la aplicación
	- Documentar la acción tomada para referencia y mejora continua

5. Seguridad
	- Siempre es recomendable usar el principio de menor privilegio en el role IAM cuando se exporten las métricas y logs
	- Una revisión periódicamente de las politicas de escalado

### Monitoreo de costos de transacciones

#### Recursos

1. Tags
	- AWS Ofrece a todos los servicios etiquetado de recursos
	- Se pueden utilizar estos tags para poder identificar y filtrar por dichos tags en el Cost Explorer
	- Estos tags pueden tener como nombre:
		- TransactionType
		- TransactionName
		- CostCenter
	 - Estos tags también pueden definirse desde Iac (Terraform/CloudFormation):
	 
```hcl
resource "aws_rds_cluster" "aurora_pg" {
  cluster_identifier = "deuna-aurora-cluster"
  
  tags = {
    Environment      = var.environment
    platform         = "s3"
    TransactionType  = "Monetaria"
    TransactionName  = "Recarga"
    CostCenter       = "DeunaFinance"
  }
}
```
2. Habilitación AWS Cost Allocation
    - Desde AWS Billing, se debe habilitar los Cost Allocation Tags, para poder reflejar en el reporte de costos

3. Uso Cost Explorer
    - Desde Cost Explorer se puede segmentar/filtrar el gasto por los tags definidos
    - Se puede habilitar acceso a la API de Cost Explorer para poder consultar, extraer reportes automáticamente

4. Cálculo automático o automatización de reportes
    - Creación de un Lambda programado
        - Consulta la API de Cost Explorer
        - Extrae los costos por tag/servicio/periodo
        - Calcula el costo unitario por tipo de transacción
        - Almacena o envía el reporte por email