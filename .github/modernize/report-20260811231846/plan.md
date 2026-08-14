# Modernization Plan

## Scope and source
- Assessment report: `report-20260811231846`
- Project: `CatalogoFilmes`
- Detected language: `Java`
- Target runtime: Azure-ready Java LTS

## Selected modernization categories
1. Database Migration (MySQL): Migrate to Azure Database for MySQL
2. Containerization: Containerize Java Application for Container Readiness
3. Session Management (HTTP Session): Migrate Other Cache Solutions to Azure Managed Redis
4. Hardcoded Credential: Remove Hardcoded Credentials
5. Local Resource Access (Localhost): Migrate the Local Resource to Azure
6. Remote Communication (Hardcoded Urls): Check hardcoded URLs
7. Default Encoding: Check Encoding in the Code
8. Java Version Upgrade: Upgrade Java Version

## Plan objective
Modernize the Java web application so it is cloud-ready for Azure hosting, reduces configuration drift, removes hardcoded secrets and local-only dependencies, and upgrades the runtime to a supported Java LTS version.

## Tasks

### 1) Database Migration (MySQL)
- Migrate the application data layer from local or embedded MySQL connectivity to Azure Database for MySQL.
- Update JDBC configuration, credentials, firewall/network rules, and connection pooling settings.
- Validate application startup, schema access, and data integrity after migration.

### 2) Containerization
- Create a production-ready Dockerfile for the Java application.
- Ensure the app builds in a containerized environment and exposes the expected runtime ports.
- Prepare the project for Azure Container Apps or another Azure container host.

### 3) Session Management (HTTP Session)
- Replace or externalize in-memory HTTP session storage with Azure Managed Redis.
- Configure session serialization, TTL, and sticky session considerations for Azure-hosted deployment.
- Verify login and user flow continuity after session migration.

### 4) Hardcoded Credential Removal
- Remove database credentials and secrets from source code.
- Move secret configuration to Azure-managed settings with environment variables or managed identity patterns.
- Validate no plain-text credentials remain in source, build artifacts, or deployment configuration.

### 5) Local Resource Access Migration
- Replace localhost-bound database and local service dependencies with Azure-hosted equivalents.
- Update DAO configuration to target managed Azure services instead of local endpoints.
- Validate network connectivity, DNS resolution, and failover behavior in Azure.

### 6) Remote Communication / Hardcoded URLs
- Replace hardcoded application URLs with configuration-driven values.
- Externalize endpoints for internal service calls and navigation targets.
- Confirm the app behaves correctly across environments without code changes.

### 7) Default Encoding Review
- Review servlet and request/response handling to ensure UTF-8 encoding is explicitly configured.
- Standardize character encoding in Java web application components and templates.
- Validate non-ASCII content and user-generated input behavior.

### 8) Java Version Upgrade
- Upgrade the Maven/Java project to a supported Azure-ready LTS Java version.
- Verify compile-time and runtime compatibility, framework constraints, and deployment settings.
- Update the build configuration and release pipeline as needed.

## Execution order
1. Remove hardcoded credentials and replace localhost dependencies.
2. Update Java version and compatibility settings.
3. Migrate data and session dependencies to Azure services.
4. Containerize and validate app startup in Azure-compatible runtime.
5. Externalize URLs and encoding settings.
6. Perform final smoke validation and deployment readiness review.

## Success criteria
- Application builds successfully with the upgraded Java runtime.
- No hardcoded credentials remain in application source files.
- MySQL connectivity points to Azure Database for MySQL.
- Session state is backed by Azure Managed Redis.
- Container build runs successfully and is ready for Azure hosting.
- All hardcoded URLs and encoding issues have been addressed.
