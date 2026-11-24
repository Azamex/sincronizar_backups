#!/bin/bash
# ==============================================================================
# SCRIPT DE SINCRONIZACIÓN DE COPIAS DE SEGURIDAD (RSYNC)
# ==============================================================================
# Origen: Servidor A -> Ruta: /home/examen801/backupsihtam/
# Destino: Servidor B (172.233.206.75) -> Ruta: /home/examen801/backupsihtam/
# ==============================================================================

# --- CONFIGURACIÓN ---
# Directorio local en el Servidor A
DIRECTORIO_LOCAL="/home/examen801/backupsihtam/"

# Datos del Servidor B (Destino)
USER_DESTINO="examen801"
IP_DESTINO="172.233.206.75"

# Directorio de destino en el Servidor B (Modificado)
DIRECTORIO_DESTINO="/home/examen801/backupsihtam/"

# Archivo de registro (Log)
LOG_FILE="/home/examen801/sincronizacion_backups.log"

# --- EJECUCIÓN ---
echo "=====================================================================" >> "$LOG_FILE"
echo "Iniciando sincronización: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"

# Comprobar si el directorio local existe
if [ ! -d "$DIRECTORIO_LOCAL" ]; then
    echo "ERROR: El directorio local $DIRECTORIO_LOCAL no existe." >> "$LOG_FILE"
    exit 1
fi

# Ejecución de Rsync
rsync -avz --delete "$DIRECTORIO_LOCAL" "${USER_DESTINO}@${IP_DESTINO}:${DIRECTORIO_DESTINO}" >> "$LOG_FILE" 2>&1

if [ $? -eq 0 ]; then
    echo "Sincronización completada EXITOSAMENTE a las $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
else
    echo "ERROR: Falló la sincronización a las $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG_FILE"
fi
echo "=====================================================================" >> "$LOG_FILE"
