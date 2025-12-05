# devops-challenge

Este repositorio presenta una solución integral al desafío DevOps solicitado por Tenpo, integrando infraestructura como código, contenedores, Kubernetes, automatización continua y seguridad basada en herramientas de Application Security Testing (AST). Con base en la información disponible, se diseña una arquitectura privada, reproducible y escalable, acompañada de pipelines que incorporan análisis estático, dinámico y escaneo de dependencias e imágenes.

## 1. Arquitectura

La propuesta se estructura en una red privada del proveedor cloud, con un clúster Kubernetes privado, una base de datos relacional accesible solo por IP interna y una aplicación web que procesa solicitudes entrantes mediante HTTPS, registra los eventos y persiste los datos recibidos.

La aplicación escribe todos sus pasos en logs estándar, los cuales son recolectados por los agentes del proveedor cloud (GCP Logging o Azure Monitor). El diseño soporta un crecimiento estimado de tráfico de 10x mediante un HorizontalPodAutoscaler.

## 2. Infraestructura como Código

Todo el aprovisionamiento se realiza mediante Terraform:

- VPC privada con subredes internas.
- Kubernetes privado (AKS o GKE según el proveedor elegido).
- Base de datos PostgreSQL privada.
- Configuración de redes, rangos e interconexiones.

Se incluye escaneo de seguridad en el pipeline mediante **Checkov** y validaciones sintácticas.

## 3. Aplicación

La aplicación recibe solicitudes por HTTPS, registra cada paso realizado y escribe los datos en la base de datos. El archivo `main.py` ejemplifica el flujo operativo de manera simple y verificable en entorno local.

Se provee Dockerfile y manifiestos Kubernetes para Deployment, Service, Ingress y HPA.

## 4. Seguridad AST

La solución integra:

### ✔ SAST  
Sonar Scanner analiza el código fuente para detectar inyecciones, uso de secretos, errores lógicos y patrones inseguros.

### ✔ SCA  
OWASP Dependency-Check revisa paquetes y librerías, alertando sobre vulnerabilidades conocidas.

### ✔ DAST  
OWASP ZAP ejecuta un escaneo dinámico sobre un entorno desplegado (staging o local) para detectar riesgos de exposición.

### ✔ Containers / Golden Images  
Trivy analiza:
- La imagen de la aplicación.
- Las imágenes base corporativas.

### ✔ Infraestructura IaC Security  
Checkov detecta configuraciones inseguras en Terraform.

## 5. Pipeline CI/CD (GitLab)

El archivo `.gitlab-ci.yml` integra:
- Validación Terraform.
- Seguridad IaC.
- SAST (Sonar).
- SCA (Dependency-Check).
- Escaneo de contenedores (Trivy).
- DAST (ZAP).
- Build con Kaniko.
- Despliegue a Kubernetes (manual).

## 6. Limitaciones del Entorno

El proyecto está preparado para despliegue real en GCP/Azure.  
Debido a la ausencia de cuentas personales, la validación se realizó en clúster local (Minikube/Kind).  
El código está completamente funcional y solo requiere credenciales del proveedor para aplicar los recursos.

---

Para ejecutar localmente:
cd app
pip install -r requirements.txt
python main.py

Para desplegar en Minikube:

minikube start
kubectl apply -f k8s/

---

Esta solución está lista para ser evaluada y replicada en cualquier entorno cloud compatible.
