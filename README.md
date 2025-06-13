# IaC Challenge: DEUNA!

Infraestructura como Código (IaC) para **DEUNA!**: KMS, S3, Aurora PostgreSQL y Secrets Manager, escrita en **Terraform ≥ 1.5**.

---

### Solución a los primeros retos del challenge

Consulta [`doc/DEUNA.md`](doc/DEUNA.md) para ver la propuesta detallada sobre:

* Monitoreo del escalamiento de servicios ECS
* Monitoreo de costos por transacciones AWS

Este README se centra en la parte **práctica**: cómo clonar, parametrizar y desplegar.
## Requisitos

| Herramienta | Versión mínima              |
| ----------- | --------------------------- |
| Terraform   | 1.5                         |
| macOS/Linux | o WSL/Windows               |

---

## Configuración rápida

1. **Clonar repo**

```bash
git clone https://github.com/Bzaid94/iac-deuna.git
cd iac-deuna
```

## Validar

```bash
terraform init
terraform validate
```
---
